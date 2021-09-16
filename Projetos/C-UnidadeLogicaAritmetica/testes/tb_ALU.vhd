-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: tb_ALU.vhd
-- date: 4/4/2017

library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_ALU is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_ALU is

component ALU is
	port (
			x,y:   in STD_LOGIC_VECTOR(15 downto 0); -- entradas de dados da ALU
			zx:    in STD_LOGIC;                     -- zera a entrada x
			nx:    in STD_LOGIC;                     -- inverte a entrada x
			zy:    in STD_LOGIC;                     -- zera a entrada y
			ny:    in STD_LOGIC;                     -- inverte a entrada y
			selx:  in STD_LOGIC_VECTOR(1 downto 0);  -- Seletor do shift do x ("01" para left shift, "10" para right shift, e o resto nao realiza shift).
			sely:  in STD_LOGIC_VECTOR(1 downto 0);  -- Seletor do shift do y ("01" para left shift, "10" para right shift, e o resto nao realiza shift).
			f:     in STD_LOGIC_VECTOR(1 downto 0);  -- Calcula x & y quando f = "00", x + y quando "01" e x xor Y quando "10", shift x quando "11" senao shift y.
			no:    in STD_LOGIC;                     -- inverte o valor da saída
			zr:    out STD_LOGIC;                    -- setado se saída igual a zero
			ng:    out STD_LOGIC;                    -- setado se saída é negativa
			cof:   out STD_LOGIC;                    -- Flag de carry overflow, '1' quando há carry overflow, caso contrario '0'.
			saida: out STD_LOGIC_VECTOR(15 downto 0) -- saída de dados da ALU
	);
end component;

   signal  inX, inY : STD_LOGIC_VECTOR(15 downto 0);
   signal  inZX, inNX, inZY, inNY, inNO, outZR, outNG, outCof : STD_LOGIC;
   signal  inSx, inSy, inF : STD_LOGIC_VECTOR(1 downto 0);
   signal  outSaida : STD_LOGIC_VECTOR(15 downto 0);

begin

	mapping: ALU port map(
    x  => inX,
    y  => inY,
    zx => inZx,
    nx => inNx,
    zy => inZy,
    ny => inNy,
    selx => inSx,
    sely => inSy,
    f  => inF,
    no => inNo,
    zr => outZr,
    ng => outNg,
    cof => outCof,
    saida => outsaida);

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

      -- Teste: 1
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inSx <= "00"; inSy <= "00";
      inZX <= '1'; inNX <= '0'; inZY <= '1'; inNY <= '0'; inF <= "01"; inNO <= '0';
      wait for 100 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000" and outCof = '0')  report "Falha em teste: 1" severity error;

      -- Teste: 2
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '1'; inNY <= '1'; inF <= "01"; inNO <= '1';
      -- existe overflow do carry.
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000000001" and outCof = '1')  report "Falha em teste: 2" severity error;

      -- Teste: 3
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '1'; inNY <= '0'; inF <= "01"; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111" and outCof = '0')  report "Falha em teste: 3" severity error;

      -- Teste: 4
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '1'; inNY <= '1'; inF <= "00"; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000")  report "Falha em teste: 4" severity error;

      -- Teste: 5
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= "00"; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 5" severity error;

      -- Teste: 6
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= "00"; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 6" severity error;

      -- Teste: 7
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '1'; inNY <= '1'; inF <= "00"; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 7" severity error;

      -- Teste: 8
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= "00"; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000")  report "Falha em teste: 8" severity error;

      -- Teste: 9
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '1'; inNY <= '1'; inF <= "01"; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000" and outCof = '0')  report "Falha em teste: 9" severity error;

      -- Teste: 10
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= "01"; inNO <= '1';
      wait for 200 ps;
      -- Existe overflow no carry
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000000001" and outCof = '1')  report "Falha em teste: 10" severity error;

      -- Teste: 11
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '1'; inZY <= '1'; inNY <= '1'; inF <= "01"; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000000001" and outCof = '1')  report "Falha em teste: 11" severity error;

      -- Teste: 12
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '1'; inF <= "01"; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000")  report "Falha em teste: 12" severity error;

      -- Teste: 13
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '1'; inNY <= '1'; inF <= "01"; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111" and outCof = '0')  report "Falha em teste: 13" severity error;

      -- Teste: 14
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= "01"; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111110" and outCof = '1')  report "Falha em teste: 14" severity error;

      -- Teste: 15
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '0'; inNY <= '0'; inF <= "01"; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111" and outCof = '0')  report "Falha em teste: 15" severity error;

      -- Teste: 16
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= "01"; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000000001" and outCof = '1')  report "Falha em teste: 16" severity error;

      -- Teste: 17
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '0'; inNY <= '1'; inF <= "01"; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111" and outCof = '0')  report "Falha em teste: 17" severity error;

      -- Teste: 18
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '0'; inNY <= '0'; inF <= "00"; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000")  report "Falha em teste: 18" severity error;

      -- Teste: 19
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '1'; inZY <= '0'; inNY <= '1'; inF <= "00"; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 19" severity error;

      -- Teste: 20 - operação xor
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '1'; inZY <= '0'; inNY <= '1'; inF <= "10"; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 20" severity error;

      -- Teste: 21 - operação xor
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '0'; inZY <= '0'; inNY <= '0'; inF <= "10"; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 21" severity error;

      -- Teste: 22 - operação xor
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '1'; inZY <= '1'; inNY <= '1'; inF <= "10"; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000")  report "Falha em teste: 22" severity error;

      -- Teste: 23 - operação xor
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '1'; inNY <= '0'; inF <= "10"; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 23" severity error;

      -- Teste: 24 - operação xor
      inX <= "1111111111111111"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '1'; inNY <= '0'; inF <= "10"; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 24" severity error;

      -- Teste: 25 - operação shift left
      inX <= "1111111111111111"; inY <= "0000000000000000";
      inZX <= '0'; inNX <= '0'; inZY <= '0'; inNY <= '1'; inF <= "00"; inNO <= '0';
      inSx <= "01"; inSy <= "01";
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111110")  report "Falha em teste: 25" severity error;

      -- Teste: 26 - operação shift left
      inX <= "1111111111111111"; inY <= "0000000000000000";
      inZX <= '1'; inNX <= '0'; inZY <= '0'; inNY <= '0'; inF <= "00"; inNO <= '0';
      inSx <= "01"; inSy <= "01";
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000")  report "Falha em teste: 26" severity error;

      -- Teste: 27 - operação shift left
      inX <= "1011111111111111"; inY <= "1011111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '0'; inNY <= '0'; inF <= "00"; inNO <= '0';
      inSx <= "01"; inSy <= "01";
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0111111111111110")  report "Falha em teste: 27" severity error;

      -- Teste: 28 - operação shift right
      inX <= "1111111111111111"; inY <= "0000000000000000";
      inZX <= '0'; inNX <= '0'; inZY <= '0'; inNY <= '1'; inF <= "00"; inNO <= '0';
      inSx <= "10"; inSy <= "10";
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 28" severity error;

      -- Teste: 29 - operação shift right
      inX <= "1111111111111111"; inY <= "0000000000000000";
      inZX <= '1'; inNX <= '0'; inZY <= '0'; inNY <= '0'; inF <= "00"; inNO <= '0';
      inSx <= "10"; inSy <= "10";
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000")  report "Falha em teste: 29" severity error;

      -- Teste: 30 - operação shift right
      inX <= "1111111111111101"; inY <= "1111111111111101";
      inZX <= '0'; inNX <= '0'; inZY <= '0'; inNY <= '0'; inF <= "00"; inNO <= '0';
      inSx <= "10"; inSy <= "10";
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111110")  report "Falha em teste: 30" severity error;

    test_runner_cleanup(runner); -- Simulacao acaba aqui

  end process;
end architecture;
