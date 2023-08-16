library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_ARITH.all;
use IEEE.std_logic_UNSIGNED.all;

entity ALU is
port(pc_i : in std_logic_vector(15 downto 0);
	  pc_o : out std_logic_vector(15 downto 0);
	  imm :  in std_logic_vector(15 downto 0);
	  ALU_c1 : in std_logic_vector(3 downto 0);
	  ALU_c2 : in std_logic_vector(3 downto 0);	
	  ALU_fi : in std_logic_vector(1 downto 0);
	  ALU_fo : out std_logic_vector(1 downto 0);
	  ALU_i1 : in std_logic_vector(15 downto 0); 
	  ALU_i2 : in std_logic_vector(15 downto 0); 
	  ALU_o1 : out std_logic_vector(15 downto 0);
	  status : out std_logic); 
end entity;

architecture BEHAVIOR1 of ALU is	 

	signal buff1 : std_logic_vector(15 downto 0);
	signal status_buff : std_logic := '0';

begin

	process(ALU_c1,ALU_c2,ALU_fi,ALU_i1,ALU_i2,pc_i,buff1,imm,status_buff)
	begin

		if ALU_c1 = "0001" then
			if ALU_c2 = "00" then 
				ALU_o1 <= ALU_i1 + ALU_i2;
				ALU_fo <= "00";
				status_buff <= '1';
			elsif ALU_c2 = "10" then
				if Alu_fi(1) = '1' then
					ALU_o1 <= ALU_i1 + ALU_i2;
					ALU_fo <= "10";
					status_buff <= '1';
				end if;
			elsif ALU_c2 = "01" then
				if Alu_fi(0) = '1' then
					ALU_o1 <= ALU_i1 + ALU_i2;
					ALU_fo <= "01";
					status_buff <= '1';
				end if;	
			elsif ALU_c2 = "11" then
				buff1(0) <= '0';
				buff1(1) <= ALU_i2(0);
				buff1(2) <= ALU_i2(1);
				buff1(3) <= ALU_i2(2);
				buff1(4) <= ALU_i2(3);
				buff1(5) <= ALU_i2(4);
				buff1(6) <= ALU_i2(5);
				buff1(7) <= ALU_i2(6);
				buff1(8) <= ALU_i2(7);
				buff1(9) <= ALU_i2(8);
				buff1(10) <= ALU_i2(9);
				buff1(11) <= ALU_i2(10);
				buff1(12) <= ALU_i2(11);
				buff1(13) <= ALU_i2(12);
				buff1(14) <= ALU_i2(13);
				buff1(15) <= ALU_i2(14);
				ALU_o1 <= ALU_i1 + buff1;
				ALU_fo <= "11";
				status_buff <= '1';
			end if;
		elsif ALU_c1 = "0001" then
			if ALU_c2 = "00" then
				ALU_o1 <= ALU_i1 nand ALU_i2;
				ALU_fo <= "00";
				status_buff <= '1';
			elsif ALU_c2 = "10" then
				if ALU_fi(1) = '1' then
					ALU_o1 <= ALU_i1 nand ALU_i2;
					ALU_fo <= "10";
					status_buff <= '1';
				end if;
			elsif ALU_c2 = "01" then
				if ALU_fi(0) = '1' then
					ALU_o1 <= ALU_i1 nand ALU_i2;
					ALU_fo <= "01";
					status_buff <= '1';
				end if;
			end if;
		elsif ALU_c1 = "1000" then
			if  ALU_i1 = ALU_i2 then
				pc_o <= pc_i + imm;
				status_buff <= '1';
			end if;
		elsif ALU_c1 = "1001" then
			pc_o <= pc_i + imm;
			ALU_o1 <= pc_i + "0000000000000001";
			status_buff <= '1';
		elsif ALU_c1 = "1010" then
			pc_o <= ALU_i1;
			ALU_o1 <= pc_i + "0000000000000001";
			status_buff <= '1';
		elsif ALU_c1 = "1011" then	
			pc_o <= ALU_i1 + imm;
			status_buff <= '1';
		elsif ALU_c1 = "0101" then
			ALU_o1 <= ALU_i1 + ALU_i2;	
			status_buff <= '1';
		elsif ALU_c1 = "0111" then
			ALU_o1 <= ALU_i1 + ALU_i2;	
			status_buff <= '1';
		end if;	
		status <= status_buff;
		end process;
		
end architecture;