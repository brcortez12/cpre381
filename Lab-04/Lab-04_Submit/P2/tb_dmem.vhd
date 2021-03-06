library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_dmem is
	generic(
	data : natural := 32;
        addr : natural := 10;
        gCLK_HPER : time := 25 ns);
end tb_dmem;

architecture behavior of tb_dmem is

constant cCLK_PER  : time := gCLK_HPER * 2;

component mem
    generic(DATA_WIDTH : natural := 32;
            ADDR_WIDTH : natural := 10);
    port(clk		: in std_logic;
            addr : in std_logic_vector((ADDR_WIDTH-1) downto 0);
            data : in std_logic_vector((DATA_WIDTH-1) downto 0);
            we : in std_logic := '1';
            q : out std_logic_vector((DATA_WIDTH -1) downto 0));
end component;

signal s_Clk, s_we : std_logic;
signal s_addr : std_logic_vector((addr-1) downto 0);
signal s_data, s_q : std_logic_vector((data-1) downto 0);

begin

dmem: mem
    port map(clk  => s_Clk,
        addr  => s_addr,
        data  =>s_data,
        we  => s_we,
        q  => s_q);
		   
P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
P_TB: process
  begin
    
    s_we  <= '0';           --Read address x0 and write to x100
    s_addr  <= "0000000000";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '1';
    s_addr  <= "0100000000";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x1 and write to x101
    s_addr  <= "0000000001";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '1';
    s_addr  <= "0100000001";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x2 and write to x102
    s_addr  <= "0000000010";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '1';
    s_addr  <= "0100000010";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x3 and write to x103
    s_addr  <= "0000000011";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '1';
    s_addr  <= "0100000011";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x4 and write to x104
    s_addr  <= "0000000100";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '1';
    s_addr  <= "0100000100";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x5 and write to x105
    s_addr  <= "0000000101";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '1';
    s_addr  <= "0100000101";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x6 and write to x106
    s_addr  <= "0000000110";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '1';
    s_addr  <= "0100000110";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x7 and write to x107
    s_addr  <= "0000000111";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '1';
    s_addr  <= "0100000111";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x8 and write to x108
    s_addr  <= "0000001000";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '1';
    s_addr  <= "0100001000";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x9 and write to x109
    s_addr  <= "0000001001";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '1';
    s_addr  <= "0100001001";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x100
    s_addr  <= "0100000000";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x101
    s_addr  <= "0100000001";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x102
    s_addr  <= "0100000010";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x103
    s_addr  <= "0100000011";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x104
    s_addr  <= "0100000100";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x105
    s_addr  <= "0100000101";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x106
    s_addr  <= "0100000110";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x107
    s_addr  <= "0100000111";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x108
    s_addr  <= "0100001000";
    s_data <= s_q;
    wait for cCLK_PER;

    s_we  <= '0';           --Read address x109
    s_addr  <= "0100001001";
    s_data <= s_q;
    wait for cCLK_PER;

    wait;
  end process;
  
end behavior;