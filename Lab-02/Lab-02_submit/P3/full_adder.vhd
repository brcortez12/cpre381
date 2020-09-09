library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is
  
  port(i_aA          : in std_logic;
       i_bB          : in std_logic;
       i_Cin          : in std_logic;
       o_Sum          : out std_logic;
       o_Cout          : out std_logic);

end full_adder;

architecture structure of full_adder is

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
signal x1, a1, a2, o1 : std_logic;

begin

U1: xorg2 port map (i_A => i_aA, i_B => i_bB, o_F => x1);
U2: xorg2 port map (i_A => x1, i_B => i_Cin, o_F => o_Sum);
U3: andg2 port map (i_A => i_Cin, i_B => x1, o_F => a1);
U4: andg2 port map (i_A => i_aA, i_B => i_bB, o_F => a2);
U5: org2 port map (i_A => a1, i_B => a2, o_F => o_Cout);
end structure;