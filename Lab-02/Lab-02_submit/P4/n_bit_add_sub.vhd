library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity n_bit_add_sub is
  generic (N : integer := 32);
  port(i_X	: in std_logic_vector(N-1 downto 0);
       i_Y	: in std_logic_vector(N-1 downto 0);
       nAdd_Sub	: in std_logic;
       o_Val	: out std_logic_vector(N-1 downto 0);
       o_Cout	: out std_logic);
end n_bit_add_sub;

architecture structure of n_bit_add_sub is

component n_ones_comp
  generic (N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));
end component;

component n_bit_mux2_1
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       i_S          : in std_logic;
       o_F          : out std_logic_vector(N-1 downto 0));
end component;

component n_bit_full_adder
  generic(N : integer := 32);
  port(i_aA          : in std_logic_vector(N-1 downto 0);
       i_bB          : in std_logic_vector(N-1 downto 0);
       i_Cin          : in std_logic;
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Cout_overflowbit          : out std_logic);
end component;

--signal for ones compliment
signal comp : std_logic_vector(N-1 downto 0);
--signal for input to full adder
signal s_Z : std_logic_vector(N-1 downto 0);

begin

U1: n_ones_comp port map (i_A => i_Y, o_F => comp);
U2: n_bit_mux2_1 port map (i_A => i_Y, i_B => comp, i_S => nAdd_Sub, o_F => s_Z);
U3: n_bit_full_adder port map (i_aA => i_X, i_bB => s_Z, i_Cin => nAdd_Sub, o_Sum => o_Val, o_Cout_overflowbit => o_Cout);

end structure;
