-- Charles Owen
-- Embedded Systesm
-- Lab 1
-- Clock Divider Test Bench


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity clock_test is
end clock_test;

architecture Behavioral of clock_test is

signal tb_clock : std_logic := '0'; -- test bench clock signal
signal clk_out  : std_logic := '0'; -- test bench down sampled clock output
signal tb_led0  : std_logic := '0'; -- led outtput for visual confirmation of down sample signal

component clock_div 

    Port (
        clk     : in std_logic;
        clk_out : out std_logic;
        led0    : out std_logic
    );
    
end component;

begin

    clock_process: process begin
    
        wait for 4ns;    -- This is the first half period of the test bench clock cycle
        tb_clock <= '0'; -- clock signal low
        
        wait for 4ns;    -- Second half of the test bench clock period
        tb_clock <= '1';
        
    end process;
    
dut: clock_div  -- device under test declaration
     port map(
    
     clk => tb_clock, -- porting general clock to tb_clock
     clk_out => clk_out, 
     led0 => tb_led0
    
      );


end Behavioral;
