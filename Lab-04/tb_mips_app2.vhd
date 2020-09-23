library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.vector_arr.all;

entity tb_MIPS_app2 is
	generic(N: integer := 32;
		J : integer := 32/2;
		gCLK_HPER   : time := 50 ns);
end tb_MIPS_app2;

architecture behavior of tb_MIPS_app2 is
  
constant cCLK_PER  : time := gCLK_HPER * 2;

component MIPS_app2
    generic(N : integer := 32;
              J : integer := 32/2;
              DATA_WIDTH : natural := 32;
              ADDR_WIDTH : natural := 10);
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_writeEnable        : in std_logic;     -- Write Enable
         i_writeAddr          : in std_logic_vector(4 downto 0);     -- Write address input
         i_readAddr1          : in std_logic_vector(4 downto 0);     -- Read address 1 input
         i_readAddr2          : in std_logic_vector(4 downto 0);     -- Read address 2 input
         immediate    : in std_logic_vector(J-1 downto 0);
         ALUSrc	    : in std_logic;
         i_Ad_Sb	    : in std_logic;
         Extend_Ctl	    : in std_logic;
         memWEnable	    : in std_logic;
         outSelect	    : in std_logic);
  
  end component;

signal s_CLK, s_RST, s_WE, s_ALU, s_AdS, s_extCtl, s_memWE, s_outSel  : std_logic;
signal s_WA, s_RA1, s_RA2  : std_logic_vector(4 downto 0);
signal s_IMM  : std_logic_vector(J-1 downto 0);

begin

DUT: MIPS_app2
  port map(i_CLK  => s_CLK,
		   i_RST  => s_RST,
		   i_writeEnable  => s_WE,
		   i_writeAddr  => s_WA,
		   i_readAddr1  => s_RA1,
		   i_readAddr2  => s_RA2,
		   immediate  => s_IMM,
		   ALUSrc  => s_ALU,
           i_Ad_Sb  => s_AdS,
           Extend_Ctl  => s_extCtl,
           memWEnable  => s_memWE,
           outSelect  => s_outSel);
		   
P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
P_TB: process
  begin
    -- Reset the Registers and disable write to memory to start
    s_RST <= '1';
    s_WE  <= '0';
    s_memWE  <= '0';
    wait for cCLK_PER;

    s_RST <= '0';
    s_WE  <= '1';
    s_WA  <= "11001";
    s_RA1 <= "00000";
    s_RA2 <= "00000";
    s_IMM <= x"0000";
    s_extCtl  <= '0';
    s_ALU <= '1';
    s_AdS <= '0';
    s_outSel  <= '1';
    wait for cCLK_PER;  --Load &A into $25

    s_WA  <= "11010";
    s_IMM <= x"0100";
    wait for cCLK_PER;  -- Load &B into $26

    s_WA  <= "00001";
    s_RA1 <= "11001";
    s_RA2 <= "00000";
    s_IMM <= x"0000";
    s_outSel  <= '0';
    wait for cCLK_PER;  -- Load A[0] into $1

    s_WA  <= "00010";
    s_RA1 <= "11001";
    s_RA2 <= "00000";
    s_IMM <= x"0004";
    s_outSel  <= '0';
    wait for cCLK_PER;  --Load A[1] into $2

    s_WA  <= "00001";
    s_RA1 <= "00001";
    s_RA2 <= "00010";
    s_ALU <= '0';
    s_outSel  <= '1';
    wait for cCLK_PER;  --$1 = $1 + $2

    s_WE  <= '0';
    s_memWE  <= '1';
    s_RA1 <= "11010";
    s_RA2 <= "00001";
    s_IMM <= x"0000";
    s_ALU <= '1';
    wait for cCLK_PER;  --Store $1 into B[0]

    s_WE  <= '1';
    s_memWE  <= '0';
    s_WA  <= "00010";
    s_RA1 <= "11001";
    s_IMM <= x"0008";
    s_ALU <= '1';
    s_outSel  <= '0';
    wait for cCLK_PER;  --Load A[2] into $2

    s_WA  <= "00001";
    s_RA1 <= "00001";
    s_RA2 <= "00010";
    s_ALU <= '0';
    s_outSel  <= '1';
    wait for cCLK_PER;  --$1 = $1 + $2

    s_WE  <= '0';
    s_memWE  <= '1';
    s_RA1 <= "11010";
    s_RA2 <= "00001";
    s_IMM <= x"0004";
    s_ALU <= '1';
    wait for cCLK_PER;  --Store $1 into B[1]

    s_WE  <= '1';
    s_memWE  <= '0';
    s_WA  <= "00010";
    s_RA1 <= "11001";
    s_IMM <= x"000C";
    s_ALU <= '1';
    s_outSel  <= '0';
    wait for cCLK_PER;  --Load A[3] into $2

    s_WA  <= "00001";
    s_RA1 <= "00001";
    s_RA2 <= "00010";
    s_ALU <= '0';
    s_outSel  <= '1';
    wait for cCLK_PER;  --$1 = $1 + $2

    s_WE  <= '0';
    s_memWE  <= '1';
    s_RA1 <= "11010";
    s_RA2 <= "00001";
    s_IMM <= x"0008";
    s_ALU <= '1';
    wait for cCLK_PER;  --Store $1 into B[2]

    s_WE  <= '1';
    s_memWE  <= '0';
    s_WA  <= "00010";
    s_RA1 <= "11001";
    s_IMM <= x"0010";
    s_ALU <= '1';
    s_outSel  <= '0';
    wait for cCLK_PER;  --Load A[4] into $2

    s_WA  <= "00001";
    s_RA1 <= "00001";
    s_RA2 <= "00010";
    s_ALU <= '0';
    s_outSel  <= '1';
    wait for cCLK_PER;  --$1 = $1 + $2

    s_WE  <= '0';
    s_memWE  <= '1';
    s_RA1 <= "11010";
    s_RA2 <= "00001";
    s_IMM <= x"000C";
    s_ALU <= '1';
    wait for cCLK_PER;  --Store $1 into B[3]

    s_WE  <= '1';
    s_memWE  <= '0';
    s_WA  <= "00010";
    s_RA1 <= "11001";
    s_IMM <= x"0014";
    s_ALU <= '1';
    s_outSel  <= '0';
    wait for cCLK_PER;  --Load A[5] into $2

    s_WA  <= "00001";
    s_RA1 <= "00001";
    s_RA2 <= "00010";
    s_ALU <= '0';
    s_outSel  <= '1';
    wait for cCLK_PER;  --$1 = $1 + $2

    s_WE  <= '0';
    s_memWE  <= '1';
    s_RA1 <= "11010";
    s_RA2 <= "00001";
    s_IMM <= x"0010";
    s_ALU <= '1';
    wait for cCLK_PER;  --Store $1 into B[4]

    s_WE  <= '1';
    s_memWE  <= '0';
    s_WA  <= "00010";
    s_RA1 <= "11001";
    s_IMM <= x"0018";
    s_ALU <= '1';
    s_outSel  <= '0';
    wait for cCLK_PER;  --Load A[6] into $2

    s_WA  <= "00001";
    s_RA1 <= "00001";
    s_RA2 <= "00010";
    s_ALU <= '0';
    s_outSel  <= '1';
    wait for cCLK_PER;  --$1 = $1 + $2

    s_WE  <= '1';
    s_memWE  <= '0';
    s_WA  <= "11011";
    s_RA1 <= "11010";
    s_IMM <= x"0200";
    s_ALU <= '1';
    s_outSel  <= '1';
    wait for cCLK_PER;  --Load &B[128] into $27

    s_WE  <= '0';
    s_memWE  <= '1';
    s_RA1 <= "11011";
    s_RA2 <= "00001";
    s_IMM <= x"0004";
    s_ALU <= '1';
    s_AdS  <= '1';
    wait for cCLK_PER;  --Store $1 into B[255]

    wait;
  end process;
  
end behavior;
