library IEEE;
use IEEE.std_logic_1164.all;

entity n_ones_comp is
  generic(N : integer := 14);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));

end n_ones_comp;

architecture structure of n_ones_comp is

component invg
  port(i_A  : in std_logic;
       o_F  : out std_logic);
end component;

begin

-- Instantiate and connect N invg modules
G1: for i in 0 to N-1 generate
  inv_i: invg 
    port map(i_A  => i_A(i),
  	          o_F  => o_F(i));
end generate;

  
end structure;