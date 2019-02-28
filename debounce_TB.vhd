-- Charles Owen
-- Embedded Systems
-- Lab 1
-- Debounce TB


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce_TB is
end debounce_TB;

architecture Behavioral of debounce_TB is

signal tb_clock     : std_logic := '0'; -- intermediate clock signal for port mapping
signal tb_dbnc      : std_logic := '0'; -- intermediate debounce output signal for port mapping
signal tb_btn       : std_logic := '0'; -- intermediate button input signal for port mapping

component debounce_two is -- declare clock divider componenet
        Port(
        btn, clk        : in std_logic;
        dbnc            : out std_logic
        
        );
end component;

begin

clock_process: process begin -- simulate 125 MHz clock

    wait for 4ns; -- half period
    tb_clock <= '0';
    
    wait for 4ns; -- half period
    tb_clock <= '1';
    
    end process;
    
button_process: process begin -- simulate button press

    wait for 100000000ns;
    tb_btn <= '0';
    
    wait for 100000000ns;
    tb_btn <= '1';
    
    end process;
    
dut: debounce_two -- port map for the device under test, debouncer
                  
    port map(
    
        clk => tb_clock,
        btn => tb_btn,
        dbnc => tb_dbnc
        
        );

end Behavioral;
