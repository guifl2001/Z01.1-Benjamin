----------------------------
-- Bibliotecas ieee       --
----------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

----------------------------
-- Entrada e saidas do bloco
----------------------------
entity ConceitoA is
	port(
		CLOCK_50 : in  std_logic;
		SW       : in  std_logic_vector(9 downto 0);
        HEX0     : out std_logic_vector(6 downto 0); -- 7seg0
        HEX1     : out std_logic_vector(6 downto 0); -- 7seg0
        HEX2     : out std_logic_vector(6 downto 0); -- 7seg0
		LEDR     : out std_logic_vector(9 downto 0)
	);
end entity;

----------------------------
-- Implementacao do bloco --
----------------------------
architecture rtl of ConceitoA is

signal fio0 : std_logic_vector(3 downto 0);
signal fio1 : std_logic_vector(3 downto 0);
signal fio2 : std_logic_vector(3 downto 0);

--------------
-- signals
--------------
component binarioToBcd is
generic (N : integer);
  port (
        clk, reset: in std_logic;
        binary_in: in std_logic_vector(N-1 downto 0);
        bcd0, bcd1, bcd2, bcd3, bcd4: out std_logic_vector(3 downto 0)
    );
end component;

component sevenSeg is
	port (
			bcd : in  STD_LOGIC_VECTOR(3 downto 0);
			leds: out STD_LOGIC_VECTOR(6 downto 0));
end component;

---------------
-- implementacao
---------------
begin

d1: sevenSeg port map(
		bcd => fio0,  
		leds => HEX2  
	);
	
d2: sevenSeg port map(
		bcd => fio1,  
		leds => HEX1  
	);
	
d3: sevenSeg port map(
		bcd => fio2,  
		leds => HEX0 
	);

binbcd: binarioToBcd generic map(N => 10) port map(
		clk => CLOCK_50, 
		reset=> '0',
		binary_in => SW,
		bcd0 => fio0,
		bcd1 => fio1,
		bcd2 => fio2,
		bcd3 => open,
		bcd4 => open
	);
end rtl;
