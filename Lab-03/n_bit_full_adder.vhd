library IEEE;
use IEEE.std_logic_1164.all;

entity n_bit_full_adder is
  generic(N : integer := 14);
  port(i_aA          : in std_logic_vector(N-1 downto 0);
       i_bB          : in std_logic_vector(N-1 downto 0);
       i_Cin          : in std_logic;
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Cout_overflowbit          : out std_logic);

end n_bit_full_adder;

architecture structure of n_bit_full_adder is

component andg2

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component org2

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component xorg2

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

-- signals for gate outputs
signal x1, a1, a2 : std_logic_vector(N-1 downto 0);
-- signal for carry bit
signal carry : std_logic_vector(N downto 0);
begin

carry(0) <= i_Cin;

G2: for i in 0 to N-1 generate
xor1_i: xorg2 port map (i_A => i_aA(i), i_B => i_bB(i), o_F => x1(i));
xor2_i: xorg2 port map (i_A => x1(i), i_B => carry(i), o_F => o_Sum(i));
and1_i: andg2 port map (i_A => carry(i), i_B => x1(i), o_F => a1(i));
and2_i: andg2 port map (i_A => i_aA(i), i_B => i_bB(i), o_F => a2(i));
or1_i: org2 port map (i_A => a1(i), i_B => a2(i), o_F => carry(i+1));
end generate;
o_Cout_overflowbit <= carry(N);
end structure;