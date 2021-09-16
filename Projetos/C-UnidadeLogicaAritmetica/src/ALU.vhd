-- Elementos de Sistemas
-- by Luciano Soares
-- ALU.vhd

-- Unidade Lógica Aritmética (ULA)
-- Recebe dois valores de 16bits e
-- calcula uma das seguintes funções:
-- X+y, x-y, y-x, 0, 1, -1, x, y, -x, -y,
-- X+1, y+1, x-1, y-1, x&y, x|y
-- De acordo com os 6 bits de entrada denotados:
-- zx, nx, zy, ny, f, no.
-- Também calcula duas saídas de 1 bit:
-- Se a saída == 0, zr é definida como 1, senão 0;
-- Se a saída <0, ng é definida como 1, senão 0.
-- a ULA opera sobre os valores, da seguinte forma:
-- se (zx == 1) então x = 0
-- se (nx == 1) então x =! X
-- se (zy == 1) então y = 0
-- se (ny == 1) então y =! Y
-- se (f == 1) então saída = x + y
-- se (f == 0) então saída = x & y
-- se (no == 1) então saída = !saída
-- se (out == 0) então zr = 1
-- se (out <0) então ng = 1

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
	port (
			x,y:   in STD_LOGIC_VECTOR(15 downto 0); -- entradas de dados da ALU
			zx:    in STD_LOGIC;                     -- zera a entrada x
			nx:    in STD_LOGIC;                     -- inverte a entrada x
			zy:    in STD_LOGIC;                     -- zera a entrada y
			ny:    in STD_LOGIC;                     -- inverte a entrada y
			selx:  in STD_LOGIC_VECTOR(1 downto 0);  -- Seletor do shift do x ("01" para left shift, "10" para right shift, e o resto nao realiza shift).
			sely:  in STD_LOGIC_VECTOR(1 downto 0);  -- Seletor do shift do y ("01" para left shift, "10" para right shift, e o resto nao realiza shift).
			f:     in STD_LOGIC_VECTOR(1 downto 0);  -- Calcula x & y quando f = "00", x + y quando "01" e x xor Y quando "10".
			no:    in STD_LOGIC;                     -- inverte o valor da saída
			zr:    out STD_LOGIC;                    -- setado se saída igual a zero
			ng:    out STD_LOGIC;                    -- setado se saída é negativa
			cof:   out STD_LOGIC;                    -- Flag de carry overflow, '1' quando há carry overflow, caso contrario '0'.
			saida: out STD_LOGIC_VECTOR(15 downto 0) -- saída de dados da ALU
	);
end entity;

architecture  rtl OF alu is
  -- Aqui declaramos sinais (fios auxiliares)
  -- e componentes (outros módulos) que serao
  -- utilizados nesse modulo.

	component zerador16 IS
		port(z   : in STD_LOGIC;
			 a   : in STD_LOGIC_VECTOR(15 downto 0);
			 y   : out STD_LOGIC_VECTOR(15 downto 0)
			);
	end component;

	component inversor16 is
		port(z   : in STD_LOGIC;
			 a   : in STD_LOGIC_VECTOR(15 downto 0);
			 y   : out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

	component Add16 is
		port(
			a   :  in STD_LOGIC_VECTOR(15 downto 0);
			b   :  in STD_LOGIC_VECTOR(15 downto 0);
			q   : out STD_LOGIC_VECTOR(15 downto 0);
			carry : out STD_LOGIC
		);
	end component;

	component And16 is
		port (
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			q:   out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

	component comparador16 is
		port(
			a   : in STD_LOGIC_VECTOR(15 downto 0);
			zr   : out STD_LOGIC;
			ng   : out STD_LOGIC
    );
	end component;

	component Mux4Way16 is
		port ( 
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			c:   in  STD_LOGIC_VECTOR(15 downto 0);
			d:   in  STD_LOGIC_VECTOR(15 downto 0);
			sel: in  STD_LOGIC_VECTOR(1 downto 0);
			q:   out STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component Shifter16 is
		port(
			a:         in STD_LOGIC_VECTOR(15 downto 0);
			sel:         in STD_LOGIC_VECTOR(1 downto 0);
			q:           out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

   SIGNAL zxout,zyout,nxout,nyout,sxout,syout,andout,adderout,xorout,muxout,precomp: std_logic_vector(15 downto 0);

begin

  -- Implementação vem aqui!

	xZerador: zerador16 port map(zx, x, zxout);
	yZerador: zerador16 port map(zy, y, zyout);

	xInverso: inversor16 port map(nx, zxout, nxout);
	yInverso: inversor16 port map(ny,zyout, nyout);

	-- Implementação do shifter.
	shifterX: Shifter16 port map(nxout, selx, sxout);
	shifterY: Shifter16 port map(nyout, sely, syout);

	-- Implementação das operações básicas.
	XandY: And16 port map(sxout, syout, andout);
	-- Add com o carry overflow implementado
	XaddY: Add16 port map(sxout, syout, adderout, cof);

	-- Implementa a operação xor entre os dois números
	xorout <= sxout xor syout;

	-- Adaptando o Mux para a nova operação (X xor Y).
	Mux4_16: Mux4Way16 port map(
		a => andout, 
		b => adderout, 
		c => xorout,
		d => "0000000000000000",   -- Apenas 3 operacoes, e 4 entradas no mux
		sel =>f, 
		q => muxout
		);

	muxInverso: inversor16 port map(no, muxout, precomp);
	comparacao: comparador16 port map(precomp, zr, ng);

	saida <= precomp;

end architecture;
