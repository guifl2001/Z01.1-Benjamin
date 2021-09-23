-- Elementos de Sistemas
-- FlipFlopJK.vhd

library ieee;
use ieee.std_logic_1164.all;

entity FlipFlopJK is
	port(
		clock:  in std_logic;
		J:      in std_logic;
		K:      in std_logic;
		q:      out std_logic:= '0';
		notq:   out std_logic:= '1'
	);
end entity;

architecture arch of FlipFlopJK is

	signal s: std_logic:= '0';
	signal input: STD_LOGIC_VECTOR(1 downto 0);
	
begin

	input <= J & K;
	
	process(clock) begin
		if(rising_edge(clock)) then
			if input = "01" then
				s <= '0';
			elsif input = "10" then
				s <= '1';
			elsif input = "11" then
				s <= not(s);
			end if;
		end if;
	end process;
			
	q <= s;
	notq <= not s;

end architecture;
