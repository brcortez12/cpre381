library IEEE;
use IEEE.std_logic_1164.all;

entity tb_n_bit_mux is
	generic(
	N: integer := 32);
end tb_n_bit_mux;

architecture behavior of tb_n_bit_mux is

component n_bit_mux2_1
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       i_S          : in std_logic;
       o_F          : out std_logic_vector(N-1 downto 0));
end component;

component n_bit_mux_data
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       i_S          : in std_logic;
       o_F          : out std_logic_vector(N-1 downto 0));
end component;

-- Signals for the mux modules
signal s_A, s_B, s_C, s_D  : std_logic_vector(N-1 downto 0);
signal s_S : std_logic;

begin

DUT_struct: n_bit_mux2_1
  port map(i_A  => s_A,
		i_B  => s_B,
		i_S  => s_S,
  	        o_F  => s_C);
DUT_data: n_bit_mux_data
  port map(i_A  => s_A,
		i_B  => s_B,
		i_S  => s_S,
  	        o_F  => s_D);

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    s_A<=x"00000000";
    s_B<=x"FFFFFFFF";
    s_S<='1';
    wait for 100 ns;

    s_S<='0';
    wait for 100 ns;

    s_B<=x"FFFF0000";
    wait for 100 ns;


    s_A<=x"F0F0F0F0";
    wait for 100 ns;

    s_S<='1';
    wait for 100 ns;

  end process;
  
end behavior;