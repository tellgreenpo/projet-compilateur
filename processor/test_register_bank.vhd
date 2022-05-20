----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 11:46:44
-- Design Name: 
-- Module Name: test_register_bank - Behavioral
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

entity test_register_bank is
--  Port ( );
end test_register_bank;

architecture Behavioral of test_register_bank is

COMPONENT register_bank
Port ( adrA : in std_logic_vector (3 downto 0);
           adrB : in std_logic_vector (3 downto 0);
           adrW : in std_logic_vector (3 downto 0);
           W : in std_logic;
           DATA : in std_logic_vector (7 downto 0);
           RST : in std_logic;
           CLK : in std_logic;
           QA : out std_logic_vector (7 downto 0);
           QB : out std_logic_vector (7 downto 0);
           QX : out std_logic_vector (7 downto 0)
           );
END COMPONENT;

-- inputs 
signal adrA : std_logic_vector(3 downto 0) := (others => '0');
signal adrB : std_logic_vector(3 downto 0) := (others => '0');
signal adrW : std_logic_vector(3 downto 0) := (others => '0');
signal W :  std_logic := '0' ;
signal DATA : std_logic_vector (7 downto 0) := (others => '0');
signal RST : std_logic := '0';
signal CLK : std_logic := '0';

-- outputs 
signal QA : std_logic_vector (7 downto 0) := (others => '0');
signal QB : std_logic_vector (7 downto 0) := (others => '0');
signal QX : std_logic_vector (7 downto 0) := (others => '0');
    
constant clock_period : TIME  := 20 ns;
begin
    uut : register_bank PORT MAP (
        adrA => adrA,
        adrB => adrB,
        adrW => adrW,
        W => W,
        DATA => DATA,
        RST => RST,
        CLK => CLK,
        QA => QA,
        QB => QB,
        QX => QX
    );

    clock_process : process
    
    begin
        CLK <= NOT(CLK);
        WAIT FOR clock_period/2;
    end process;
    
    process
    begin
        -- write tests
        -- Write 2 DATA to 2 different address
        DATA <= x"0a"
        
        -- RST 
        -- Write 2 DATA to 2 different address
        -- Read from adress
        -- Write Read at the same address
    end process;



end Behavioral;
