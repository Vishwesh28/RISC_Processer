library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_ARITH.all;
use IEEE.std_logic_UNSIGNED.all;

entity Mini_Comp is
port(inst : in std_logic_vector(15 downto 0);
	  Oprnd_o1 : out std_logic_vector(15 downto 0); 
	  Oprnd_o2 : out std_logic_vector(15 downto 0);
	  Oprnd_imm_o :  out std_logic_vector(15 downto 0)); 
end entity;

architecture BEHAVIOR1 of Mini_Comp is	
 
	signal optn : std_logic_vector(3 downto 0);
	signal rf_1,rf_2 ,rf_3: std_logic_vector(2 downto 0);
	signal imm_1 : std_logic_vector(5 downto 0);
	signal imm_2 : std_logic_vector(8 downto 0);
	
	component Register_File 
		port(eord : in std_logic; endc_i1 : in std_logic_vector(2 downto 0); endc_o1 : out std_logic_vector(15 downto 0); endc_i2 : in std_logic_vector(15 downto 0));
	end component;

begin
	
	process(inst)
	begin	
	   optn <= inst(15 downto 12);
		rf_3 <= inst(11 downto 9);
		rf_1 <= inst(8 downto 6);
		rf_2 <= inst(5 downto 3);
		imm_1 <= inst(5 downto 0);
		imm_2 <= inst(8 downto 0);
		if optn = "0001" then
			RF_instl1 : Register_File
				port map(eord=>'1' , endc_i1=>rf_1 , endc_o1=>Oprnd_o1 , endc_i2=>"0000000000000000");
			RF_instl2 : Register_File
				port map(eord=>'1' , endc_i1=>rf_2 , endc_o1=>Oprnd_o2 , endc_i2=>"0000000000000000");
			Oprnd_imm_o <= "0000000000000000";
		elsif optn = "0010" then
			RF_instl1 : Register_File
				port map(eord=>'1' , endc_i1=>rf_1 , endc_o1=>Oprnd_o1 , endc_i2=>"0000000000000000");
			RF_instl2 : Register_File
				port map(eord=>'1' , endc_i1=>rf_2 , endc_o1=>Oprnd_o2 , endc_i2=>"0000000000000000");
			Oprnd_imm_o <= "0000000000000000";
		elsif optn = "0101" then
			RF_instl1 : Register_File
				port map(eord=>'1' , endc_i1=>rf_1 , endc_o1=>Oprnd_o1 , endc_i2=>"0000000000000000");
			Oprnd_o2(15 downto 6)  <= "0000000000"
			Oprnd_o2(5 downto 0) <= imm_1;
			Oprnd_imm_o <= "0000000000000000";
		elsif optn = "0111" then
			RF_instl1 : Register_File
				port map(eord=>'1' , endc_i1=>rf_1 , endc_o1=>Oprnd_o1 , endc_i2=>"0000000000000000");
			Oprnd_o2(15 downto 6)  <= "0000000000"
			Oprnd_o2(5 downto 0) <= imm_1;
			Oprnd_imm_o <= "0000000000000000";
		elsif optn = "1101" then
			RF_instl1 : Register_File
				port map(eord=>'1' , endc_i1=>rf_3 , endc_o1=>Oprnd_o1 , endc_i2=>"0000000000000000");
			Oprnd_o2 <= "0000000000000000";
			Oprnd_imm_o <= "0000000000000000";
		elsif optn = "1100" then
			RF_instl1 : Register_File
				port map(eord=>'1' , endc_i1=>rf_3 , endc_o1=>Oprnd_o1 , endc_i2=>"0000000000000000");
			Oprnd_o2 <= "0000000000000000";
			Oprnd_imm_o <= "0000000000000000";
		elsif optn = "1000" then
			RF_instl1 : Register_File
				port map(eord=>'1' , endc_i1=>rf_3 , endc_o1=>Oprnd_o1 , endc_i2=>"0000000000000000");
			RF_instl2 : Register_File
				port map(eord=>'1' , endc_i1=>rf_1 , endc_o1=>Oprnd_o2 , endc_i2=>"0000000000000000");
			Oprnd_imm_o(5 downto 0) <= imm_1;
			Oprnd_imm_o(15 downto 6) <= "0000000000";
		elsif optn = "1001" then
			Oprnd_o1 <= "0000000000000000";
			Oprnd_o2 <= "0000000000000000";
			Oprnd_imm_o(15 downto 9) <= "0000000";
		   Oprnd_imm_o(8 downto 0) <= imm_2;
		elsif optn = "1010" then
			RF_instl1 : Register_File
				port map(eord=>'1' , endc_i1=>rf_3 , endc_o1=>Oprnd_o1 , endc_i2=>"0000000000000000");
			RF_instl2 : Register_File
				port map(eord=>'1' , endc_i1=>rf_1 , endc_o1=>Oprnd_o2 , endc_i2=>"0000000000000000");
			Oprnd_imm_o <= "0000000000000000";
		elsif optn = "1011" then 
			RF_instl1 : Register_File
				port map(eord=>'1' , endc_i1=>rf_3 , endc_o1=>Oprnd_o1 , endc_i2=>"0000000000000000");
			Oprnd_imm_o(15 downto 9) <= "0000000";
		   Oprnd_imm_o(8 downto 0) <= imm_2;
			Oprnd_o2 <= "0000000000000000";
		end if;	
	end process;
	
		
end architecture;