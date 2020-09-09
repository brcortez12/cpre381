library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity n_bit_full_adder_data is
  generic(N : integer := 14);
  port(i_aA          : in std_logic_vector(N-1 downto 0);
       i_bB          : in std_logic_vector(N-1 downto 0);
       i_Cin          : in std_logic;
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Cout_overflowbit          : out std_logic);

end n_bit_full_adder_data;

architecture dataflow of n_bit_full_adder_data is

signal s_T : std_logic_vector(N downto 0);

begin

s_T  <= std_logic_vector(signed('0' & i_aA) + signed('0' & i_bB) + signed'('0' & i_Cin));
o_Sum <= s_T(N-1 downto 0);
o_Cout_overflowbit <= s_T(N);

end dataflow;