-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_andg2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- 2-input AND gate.
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-- 1/16/19 by H3::Changed name to avoid name conflict with Quartus 
--         primitives.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

-- This is an empty entity so we don't need to declare ports
entity tb_andg2 is

end tb_andg2;

architecture behavior of tb_andg2 is

-- Declare the component we are going to instantiate
component andg2
  port(i_A  : in std_logic;
       i_B  : in std_logic;
       o_F  : out std_logic);
end component;

-- Signals to connect to the andg2 module
signal s_A, s_B, s_F  : std_logic;

begin

DUT: andg2 
  port map(i_A  => s_A,
  	        i_B  => s_B,
  	        o_F  => s_F);

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    s_A <= '0';
    s_B <= '0';
    wait for 100 ns;

    s_A <= '0';
    s_B <= '1';
    wait for 100 ns;

    s_A <= '1';
    s_B <= '0';
    wait for 100 ns;

    s_A <= '1';
    s_B <= '1';
    wait for 100 ns;


  end process;
  
end behavior;
