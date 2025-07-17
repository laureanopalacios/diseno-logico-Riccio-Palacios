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
 
architecture rtl of decode is
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
 
end architecture;

