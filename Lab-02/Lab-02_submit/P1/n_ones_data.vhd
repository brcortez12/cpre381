library IEEE;
use IEEE.std_logic_1164.all;

entity n_ones_data is
  generic(N : integer := 14);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));

end n_ones_data;

architecture dataflow of n_ones_data is
begin

  o_F <= not i_A;
  
end dataflow;