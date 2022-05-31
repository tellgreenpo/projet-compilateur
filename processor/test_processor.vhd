----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2022 13:38:05
-- Design Name: 
-- Module Name: test_processor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_processor is
--  Port ( );
end test_processor;

architecture Behavioral of test_processor is

component processor is
    Port ( CLK : in STD_LOGIC;
            RST : in STD_LOGIC );
end component;

signal CLK : std_logic := '0';
signal RST : std_logic := '1';

constant clock_period : TIME  := 25 ns;

begin
    uut : processor port map (
        CLK => CLK,
        RST => RST
    );
    
    clock_process : process
    begin
        CLK <= NOT(CLK);
        WAIT FOR clock_period/2;
    end process;
    
    process
    begin
        wait for 25 ns;
        
        wait for 25 ns;
        
        wait for 25 ns;
        wait for 25 ns;
        wait for 25 ns;
        wait for 25 ns;
        wait for 25 ns;
        wait for 25 ns;
        wait for 25 ns;
        wait for 25 ns;
        wait for 25 ns;
        wait for 25 ns;
        wait for 25 ns;
        wait for 25 ns;
        
    end process;
    


end Behavioral;
