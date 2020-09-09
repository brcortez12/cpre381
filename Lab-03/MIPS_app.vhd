library IEEE;
use IEEE.std_logic_1164.all;
use work.vector_arr.all;

entity MIPS_app is
  generic(N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_writeEnable        : in std_logic;     -- Write Enable
       i_writeAddr          : in std_logic_vector(4 downto 0);     -- Write address input
       i_readAddr1          : in std_logic_vector(4 downto 0);     -- Read address 1 input
       i_readAddr2          : in std_logic_vector(4 downto 0);     -- Read address 2 input
       immediate    : in std_logic_vector(N-1 downto 0);
       ALUSrc	    : in std_logic;
       i_Ad_Sb	    : in std_logic);

end MIPS_app;

architecture structure of MIPS_app is

component reg_file
  generic(N : integer := 32);
  port(i_Clk        : in std_logic;     -- Clock input
       i_Rst        : in std_logic;     -- Reset input
       i_wE	    : in std_logic;	  --write enable
       i_wAddr          : in std_logic_vector(4 downto 0);     -- Write address input
       i_rAddr1          : in std_logic_vector(4 downto 0);     -- Read address 1 input
       i_rAddr2          : in std_logic_vector(4 downto 0);     -- Read address 2 input
       i_wData          : in std_logic_vector(N-1 downto 0);     -- Write data input
       o_rData1          : out std_logic_vector(N-1 downto 0);   -- Data 1 value output
       o_rData2          : out std_logic_vector(N-1 downto 0));   -- Data 2 value output
end component;

component n_bit_mux2_1
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       i_S          : in std_logic;
       o_F          : out std_logic_vector(N-1 downto 0));
end component;

component n_bit_add_sub
  generic (N : integer := 32);
  port(i_X	: in std_logic_vector(N-1 downto 0);
       i_Y	: in std_logic_vector(N-1 downto 0);
       nAdd_Sub	: in std_logic;
       o_Val	: out std_logic_vector(N-1 downto 0);
       o_Cout	: out std_logic);
end component;

signal s_d1, s_d2, s_M, s_D	: std_logic_vector(N-1 downto 0);	--outputs of the Reg_File, Mux and Adder
begin

R1: reg_file
  port map(i_Clk => i_CLK,
		i_Rst => i_RST,
		i_wE => i_writeEnable,
		i_wAddr => i_writeAddr,
		i_rAddr1 => i_readAddr1,
		i_rAddr2 => i_readAddr2,
		i_wData => s_D,
		o_rData1 => s_d1,
		o_rData2 => s_d2);

M1: n_bit_mux2_1
  port map(i_A => s_d2,
		i_B => immediate,
		i_S => ALUSrc,
		o_F => s_M);

A1: n_bit_add_sub
  port map(i_X => s_d1,
		i_Y => s_M,
		nAdd_Sub => i_Ad_Sb,
		o_Val => s_D);

end structure;












