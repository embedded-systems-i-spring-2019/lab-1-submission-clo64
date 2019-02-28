-- Charles Owen
-- Embedded Systems
-- Lab 1
-- Debounce

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce_two is
        Port(
        btn, clk        : in std_logic;
        dbnc            : out std_logic
        
        );
end debounce_two;

architecture Behavioral of debounce_two is

signal reg_A           : std_logic_vector( 1 downto 0);
signal out_to_dbnc     : std_logic := '0';
signal count           : std_logic_vector( 26 downto 0) := (others => '0');

begin   

dbnc <= out_to_dbnc;

debounce_process:   process (CLK) 
                    begin
                    
                        if rising_edge(CLK) then
                        
                            reg_A(0) <= btn; -- concurent process so not sure this pair works...
                            reg_A(1) <= reg_A(0);  
                            
                        end if;
                    end process;
                        
rising_button:      process (CLK)
                    begin
                  
                        if rising_edge(CLK) then
                            
                             if (btn = '1') then                                                                          
                           
                                 if (unsigned(count) < 2500500) then
                            
                                     out_to_dbnc <= '0';
                                 
                                     if (reg_A(1) = '1') then
                                
                                         count <= std_logic_vector(unsigned(count) + 1);
                                
                                     else
                                
                                         count <= (others => '0');
                                    
                                     end if; 
                                
                                    else
                            
                                     out_to_dbnc <= reg_A(1);
                               
                                 end if; 
                           
                             else
                                
                                 out_to_dbnc <= '0'; 
                                 count <= (others => '0');
                           
                           end if;                     
                        
                        end if;                     
                                              
                   end process;
                   
         
                                        
                                

end Behavioral;