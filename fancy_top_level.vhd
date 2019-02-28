-- Charles Owen
-- Embedded Systems
-- Lab 1
-- The top level design, the design in charge, the ultimate primo numeral uno master plan!

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fancy_top_level is

port(

btn     : in std_logic_vector(3 downto 0);
clk     : in std_logic;
sw      : in std_logic_vector(3 downto 0);
led     : out std_logic_vector(3 downto 0)


);
          
end fancy_top_level;

architecture Behavioral of fancy_top_level is

component clock_div is
    Port (
        clk     : in std_logic;
        clk_out : out std_logic
        
    );

end component;

component debounce_two is
        Port(
        btn, clk        : in std_logic;
        dbnc            : out std_logic
        
        );
end component;

component fancy_counter_again is
        Port(
            clk, clk_en, dir    : in std_logic;
            en, ld, rst         : in std_logic;
            updn                : in std_logic;
            value_in            : in std_logic_vector(3 downto 0);
            cnt                 : out std_logic_vector(3 downto 0)       
        );
end component;

--intermedite signals

signal debounce_int     : std_logic_vector(3 downto 0);
signal clk_en_int       : std_logic;
signal dir_int          : std_logic;
signal en_int           : std_logic;
signal ld_int           : std_logic;
signal updn_int         : std_logic;

begin

button1: debounce_two
    port map(
        btn => btn(0),
        clk => clk,
        dbnc => debounce_int(0)
    
    );
    
button2: debounce_two
    port map(
        btn => btn(1),
        clk => clk,
        dbnc => debounce_int(1)
    
    );
    
button3: debounce_two
    port map(
        btn => btn(2),
        clk => clk,
        dbnc => debounce_int(2)
    
    );   
    
button4: debounce_two
    port map(
        btn => btn(3),
        clk => clk,
        dbnc => debounce_int(3)
    
    );     
    
counter: fancy_counter_again
    port map(
        rst => debounce_int(0),
        clk => clk,
        clk_en => clk_en_int,
        dir => sw(0),
        en => debounce_int(1),
        ld => debounce_int(3),
        updn => debounce_int(2),
        value_in => sw,
        cnt => led
       
    );
    
clock_divider: clock_div
        port map(
        clk => clk,
        clk_out => clk_en_int
        
        );

end Behavioral;
