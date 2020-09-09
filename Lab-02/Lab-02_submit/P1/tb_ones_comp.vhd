library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ones_comp is
	generic(
	N: integer := 32);
end tb_ones_comp;

architecture behavior of tb_ones_comp is

-- Declare the component we are going to instantiate
component n_ones_comp
  generic (N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));
end component;

component n_ones_data
  generic (N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));
end component;

-- Signals to connect to the compliment modules
signal s_A, s_C, s_D  : std_logic_vector(N-1 downto 0);

begin

DUT_struct: n_ones_comp
  port map(i_A  => s_A,
  	        o_F  => s_C);
DUT_data: n_ones_data
  port map(i_A  => s_A,
  	        o_F  => s_D);

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    s_A<=x"00000000";
    wait for 100 ns;

    s_A<=x"FFFFFFFF";
    wait for 100 ns;

    s_A<=x"0000FFFF";
    wait for 100 ns;

    s_A<=x"FFFF0000";
    wait for 100 ns;

    s_A<=x"F0F0F0F0";
    wait for 100 ns;

    s_A<=x"FF00FF00";
    wait for 100 ns;

  end process;
  
end behavior;