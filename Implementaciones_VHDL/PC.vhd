library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PC is
	port (
  	     	clk   	: in std_logic;
    	rst   	: in std_logic;
    	enable   	  : in std_logic;
    	load  	: in std_logic;
    	pc_in 	: in  std_logic_vector(7 downto 0);
    	pc_out	: out  std_logic_vector(7 downto 0)
	);
end PC;
 
architecture PC_Architecture of PC is
  signal pc_reg           	: std_logic_vector(7 downto 0);
begin
  process(clk, rst)
  begin
  if rst = '1' then
                           	pc_reg <= (others => '0');
  elseif rising_edge(clk) then
  	if load = '1' then
    	pc_reg <= pc_in;
  	elseif enable = '1' then
    	pc_reg <= pc_reg + 1;
  	end if;
  end if;
end process;
 
 pc_out <= pc_reg;
end PC_Architecture;
