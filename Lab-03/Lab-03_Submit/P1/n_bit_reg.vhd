library IEEE;
use IEEE.std_logic_1164.all;

entity n_bit_reg is
  generic(N : integer := 32);
  port(i_Clk        : in std_logic;     -- Clock input
       i_Rst        : in std_logic;     -- Reset input
       i_wEnable         : in std_logic;     -- Write enable input
       i_wD          : in std_logic_vector(N-1 downto 0);     -- Write data input
       o_rD          : out std_logic_vector(N-1 downto 0));   -- Data value output
       
end n_bit_reg;

architecture structure of n_bit_reg is

component dff
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

begin

-- We loop through and instantiate and connect N andg2 modules
G1: for i in 0 to N-1 generate
  dff_i: dff 
    port map(i_CLK  => i_Clk,
	     i_RST  => i_Rst,
	     i_WE  => i_wEnable,
	     i_D  => i_wD(i),
             o_Q  => o_rD(i));
end generate;

  
end structure;