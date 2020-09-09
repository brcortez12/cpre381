library IEEE;
use IEEE.std_logic_1164.all;

entity n_bit_mux_data is
  generic(N : integer := 14);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       i_S          : in std_logic;
       o_F          : out std_logic_vector(N-1 downto 0));

end n_bit_mux_data;

architecture dataflow of n_bit_mux_data is
begin

o_F <= i_A when i_S = '0' else
       i_B;

end dataflow;










