-- Elementos de Sistemas
-- CounterDown.vhd

library ieee;
use ieee.std_logic_1164.all;

entity CounterDown is
	port(
		clock:  in std_logic;
		q:      out std_logic_vector(2 downto 0) :=(others => '0')
	);
end entity;

architecture arch of CounterDown is
	signal Q_out : std_logic_vector(2 downto 0);

	component FlipFlopT is
		port(
			clock:  in std_logic;
			t:      in std_logic;
			q:      out std_logic:= '0';
			notq:   out std_logic:= '1'
		);
	end component;

begin
	
	FFT0 : FlipFlopT port map (
		clock => clock,
		t => '1',
		q => Q_out(0),
		notq => open
	);
	FFT1 : FlipFlopT port map (
		clock => Q_out(0),
		t => '1',
		q => Q_out(1),
		notq => open
	);
	FFT2 : FlipFlopT port map (
		clock => Q_out(1),
		t => '1',
		q => Q_out(2),
		notq => open
	);
	q <= Q_out;
end architecture;
