-- Charles Owen
-- Embedded Systems
-- Lab 1
-- Fancy Counter

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fancy_counter_again is
        Port(
            clk, clk_en, dir    : in std_logic;  -- clock .clock enable and direction inputs
            en, ld, rst         : in std_logic;  -- enable, load, and reset
            updn                : in std_logic;  -- updown input
            value_in            : in std_logic_vector(3 downto 0); -- value in is the new input count until value from user
            cnt                 : out std_logic_vector(3 downto 0) -- cnt is the output of our conter's value      
        );
end fancy_counter_again;

architecture Behavioral of fancy_counter_again is

signal direction_register   : std_logic := '0'; -- register to hold direction up or down
signal count                : std_logic_vector (3 downto 0) := (others => '0'); --temporary count signal
signal value                : std_logic_vector (3 downto 0) := (others => '1'); -- temporary value signal
 
begin

cnt <= count; -- send our intermediate count signal to the count output

count_pro: process (CLK)
           begin
           
           if rising_edge(CLK) then    -- now we catch our main clock rising edge
           
            if (EN = '1') then         -- make sure enable is set to 1, otherwise no changes in cicrcuit
            
                if (rst = '1') then    -- is reset is 1 we reset value of count
                
                count <= "0000";
                
                end if;
                    
            if (CLK_EN = '1') then -- if intermediate clock signal is 1, then we count                        
                   
                if (direction_register = '0') then -- direction is 0 and 
           
                    if (count < value) then -- count is less than user input target value, we incriment
           
                        count <= std_logic_vector( unsigned(count) + 1 );
                                                                  
                    else
            
                        count <= "0000";   -- if count reaches our target value, rolls to 0000                      
            
                    end if;
                    
                    end if;
            
                if (direction_register ='1') then
           
                    if (value > "0000") then -- for counting down, if not at zero yet
           
                         count <= std_logic_vector(unsigned(count) - 1);                         
            
                    if (count = "0000") then
           
                         count <= value; -- after target value roll to value                  
            
                 end if;
                 
                 end if;  
                 
                 end if;
           
          end if;
          
          end if;                         
            
          end if;
        
          
          end process;
          
ld_process: process (CLK) -- load gets its own process since no competing signal assignments
            begin                 -- in other if statement
            
            if rising_edge(CLK) then
            
                if (CLK_EN = '1') then -- following three lines, ensure enable criteria met
                
                  if (EN = '1') then
                
                  if (ld = '1') then
          
                    value <= value_in; -- set value to input value from user         
            
                  end if;
                   
                  end if;
                   
                end if;
                
            end if;
            
            end process;
            
direc_proc: process (CLK) -- direction also gets its own process since no other if statement
            begin         -- competes with signal assignment
            
             if rising_edge(CLK) then
            
                if (CLK_EN = '1') then -- check enable criteria
                
                  if (EN = '1') then            
            
                    if(updn = '1') then
            
                      direction_register <= dir; -- set direction input from user
                
                    end if;
                    
                  end if;
                  
                end if;
                
             end if;       
            
            end process;
                      

end Behavioral;
