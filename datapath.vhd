library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_ARITH.all;
use IEEE.std_logic_UNSIGNED.all;

entity fsm is
	port(clk : in std_logic;
		pc : in std_logic_vector(15 downto 0));
end entity;

architecture archi of fsm is

	signal state, next_state: std_logic_vector(3 downto 0);
	signal instr : std_logic_vector(15 downto 0);
	signal op_code: std_logic_vector(3 downto 0);
	signal sig_mem_write_bar: std_logic := '0';
	signal sig_data_in: std_logic_vector(15 downto 0) := (others => '0');
	signal sig_oprnd1:std_logic_vector(15 downto 0) := (others => '0');
	signal sig_oprnd2:std_logic_vector(15 downto 0) := (others => '0');
	signal sig_oprndimm:std_logic_vector(15 downto 0) := (others => '0');
	signal sig_rf_d3:std_logic_vector(15 downto 0) := (others => '0');
	signal sig_alu_to_r7:std_logic_vector(15 downto 0) := (others => '0');
	signal sig_t2_to_r7:std_logic_vector(15 downto 0) := (others => '0');
	signal sig_pc_to_r7:std_logic_vector(15 downto 0) := (others => '0');
	signal sig_r7_wr:std_logic_vector := '0';
	signal sig_r7_wr_mux:std_logic_vector(1 downto 0):="00");
	
	component Mem is 
		port (mem_write_bar: in std_logic;
		  address: in std_logic_vector(15 downto 0);
		  data_in: in std_logic_vector(15 downto 0);
		  data_out: out std_logic_vector(15 downto 0));
	end component;
	
	component RegFile is
		port (
			 CLK ,reset: in std_logic;
			 rf_a1, rf_a2, rf_a3 : in std_logic_vector (2 downto 0);
			 rf_d3 : in std_logic_vector(15 downto 0);
			 rf_d1, rf_d2 : out std_logic_vector(15 downto 0);
			 alu_to_r7, t2_to_r7, pc_to_r7 : in std_logic_vector (15 downto 0);
		    rf_wr: in std_logic;
			 r7_wr_mux : in std_logic_vector(1 downto 0)
		  );
	end component;
	
	component ALU is
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

begin

	Memory : Mem port map(mem_write_bar => sig_mem_write_bar,address => pc,data_in => sig_data_in,data_out => instr);
	RegisterFile : RegFile port map(CLK => clk,reset => rst, rf_a1 => instr(11 downto 9),rf_a2 => instr(8 downto 6),rf_a3 => instr(5 downto 3),
								rf_d3 => sig_rf_d3,rf_d1 => sig_oprnd1,rf_d2 => sig_oprnd2,
								alu_to_r7 => sig_alu_to_r7,t2_to_r7 => sig_t2_to_r7,pc_to_r7 => sig_pc_to_r7.
								rf_wr => sig_r7_wr,r7_wr_mux => sig_r7_wr_mux);
								
	ALUnit : ALU port map (pc_i => pc,pc_o => 
	
	process (clk,rst)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				state <= "0000";
			else
				state <= next_state;
			end if;
		end if;
	end process;
	
	process(state,op_code)
	begin
		if state = "0000" then
			op_code <= instr(15 downto 12);
			pc <= pc+1;
			next_state <= "0001";
		elsif state = "0001" then
			if op_code = "0001" or op_code = "0010" then
				--ALU
				next_state <= "0110";
			elsif op_code = "0101" or op_code ="0111" then
				--load/Stroe
				next_state <= "0010";
			--elsif op_code = "1101" or op_code ="1100" then
				--load/store multiple
				--next_state <= "100";
			elsif op_code = "1000" then
				--branch
				next_state <= "1000";
			elsif op_code <= "1001" or op_code <= "1010"  then
				--jump and store
				next_state <= "1010";
			elsif op_code = "1011" then
				--jump
				next_state <= "0000";
			--elsif op_code = "0000" then
				--lhi
				--next_state <= "1011";
			end if;
		elsif state = "0110" then
			-- write to rf
			next_state <= "0000";
		elsif state <= "0010" then
			--compute mem addr
			if op_code <= "0101" then
				
				next_state <= "0100";
			elsif op_code = "0111" then
				next_state <= "0101";
			end if;
		end if;
			
	end process
end architecture;
		