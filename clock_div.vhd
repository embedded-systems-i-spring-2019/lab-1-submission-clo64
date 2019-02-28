-- Charles Owen
-- Embedded Systesm
-- Lab 1
-- Clock Divider


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity clock_div is
    Port (
        clk     : in std_logic; -- device common clock
        clk_out : out std_logic -- downsampled/divided output       
        
    );

end clock_div;

architecture Behavioral of clock_div is

signal count    : std_logic_vector(26 downto 0) := (others => '0'); -- 26 bit bundle to accomodate clock cycle count

begin

Divider_Process: process (clk) begin
    
                 if rising_edge(clk) then
            
                    count <= std_logic_vector(unsigned(count) + 1); -- count +1 every clock cycle
              
                    if (unsigned(count) < 62499999) then -- if count has not reached half period of 2hz, signal stays low
        
                        clk_out <= '0';                      
            
                    else
        
                        clk_out <= '1';                      
                        count <= (others => '0');                   
          
                   end if;
        
               end if;
        
    end process;

end Behavioral;
