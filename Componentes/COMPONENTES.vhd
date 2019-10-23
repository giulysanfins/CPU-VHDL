LIBRARY ieee;
Use ieee.std_logic_1164.all;


PACKAGE COMPONENTES is 

	
		component register16bits IS
		port (input: in std_logic_vector(0 to 15);
			clock: in std_logic;
			reset: in std_logic;
			enable: in std_logic;
			output: out std_logic_vector(0 to 15));
	end component;
	
	component tristate IS
		port (input: in std_logic_vector(0 to 15);
			ctrl: in std_logic;
			output: out std_logic_vector(0 to 15));
	end component;
	
	component ULA IS
		PORT ( aluop : IN STD_LOGIC_VECTOR(0 TO 2) ; --aluop
			A, B : IN STD_LOGIC_VECTOR(0 TO 15) ;--operandos
			SAIDA : OUT STD_LOGIC_VECTOR(0 TO 15) ) ;--saida
	end component;
	
	component UC IS
		port ( Instrucao: in std_logic_vector(0 to 15);
				Clock: in std_logic;
            reg0out, reg0in: out std_logic;
            reg1out, reg1in: out std_logic;
            reg2out, reg2in: out std_logic;
            reg3out, reg3in: out std_logic;
            regAUX: out std_logic;
            auxBin, auxBout: out std_logic;
			auxCin, auxCout: out std_logic;
			LIin: out std_logic;
			Aluop: out std_logic_vector(0 to 2));
	end component;

END COMPONENTES;