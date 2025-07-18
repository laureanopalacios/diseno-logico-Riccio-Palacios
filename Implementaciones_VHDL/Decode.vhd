library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity decode is
	port (
    	instr 	: in  std_logic_vector(7 downto 0);  -- IR[15..8]
    	alu_op	: out std_logic_vector(2 downto 0);
    	regO_we   : out std_logic;
    	regs_we   : out std_logic;
    	regA_we   : out std_logic;
    	in_sel	: out std_logic;
    	inm_sel   : out std_logic;
    	reg_sel   : out std_logic
	);
end entity;


architecture decode_Concurrente of decode is
	begin

		regO_we <= (not instr(4)) AND (not instr(2)) AND instr(1) AND (not instr(0));

		regs_we <= instr(5) OR instr(4) OR ((not instr(2)) AND instr(0));
		
		regA_we <= (not instr(4)) AND (instr(2));
		
		in_sel <= (not instr(5)) AND (not instr(4)) AND (not instr(2)) AND (not instr(1)) AND instr(0);

		inm_sel <= instr(2) AND instr(0);

		reg_sel <= (not instr(5)) OR (not instr(4)) OR (instr(1) OR (not instr(5)) AND (not instr(0)));

		--ALU: una función para cada bit

		alu_op(0) <= instr(5) OR (instr(4)) AND (not(instr(0)))

		alu_op(1) <= instr(5) OR (instr(4)) AND ( ((not(instr(1))) AND (not(instr(0)))) OR (not(instr(2)) AND instr(0)) )

		alu_op(2) <= instr(5) OR (instr(4)) AND ( (not(instr(2))) AND instr(0)
											 	OR (not(instr(2))) AND instr(1) AND (not(instr(0)))
											 	OR instr(2) AND (not(instr(1))) AND (not(instr(0)))
											 )
	
end architecture decode_Concurrente;


architecture decode_secuencial of decode is
begin
 
	process(instr)
	begin
    	-- Valores por defecto
    	alu_op   <= "000";
    	regO_we  <= '0';
    	regs_we  <= '0';
    	regA_we  <= '0';
    	in_sel   <= '0';
    	inm_sel  <= '0';
    	reg_sel  <= '1';
 
    	case instr is
        	when "00000001" =>  -- IN
            	regs_we <= '1';
            	in_sel  <= '1';
            	reg_sel <= '0';
 
        	when "00000010" =>  -- OUT
            	regO_we <= '1';
            	reg_sel <= '1';
 
        	when "00000011" =>  -- MOV
            	regs_we <= '1';
            	reg_sel <= '1';
 
        	when "00000100" =>  -- LDA
            	regA_we <= '1';
            	reg_sel <= '1';
 
        	when "00000101" =>  -- LDI
            	regA_we  <= '1';
            	inm_sel  <= '1';
            	reg_sel  <= '0';
 
        	when "00010000" =>  -- ADD
            	alu_op   <= "010";
            	regs_we  <= '1';
            	reg_sel  <= '1';
 
        	when "00010001" =>  -- SUB
            	alu_op   <= "011";
            	regs_we  <= '1';
            	reg_sel  <= '1';
 
        	when "00010010" =>  -- AND
            	alu_op   <= "100";
            	regs_we  <= '1';
            	reg_sel  <= '1';
 
        	when "00010011" =>  -- OR
            	alu_op   <= "101";
            	regs_we  <= '1';
            	reg_sel  <= '1';
 
        	when "00010100" =>  -- XOR
            	alu_op   <= "110";
            	regs_we  <= '1';
            	reg_sel  <= '1';
 
        	when "00100000" | "00100001" =>  -- SHL, SHR
            	regs_we  <= '1';
            	reg_sel  <= '1';
 
        	when others =>  -- default: todo en cero
            	null;
    	end case;
		
	end process;
 
end architecture decode_secuencial;

