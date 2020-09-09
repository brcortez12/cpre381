library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.vector_arr.all;

entity tb_MIPS_app is
	generic(N: integer := 32;
		gCLK_HPER   : time := 50 ns);
end tb_MIPS_app;

architecture behavior of tb_MIPS_app is
  
constant cCLK_PER  : time := gCLK_HPER * 2;

component MIPS_app
  generic(N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_writeEnable        : in std_logic;     -- Write Enable
       i_writeAddr          : in std_logic_vector(4 downto 0);     -- Write address input
       i_readAddr1          : in std_logic_vector(4 downto 0);     -- Read address 1 input
       i_readAddr2          : in std_logic_vector(4 downto 0);     -- Read address 2 input
       immediate    : in std_logic_vector(N-1 downto 0);
       ALUSrc	    : in std_logic;
       i_Ad_Sb	    : in std_logic);
end component;

signal S_CLK, s_RST, s_WE, s_ALU, s_AdS  : std_logic;
signal s_WA, s_RA1, s_RA2  : std_logic_vector(4 downto 0);
signal s_IMM  : std_logic_vector(N-1 downto 0);

begin

DUT: MIPS_app
  port map(i_CLK  => S_CLK,
		   i_RST  => s_RST,
		   i_writeEnable  => s_WE,
		   i_writeAddr  => s_WA,
		   i_readAddr1  => s_RA1,
		   i_readAddr2  => s_RA2,
		   immediate  => s_IMM,
		   ALUSrc  => s_ALU,
		   i_Ad_Sb  => s_AdS);
		   
P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
P_TB: process
  begin
    -- Reset the Registers
    s_RST <= '1';
    s_WE  <= '0';
    wait for cCLK_PER;

    --  Place "1" in $1
    s_RST <= '0';
    s_WE  <= '1';
    s_WA  <= "00001";
    s_RA1 <= "00000";
    s_RA2 <= "00000";
    s_IMM <= x"00000001";
    s_ALU <= '1';
    s_AdS <= '0';
    wait for cCLK_PER;  

    --  Place "2" in $2
    s_WA <= "00010";
    s_IMM <=x"00000002";
    wait for cCLK_PER;  

    -- Place "3" in $3   
    s_WA <= "00011";
    s_IMM <=x"00000003";
    wait for cCLK_PER;  

    --  Place "4" in $4
    s_WA <= "00100";
    s_IMM <=x"00000004";
    wait for cCLK_PER;  
	
    --   Place "5" in $5
    s_WA <= "00101";
    s_IMM <=x"00000005";
    wait for cCLK_PER;
	
    --  Place "6" in $6
    s_WA <= "00110";
    s_IMM <=x"00000006";
    wait for cCLK_PER;
	
    --  Place "7" in $7
    s_WA <= "00111";
    s_IMM <=x"00000007";
    wait for cCLK_PER;
	
    --  Place "8" in $8
    s_WA <= "01000";
    s_IMM <=x"00000008";
    wait for cCLK_PER;
	
    --  Place "9" in $9
    s_WA <= "01001";
    s_IMM <=x"00000009";
    wait for cCLK_PER;
	
    --   Place "10" in $10
    s_WA <= "01010";
    s_IMM <=x"0000000A";
    wait for cCLK_PER;
	
    --  $11 = $1 + $2
    s_WA <= "01011";
    s_RA1 <= "00001";
    s_RA2 <= "00010";
    s_ALU <= '0';
    wait for cCLK_PER;
	
    --  $12 = $11 - $3
    s_WA <= "01100";
    s_RA1 <= "01011";
    s_RA2 <= "00011";
    s_AdS <= '1';
    wait for cCLK_PER;
	
    --  $13 = $12 + $4
    s_WA <= "01101";
    s_RA1 <= "01100";
    s_RA2 <= "00100";
    s_AdS <= '0';
    wait for cCLK_PER;
	
    --  $14 = $13 - $5
    s_WA <= "01110";
    s_RA1 <= "01101";
    s_RA2 <= "00101";
    s_AdS <= '1';
    wait for cCLK_PER;
	
    --  $15 = $14 + $6
    s_WA <= "01111";
    s_RA1 <= "01110";
    s_RA2 <= "00110";
    s_AdS <= '0';
    wait for cCLK_PER;
	
    --  $16 = $15 - $7
    s_WA <= "10000";
    s_RA1 <= "01111";
    s_RA2 <= "00111";
    s_AdS <= '1';
    wait for cCLK_PER;
	
    --  $17 = $16 + $8
    s_WA <= "10001";
    s_RA1 <= "10000";
    s_RA2 <= "01000";
    s_AdS <= '0';
    wait for cCLK_PER;
	
    --  $18 = $17 - $9
    s_WA <= "10010";
    s_RA1 <= "10001";
    s_RA2 <= "01001";
    s_AdS <= '1';
    wait for cCLK_PER;
	
    --  $19 = $18 + $10
    s_WA <= "10011";
    s_RA1 <= "10010";
    s_RA2 <= "01010";
    s_AdS <= '0';
    wait for cCLK_PER;
	
    --  Place "35" in $20
    s_WA <= "10100";
    s_RA1 <= "00000";
    s_IMM <= x"00000023";
    s_ALU <= '1';
    wait for cCLK_PER;
	
    --  $21 = $19 + $20
    s_WA <= "10101";
    s_RA1 <= "10011";
    s_RA2 <= "10100";
    s_ALU <= '0';
    wait for cCLK_PER;

    wait;
  end process;
  
end behavior;