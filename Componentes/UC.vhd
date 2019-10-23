library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY UC IS
	PORT (	Instrucao: in std_logic_vector(0 to 15);
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
      
           
END UC;

ARCHITECTURE Behavior OF UC IS
	TYPE State_type IS (DECOD, mov0, movi0, xchg0, xchg1, xchg2, arit0, arit1, arit2); -- defindo os Estados
	SIGNAL current_state : State_type := DECOD;
    SIGNAL request: std_logic_vector(0 to 3);
	signal r1, r2: std_logic_vector(0 to 1);
BEGIN
	request <= Instrucao(0 to 3);
	r1 <= Instrucao(4 to 5);
	r2 <= Instrucao(6 to 7);
	PROCESS (Clock)
	BEGIN
		if(Clock'EVENT AND Clock = '0')THEN
            CASE current_state IS
						WHEN DECOD =>
								reg0in <= '0';
								reg0out <= '0';
								reg1in <= '0';
								reg1out <= '0';
								reg2in <= '0';
								reg2out <= '0';
								reg3in <= '0';
								reg3out <= '0';
								regAUX <= '0';
								auxBin <= '0';
								auxBout <= '0';
								auxCin <= '0';
								auxCout <= '0';
								LIin <= '0';
								CASE request is -- opcode
										WHEN "0000" => current_state <= arit0;--add
										WHEN "0001" => current_state <= arit0;--addi
										WHEN "0010" => current_state <= arit0;--sub
										WHEN "0011" => current_state <= arit0;--subi
										WHEN "0100" => current_state <= arit0;--and
										WHEN "0101" => current_state <= arit0;--andi
										WHEN "0110" => current_state <= arit0;--or
										WHEN "0111" => current_state <= arit0;--ori
										WHEN "1000" => current_state <= mov0;
										WHEN "1001" => current_state <= movi0;
										WHEN "1010" => current_state <= xchg0;
										when others => current_state <= DECOD;
										
							end case;
					WHEN mov0 =>--====================Mov Ri,Rj===========================
						case r1 is 
							when "00" => reg0in <= '1';
							when "01" => reg1in <= '1';
							when "10" => reg2in <= '1';
							when "11" => reg3in <= '1';
							when others => current_state <= DECOD;
						end case;
						case r2 is
							when "00" => reg0out <= '1';
							when "01" => reg1out <= '1';
							when "10" => reg2out <= '1';
							when "11" => reg3out <= '1';
							when others => current_state <= DECOD;
						end case;
						current_state <= DECOD;
						
					WHEN movi0=> --=============mov RI, Imed =================
						LIin <= '1';
						case r1 is 
							when "00" => reg0in <= '1';
							when "01" => reg1in <= '1';
							when "10" => reg2in <= '1';
							when "11" => reg3in <= '1';
							when others => current_state <= DECOD;
						end case;
						current_state <= DECOD;
						
					WHEN xchg0 => --============xchg RI,RJ ===========
						auxCin <= '1';
						case r1 is
								when "00" => reg0out <= '1';
								when "01" => reg1out <= '1';
								when "10" => reg2out <= '1';
								when "11" => reg3out <= '1';
								when others => current_state <= DECOD;
						end case;
						current_state <= xchg1;
					WHEN xchg1 =>
							auxCin <= '0';	
							reg0out <= '0';
							reg1out <= '0';
							reg2out <= '0';
							reg3out <= '0';
							case r1 is
									when "00" => reg0in <= '1';
									when "01" => reg1in <= '1';
									when "10" => reg2in <= '1';
									when "11" => reg3in <= '1';
									when others => current_state <= DECOD ;
							end case;	
							case r2 is 
									when "00" => reg0out <= '1';
									when "01" => reg1out <= '1';
									when "10" => reg2out <= '1';
									when "11" => reg3out <= '1';
									when others => current_state <= DECOD ;
							end case;
							current_state <= xchg2;
					WHEN xchg2 =>
							auxCout <= '1';
							case r1 is 
								when "00" => reg0in <= '0';
								when "01" => reg1in <= '0';
								when "10" => reg2in <= '0';
								when "11" => reg3in <= '0';
								when others => current_state <= DECOD ;
							end case;
							reg0out <= '0';
							reg1out <= '0';
							reg2out <= '0';
							reg3out <= '0';
							case r2 is 
								when "00" => reg0in <= '1';
								when "01" => reg1in <= '1';
								when "10" => reg2in <= '1';
								when "11" => reg3in <= '1';
								when others => current_state <= DECOD ;
							end case;
							current_state <= DECOD;
							
					WHEN arit0 => --===============Aritimeticas=====================
						regAUX <= '1';
						case r1 is 
							when "00" => reg0out <= '1';
							when "01" => reg1out <= '1';
							when "10" => reg2out <= '1';
							when "11" => reg3out <= '1';
							when others => current_state <= DECOD;
							
						end case;
						current_state <= arit1;
						
					WHEN arit1 =>	
						regAUX <= '0';
						reg0out <= '0';
						reg1out <= '0';
						reg2out <= '0';
						reg3out <= '0';
						
						if(request(3) = '0') THEN
							case r2 is
								when "00" => reg0out <= '1';
								when "01" => reg1out <= '1';
								when "10" => reg2out <= '1';
								when "11" => reg3out <= '1';
								when others => current_state <= DECOD;
							end case;
						else
						
							LIin <= '1';
						
						end if;
						case request is 
								when "0000" => ALUOp <= "000";
								when "0001" => ALUOp <= "000";
								when "0010" => ALUOp <= "001";
								when "0011" => ALUOp <= "001";
								when "0100" => ALUOp <= "010";
								when "0101" => ALUOp <= "010";
								when "0110" => ALUOp <= "011";
								when "0111" => ALUOp <= "011";
								when others => ALUOp <= "ZZZ";
							--ULA <= "0000"
						end case;
						auxBin <= '1';
						current_state <= arit2;
						
					WHEN arit2 =>
						reg0out <= '0';
						reg1out <= '0';
						reg2out <= '0';
						reg3out <= '0';
						auxBin <= '0';
						LIin <= '0';
						case r1 is
								when "00" => reg0in <= '1';
								when "01" => reg1in <= '1';
								when "10" => reg2in <= '1';
								when "11" => reg3in <= '1';
								when others => current_state <= DECOD;
						end case;
						auxBout <= '1';				
						current_state <= DECOD;
						
						WHEN others =>
							current_state <= DECOD;
						
				END case;
			END IF;
		END PROCESS;
		END Behavior;