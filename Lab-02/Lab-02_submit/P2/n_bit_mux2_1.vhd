library IEEE;
use IEEE.std_logic_1164.all;

entity n_bit_mux2_1 is
  generic(N : integer := 14);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       i_S          : in std_logic;
       o_F          : out std_logic_vector(N-1 downto 0));

end n_bit_mux2_1;

architecture structure of n_bit_mux2_1 is

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
signal a1, a2 : std_logic_vector(N-1 downto 0);
signal n1 : std_logic;

begin

--Create single selector bit
U1: invg port map (i_A => i_S, o_F => n1);

G1: for i in 0 to N-1 generate
  and1_i: andg2 port map (i_A => i_A(i), i_B => i_S, o_F => a1(i));
  and2_i: andg2 port map (i_A => i_B(i), i_B => n1, o_F => a2(i));
  or_i: org2 port map (i_A => a1(i), i_B => a2(i), o_F => o_F(i));
end generate;

end structure;
