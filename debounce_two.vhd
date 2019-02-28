-- Charles Owen
-- Embedded Systems
-- Lab 1
-- Debounce

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce_two is
        Port(
        btn, clk        : in std_logic; -- button and clock input
        dbnc            : out std_logic -- output for our debounced signal
        
        );
end debounce_two;

architecture Behavioral of debounce_two is

signal reg_A           : std_logic_vector( 1 downto 0); -- input register to sample inbound button press
signal out_to_dbnc     : std_logic := '0'; -- intermediate signal to leave register and interface wiht debounce output
signal count           : std_logic_vector( 26 downto 0) := (others => '0'); -- counter for debounce time 

begin   

dbnc <= out_to_dbnc;

debounce_process:   process (CLK) -- process to update register
                    begin
                    
                        if rising_edge(CLK) then
                        
                            reg_A(0) <= btn; -- update register to the value of input button
                            reg_A(1) <= reg_A(0); -- update second bit of register to first bit input
                            
                        end if;
                    end process;
                        
rising_button:      process (CLK) -- process to read second bit of register and count
                    begin         -- until 20 ms
                  
                        if rising_edge(CLK) then
                            
                             if (btn = '1') then -- if button inpt is 1, continue process, of 0, no need to count                                                                
                           
                                 if (unsigned(count) < 2500000) then -- if less than 2500000 cycles continue
                            
                                     out_to_dbnc <= '0'; -- output stays low
                                 
                                     if (reg_A(1) = '1') then -- if register bit 2 sample still high, count up one
                                
                                         count <= std_logic_vector(unsigned(count) + 1);
                                
                                     else -- if register value goes low, reset count to 0
                                
                                         count <= (others => '0');
                                    
                                     end if; 
                                
                                    else
                            
                                     out_to_dbnc <= reg_A(1); -- if above count threshold output value of register 2nd bit
                                                              -- to debounce output
                                 end if; 
                           
                             else -- else to go with if btn = 1, else keep output low and count is refreshed to 0
                                
                                 out_to_dbnc <= '0'; 
                                 count <= (others => '0');
                           
                           end if;                     
                        
                        end if;                     
                                              
                   end process;
                   
         
                                        
                                

end Behavioral;