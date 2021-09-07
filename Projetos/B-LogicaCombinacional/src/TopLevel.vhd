--
-- Elementos de Sistemas - Aula 5 - Logica Combinacional
-- Rafael . Corsi @ insper . edu . br
--
-- Arquivo exemplo para acionar os LEDs e ler os bottoes
-- da placa DE0-CV utilizada no curso de elementos de
-- sistemas do 3s da eng. da computacao

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
entity TopLevel is
	port(
		CLOCK_50 : in  std_logic;
		SW       : in  std_logic_vector(9 downto 0);
		A        : out std_logic
	);
end entity;

----------------------------
-- Implementacao do bloco --
----------------------------
architecture rtl of TopLevel is

--------------
-- signals
--------------

---------------
-- implementacao
---------------
begin
	-- X -> SW(0)
	-- Y -> SW(1)
	-- Z -> SW(2)
	-- node A -> X and Y 
	-- node B -> A or Y
	-- node C - > not B
	-- node D -> A nor Z
	-- Equaçao: C or D
	-- Equacao: not((X and Y) or Y) or ((X and Y) nor Z)
	A <= not((SW(0) and SW(1)) or SW(1)) or ((SW(0) and SW(1)) nor SW(2)); -- Rever dps
	
	
end rtl;
