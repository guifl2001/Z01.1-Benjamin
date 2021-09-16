library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 

entity Shifter16 is
	port(
		a:         in STD_LOGIC_VECTOR(15 downto 0);   -- entrada
        sel:         in STD_LOGIC_VECTOR(1 downto 0);    -- Seleciona se será um shift left, right ou não haverá shift.
		q:           out STD_LOGIC_VECTOR(15 downto 0)   -- Saida
	);
end entity;

architecture rtl of Shifter16 is
  -- Aqui declaramos sinais (fios auxiliares)
  -- e componentes (outros módulos) que serao
  -- utilizados nesse modulo.

begin
    with sel select
        q <=    std_logic_vector(shift_left(signed(a), 1)) when "01",   -- Realiza o logical left shift.
                std_logic_vector(shift_right(signed(a), 1)) when "10",  -- Reliza o logical right shift.
                a when others;                                          -- Nao realiza nenhum shift.

end architecture;
