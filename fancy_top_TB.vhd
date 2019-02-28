-- Charles Owen
-- Embedded Systems
-- Test Bench for the WHOLE ENCHILADA!
-- Cross your fingers, hide your kids, hide your wives
-- 'Bout to get crazy up in here'


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity fancy_top_TB is

end fancy_top_TB;

architecture Behavioral of fancy_top_TB is

signal clk_tb   : std_logic := '0';
signal sw_tb    : std_logic_vector(3 downto 0) := (others => '0');
signal btn_tb   : std_logic_vector(3 downto 0) := (others => '0');
signal led_tb   : std_logic_vector(3 downto 0) := (others => '0');
signal divier_light: std_logic;

component fancy_top_level is

port(

btn     : in std_logic_vector(3 downto 0);
clk     : in std_logic;
sw      : in std_logic_vector(3 downto 0);
led     : out std_logic_vector(3 downto 0);
divider_light : out std_logic

);
          
end component;


begin

clk_proc: process
          begin
          
          wait for 4ns;
          clk_tb <= '1';
          
          wait for 4ns;
          clk_tb <= '0';
          
          end process;
          
load_proc: process
           begin
           
           wait for 550000000ns;
           btn_tb(3) <= '1';
           
           wait for 21000000ns;
           btn_tb(3) <= '0';
           
           wait for 500000000ns;
           wait for 500000000ns;
           
           end process;
           
rst_proc: process
          begin
          
          wait for 650000000ns;
          btn_tb(0) <= '1';
          
          wait for 21000000ns;
          btn_tb(0) <= '0';
          
          end process;
          

-- buttons setting for enable on, direction 1,          

--btn_tb(0) <= '0'; -- rst = 0
btn_tb(1) <= '1'; -- en = 1
btn_tb(2) <= '0'; -- updn = 0

          
-- switches off for now 
sw_tb(0) <= '1'; 
sw_tb(1) <= '0';
sw_tb(2) <= '0';
sw_tb(3) <= '0';



dut: fancy_top_level

    port map(
    
        btn => btn_tb,
        clk => clk_tb,
        sw  => sw_tb,
        led => led_tb,
        divider_light => divier_light
        
        );      

end Behavioral;
