library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_n_bit_full_adder is
	generic(
	N: integer := 32);
end tb_n_bit_full_adder;

architecture behavior of tb_n_bit_full_adder is

component n_bit_full_adder_data
  generic(N : integer := 32);
  port(i_aA          : in std_logic_vector(N-1 downto 0);
       i_bB          : in std_logic_vector(N-1 downto 0);
       i_Cin          : in std_logic;
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Cout_overflowbit          : out std_logic);

end component;

component n_bit_full_adder
  generic(N : integer := 32);
  port(i_aA          : in std_logic_vector(N-1 downto 0);
       i_bB          : in std_logic_vector(N-1 downto 0);
       i_Cin          : in std_logic;
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Cout_overflowbit          : out std_logic);

end component;

-- Signals for the mux modules
signal s_A, s_B, s_S, s_SD : std_logic_vector(N-1 downto 0);
signal s_C, s_O, s_OD : std_logic;

begin

DUT_struct: n_bit_full_adder
  port map(i_aA  => s_A,
		i_bB  => s_B,
		i_Cin  => s_C,
  	        o_Sum  => s_S,
		o_Cout_overflowbit => s_O);
DUT_data: n_bit_full_adder_data
  port map(i_aA  => s_A,
		i_bB  => s_B,
		i_Cin  => s_C,
  	        o_Sum  => s_SD,
		o_Cout_overflowbit => s_OD);

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    s_A<=x"00000000";
    s_B<=x"00000000";
    s_C<='0';
    assert s_S = s_SD report "Each adder returns the same sum.";
    assert s_O = s_OD report "Each adder returns the same carryout bit.";
    wait for 100 ns;

    s_A<=x"00000011";
    assert s_S = s_SD report "Each adder returns the same sum.";
    assert s_O = s_OD report "Each adder returns the same carryout bit.";
    wait for 100 ns;

    s_B<=x"00000001";
    assert s_S = s_SD report "Each adder returns the same sum.";
    assert s_O = s_OD report "Each adder returns the same carryout bit.";
    wait for 100 ns;


    s_C<='1';
    assert s_S = s_SD report "Each adder returns the same sum.";
    assert s_O = s_OD report "Each adder returns the same carryout bit.";
    wait for 100 ns;

    s_A<=x"11111111";
    s_B<=x"00000000";
    s_C<='0';
    assert s_S = s_SD report "Each adder returns the same sum.";
    assert s_O = s_OD report "Each adder returns the same carryout bit.";
    wait for 100 ns;

    s_C<='1';
    assert s_S = s_SD report "Each adder returns the same sum.";
    assert s_O = s_OD report "Each adder returns the same carryout bit.";
    wait for 100 ns;

  end process;
  
end behavior;