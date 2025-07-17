library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
 
entity IR is
	Port (
    	clk     : in  std_logic;
    	reset   : in  std_logic; 
    	we      : in  std_logic;                  	-- señal de escritura
    	input   : in  std_logic_vector(15 downto 0);  -- entrada de datos
    	output  : out std_logic_vector(15 downto 0)   -- salida del registro
	);
end IR_Register;
 
architecture IR_Architecture of IR is
	signal reg_data : std_logic_vector(15 downto 0);
begin
	process(clk, reset)
	begin
    	if reset = '1' then
        	reg_data <= (others => '0');
    	elsif rising_edge(clk) then
        	if we = '1' then
            	reg_data <= input;
        	end if;
    	end if;
	end process;
 
	output <= reg_data;
end IR_Architecture;
