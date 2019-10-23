LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;
ENTITY ULA IS
	PORT ( aluop : IN STD_LOGIC_VECTOR(0 TO 2) ; --aluop
			A : IN STD_LOGIC_VECTOR(0 TO 15) ;--operandos
			B: IN STD_LOGIC_VECTOR(0 TO 15) ;
			SAIDA : OUT STD_LOGIC_VECTOR(0 TO 15) ) ;--saida
END ULA ;

ARCHITECTURE Behavior OF ULA IS
BEGIN
	PROCESS ( aluop, A, B )
	BEGIN
		CASE aluop IS 
			WHEN "000"=>
				SAIDA <=A + B; --SOMA
			WHEN "001"=>
				SAIDA <=A - B; --SUBTRAÇÃO
			WHEN "010"=>
				SAIDA <=A AND B; --AND
			WHEN "011"=>
				SAIDA <=A OR B; --OR
			WHEN others => SAIDA <= "0000000000000000";	
			
		END CASE ;
	END PROCESS ;
END Behavior ;