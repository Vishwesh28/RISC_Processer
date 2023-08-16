library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mem is
port(mem_write_bar: in std_logic;
     address: in std_logic_vector(15 downto 0);
     data_in: in std_logic_vector(15 downto 0);
     data_out: out std_logic_vector(15 downto 0));
end entity;

architecture BEHAVIOR3 of Mem is	 

	type RAM_array is array (0 to 63) of std_logic_vector (15 downto 0);
	signal RAM : RAM_array;
	
begin
	
	process(mem_write_bar, data_in, address, RAM)
   begin
      if(mem_write_bar = '0') then
        RAM(to_integer(unsigned(address)))<= data_in;
      end if;
      data_out <= RAM(to_integer(unsigned(address)));
  end process;
		
end architecture;