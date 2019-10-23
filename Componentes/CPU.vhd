LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;
USE work.COMPONENTES.all;

ENTITY CPU IS 
		PORT(
		Clock :IN STD_LOGIC;
		Input : IN STD_LOGIC_VECTOR (0 tO 15);
		busout: out std_logic_vector(15 DOWNTO 0);
		
		rg0out,rg1out,rg2out,rg3out,rgaout,rgbout,rgcout: out std_logic_vector(0 to 15);
		
		st0in,st0out,st1in,st1out,st2in,st2out,st3in,st3out,stAin,stBin,stBout,stCin,stCout: out std_logic;
		
		ulashow: out std_logic_vector(0 to 2);
		LI: out std_logic_vector(0 to 15));
		
	END CPU;
	
	
	ARCHITECTURE Behavior OF CPU IS

	
		SIGNAL BUSS: STD_LOGIC_VECTOR(15 DOWNTO 0);
		SIGNAL ALUOP: STD_LOGIC_VECTOR(0 TO 2);
		SIGNAL Reset: STD_LOGIC;
		
		SIGNAL R0in,R0out: STD_LOGIC;
		SIGNAL R1in,R1out: STD_LOGIC;
		SIGNAL R2in,R2out: STD_LOGIC;
		SIGNAL R3in,R3out: STD_LOGIC;
		SIGNAL RAUXin: STD_LOGIC;
		SIGNAL RBin,RBout: STD_LOGIC;
		SIGNAL RCin,RCout: STD_LOGIC;
		
		
		SIGNAL reg0: STD_LOGIC_VECTOR (0 TO 15);
		SIGNAL reg1: STD_LOGIC_VECTOR (0 TO 15);
		SIGNAL reg2: STD_LOGIC_VECTOR (0 TO 15);
		SIGNAL reg3: STD_LOGIC_VECTOR (0 TO 15);
		SIGNAL RAUXout: STD_LOGIC_VECTOR (0 TO 15);
		SIGNAL ULAout: STD_LOGIC_VECTOR (0 TO 15);
		SIGNAL RBtoTRS: STD_LOGIC_VECTOR (0 TO 15);
		SIGNAL RCtoTRS: STD_LOGIC_VECTOR (0 TO 15);
		
		SIGNAL Imediato: STD_LOGIC;
		SIGNAL Imedcont: STD_LOGIC_VECTOR (0 TO 15);

		BEGIN	
		
	rg0out <= reg0;
	rg1out <= reg1;
	rg2out <= reg2;
	rg3out <= reg3;
	rgaout <= RAUXout;
	rgbout <= RBtoTRS;
	rgcout <= RCtoTRS;
	
	st0out<=R0out;
	st1out <= R1out;
	st2out <= R2out;
	st3out <= R3out;
	st0in <=R0in;
	st1in<=R1in;
	st2in <= R2in;
	st3in <= R3in;
	
	stAin <= RAUXin;
	stBin <= RBin;
	stBout <= RBout;
	stCin <= RCin;
	stCout <= RCout;

	ulashow <= ALUOP;
	LI <= imedcont;
	busout <= BUSS;
	
	process (input)
		begin
		
		if (input(8) = '0') then 
			imedcont <= "00000000" & Input(8 to 15);
			
		else
		
			imedcont <= "11111111" & Input(8 to 15);
		
		end if;
		
	end process;
	
		imed: tristate port map (imedcont,Imediato,BUSS);
	
		--FLUXO DO REGISTRADOR 0
		regs0: 	register16bits port map(BUSS,Clock,Reset,R0in,reg0);
		tri0: tristate port map(reg0,R0out,BUSS);
		
		--FLUXO DO REGISTRADOR 1
		regs1:	register16bits port map(BUSS,Clock,Reset,R1in,reg1);
		tri1:	tristate port map(reg1,R1out,BUSS);
		
		--FLUXO DO REGISTRADOR 2
		regs2:	register16bits port map(BUSS,Clock,Reset,R2in,reg2);
		tri2: tristate port map (reg2,R2out,BUSS);
		
		--FLUXO DO REGISTRADOR 3
		regs3:	register16bits port map (BUSS,Clock,Reset,R3in,reg3);
		tri3:	tristate port map (reg3,R3out,BUSS);
		
		--Fluxo do Registrador AUX
		regsAUX: register16bits port map(BUSS,Clock,Reset,RAUXin,RAUXout);
		
		--Fluxo do Registrador AUX 2(B)
		regsAux2: register16bits port map(ULAout,Clock,Reset,RBin,RBtoTRS);
		triB: tristate port map (RBtoTRS,RBout,BUSS);
			
		--Fluxo do registrador AUX 3(C)
		regsAux3: register16bits port map(BUSS,Clock,Reset,RCin,RCtoTRS);
		triC: tristate port map (RCtoTRS,RCout,BUSS);
		
		
		
		--ULA
		alu: ULA port map(ALUOP,RAUXout,buss,ULAout);
		
		--Unidade de controle
		controlunit: UC port map(Input,Clock,R0out,R0in,R1out,R1in,R2out,R2in,R3out,R3in,RAUXin,RBin,RBout,RCin,RCout,Imediato,ALUOP);
		

END Behavior;
		