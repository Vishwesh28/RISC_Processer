library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_ARITH.all;
use IEEE.std_logic_UNSIGNED.all;

entity Register_File is
port(eord : in std_logic;   --Encode if 0 and Decode if 1
	  endc_i1 : in std_logic_vector(2 downto 0);
	  endc_o1 : out std_logic_vector(15 downto 0);
	  endc_i2 : in std_logic_vector(15 downto 0));
end entity;

architecture BEHAVIOR2 of Register_File is	 

	type RC_type is array (0 to 7) of std_logic_vector(15 downto 0);
	signal RC: RC_type;
	
begin
	process(eord,endc_i1,endc_i2,RC)
	begin
		if eord = '1' then
			if endc_i1 = "000" then
				endc_o1 <= RC(0);
			end if;
			if endc_i1 = "001" then
				endc_o1 <= RC(1);
			end if;
			if endc_i1 = "010" then
				endc_o1 <= RC(2);
			end if;
			if endc_i1 = "011" then
				endc_o1 <= RC(3);
			end if;
			if endc_i1 = "100" then
				endc_o1 <= RC(4);
			end if;
			if endc_i1 = "101" then
				endc_o1 <= RC(5);
			end if;
			if endc_i1 = "110" then
				endc_o1 <= RC(6);
			end if;
			if endc_i1 = "111" then
				endc_o1 <= RC(7);
			end if;	
		else 
			if endc_i1 = "000" then
				RC(0) <= endc_i2;
			end if;
			if endc_i1 = "001" then
				RC(1) <= endc_i2;
			end if;
			if endc_i1 = "010" then
				RC(2) <= endc_i2;
			end if;
			if endc_i1 = "011" then
				RC(3) <= endc_i2;
			end if;
			if endc_i1 = "100" then
				RC(4) <= endc_i2;
			end if;
			if endc_i1 = "101" then
				RC(5) <= endc_i2;
			end if;
			if endc_i1 = "110" then
				RC(6) <= endc_i2;
			end if;
			if endc_i1 = "111" then
				RC(7) <= endc_i2;
			end if;
		end if;
	end process;
		
end architecture;