-- My next level test bench beoltch!!

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divider_top_tb is
end divider_top_tb;

architecture Behavioral of divider_top_tb is

signal tb_clock    : std_logic := '0';
signal tb_led0     : std_logic := '0';

component divider_top

   Port(
   clk     : in std_logic;
   led0    : out std_logic -- output to drive the LED
   );
   
end component;
   
begin

    clock_process: process begin
    
        wait for 4ns;
        tb_clock <= '0';
        
        wait for 4ns;
        tb_clock <= '1';
        
    end process;
    
dut: divider_top
    port map(
    
        clk => tb_clock,
        led0 => tb_led0    
    );

end Behavioral;
