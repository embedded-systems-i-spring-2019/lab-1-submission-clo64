-- Charles Owen
-- Embedded Systesm
-- Lab 1
-- Clock Divider


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity clock_div is
    Port (
        clk     : in std_logic;
        clk_out : out std_logic;
        led0    : out std_logic 
        
    );

end clock_div;

architecture Behavioral of clock_div is

signal count    : std_logic_vector(26 downto 0) := (others => '0');

begin

    process (clk) begin
    
        if rising_edge(clk) then
            
            count <= std_logic_vector(unsigned(count) + 1);
              
            if (unsigned(count) < 62499999) then
        
                clk_out <= '0';
                led0 <= '0';
            
            else
        
                clk_out <= '1';
                led0 <= '1';
            
        if  (unsigned(count) >= 125000000) then
        
            count <= (others => '0');
            led0 <= '1';
                    
        end if;  
          
        end if;
        
        end if;
        
    end process;

end Behavioral;
