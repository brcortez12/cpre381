library IEEE;
use IEEE.std_logic_1164.all;
use work.vector_arr.all;

entity reg_file is
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

end reg_file;

architecture structure of reg_file is

component decoder
  port(i_In          : in std_logic_vector(4 downto 0);
       o_F          : out std_logic_vector(31 downto 0));
end component;

component n_bit_reg
  generic(N : integer := 32);
  port(i_Clk        : in std_logic;     -- Clock input
       i_Rst        : in std_logic;     -- Reset input
       i_wEnable         : in std_logic;     -- Write enable input
       i_wD          : in std_logic_vector(N-1 downto 0);     -- Write data input
       o_rD          : out std_logic_vector(N-1 downto 0));   -- Data value output
end component;

component mux_32_1
  port( i_R	     : registers;
	i_S          : in std_logic_vector(4 downto 0);
	o_F          : out std_logic_vector(31 downto 0));
end component;

component andg2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;


signal s_E	: std_logic_vector(N-1 downto 0); --Store the various enable signals from the decoder
signal s_M	: registers; --Store the various outputs of the registers for the Muxes
signal s_Enable : std_logic_vector(N-1 downto 0);
begin

--Attach the decoder output to the write enable signal
D1: decoder
  port map(i_In => i_wAddr,
	   o_F => s_E);

--Initialize zero register

reg_0: n_bit_reg 
  port map(i_Clk  => i_CLK,
	   i_Rst  => '1',
	   i_wEnable  => '0',
	   i_wD => (others=>'0'),
	   o_rD => s_M(0));

G1: for i in 0 to N-1 generate
  and_i: andg2
    port map(i_A => s_E(i),
	     i_B => i_wE,
	     o_F => s_Enable(i));
end generate;

-- We loop through and instantiate and connect the registers
G2: for i in 1 to N-1 generate
  reg_i: n_bit_reg 
    port map(i_Clk  => i_CLK,
	     i_Rst  => i_RST,
	     i_wEnable  => s_Enable(i),
	     i_wD => i_wData,
	     o_rD => s_M(i));
end generate;

M1: mux_32_1
  port map( i_R => s_M,
	i_S => i_rAddr1,
	o_F => o_rData1);

M2: mux_32_1
  port map( i_R => s_M,
	i_S => i_rAddr2,
	o_F => o_rData2);
  
end structure;