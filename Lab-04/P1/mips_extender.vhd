library IEEE;
use IEEE.std_logic_1164.all;

entity mips_extender is
  generic(
    N : integer := 32;
    J : integer := 32/2);
  port(i_in          : in std_logic_vector(J-1 downto 0);
       i_Ctl          : in std_logic;      --unsigned when 0, signed when 1(others)
       o_F          : out std_logic_vector(N-1 downto 0));

end mips_extender;

architecture dataflow of mips_extender is

begin

with i_Ctl select
  o_F(N-1 downto J) <= (others => '0') when '0',
    (others => i_in(J-1)) when others;

o_F(J-1 downto 0) <= i_in;
end dataflow;