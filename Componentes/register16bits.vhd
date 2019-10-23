LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


ENTITY register16bits is
	PORT(input: in std_logic_vector(0 to 15);
			clock: in STD_LOGIC;
			reset: in STD_LOGIC;
			enable: in STD_LOGIC;
			output: out STD_LOGIC_VECTOR(0 TO 15));
	
	END register16bits;
	
	ARCHITECTURE Behavior OF register16bits IS
	BEGIN 
		PROCESS(clock,reset)
		BEGIN 
				if (clock'EVENT AND clock = '1' and enable = '1') THEN
				
						output <= input;
				
				END if;
				if (reset = '1') THEN
						
						output <= "0000000000000000";
						
						END if;
						
		END PROCESS;
	END Behavior;	