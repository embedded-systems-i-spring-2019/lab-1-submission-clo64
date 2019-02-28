--Charles Owen
-- Embedded Systems
-- Lab 1
-- Clock Divider Top Level

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divider_top is
   Port(
   clk     : in std_logic;
   led0    : out std_logic -- output to drive the LED
   );
   
end divider_top;

architecture Behavioral of divider_top is

component clock_div is  -- Declare use of the clock divider as component
    Port (
        clk     : in std_logic;
        clk_out : out std_logic
        --led0    : out std_logic 
        
        
    );

end component;

signal clk_divider : std_logic; -- signal to take clock divider port
signal q           : std_logic := '0'; -- signal for d flop flop output feedback

begin

led0 <= q; -- establishing link from led0 output to q feedback signal

div1 : clock_div -- instantiate a clock divider 
port map (clk => clk, -- map the clock port
          clk_out => clk_divider -- map the downsampled output
          );
          
     process (clk) 
     
     begin
     
     if rising_edge(clk) then
     
        if (clk_divider = '1') then -- is the clk_divider is high, i.e. enabled
     
           q <= not(q); -- invert the signal and use as data
            
        end if;
        end if;
       
        end process;


end Behavioral;
