  
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY tristate IS
	PORT (input: in std_logic_vector(0 to 15);
			ctrl: in std_logic;
			output: out std_logic_vector(0 to 15));
END tristate;

ARCHITECTURE buf OF tristate IS
BEGIN
		PROCESS(ctrl, input)
		BEGIN
		IF (ctrl = '1') THEN
			output <= input;
		ELSE
			output <= "ZZZZZZZZZZZZZZZZ";
		END IF;
	END PROCESS;
END buf;