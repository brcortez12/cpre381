library IEEE;
use IEEE.std_logic_1164.all;

entity mux2_1 is
  
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       i_S          : in std_logic;
       o_F          : out std_logic);

end mux2_1;

architecture structure of mux2_1 is

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

component invg

  port(i_A          : in std_logic;
       o_F          : out std_logic);

end component;

-- signals for first tier ANDs and NOT outputs
signal a1, a2, n1 : std_logic;

begin

U1: invg port map (i_A => i_S, o_F => n1);
U2: andg2 port map (i_A => i_A, i_B => i_S, o_F => a1);
U3: andg2 port map (i_A => i_B, i_B => n1, o_F => a2);
U4: org2 port map (i_A => a1, i_B => a2, o_F => o_F);
end structure;