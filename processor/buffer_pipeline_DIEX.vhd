----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2022 10:29:57
-- Design Name: 
-- Module Name: buffer_pipeline_DIEX - Behavioral
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

entity buffer_pipeline is
    Port ( Ain : in STD_LOGIC_VECTOR (7 downto 0);
           Bin : in STD_LOGIC_VECTOR (7 downto 0);
           Cin : in STD_LOGIC_VECTOR (7 downto 0);
           Opin : in STD_LOGIC_VECTOR (7 downto 0);
           Aout : out STD_LOGIC_VECTOR (7 downto 0);
           Bout : out STD_LOGIC_VECTOR (7 downto 0);
           Cout : out STD_LOGIC_VECTOR (7 downto 0);
           Opout : out STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC);
end buffer_pipeline;

architecture Behavioral of buffer_pipeline is

signal A : std_logic_vector(7 downto 0) := (others => '0');
signal B : std_logic_vector(7 downto 0) := (others => '0');
signal C : std_logic_vector(7 downto 0) := (others => '0');
signal Op : std_logic_vector(7 downto 0) := (others => '0');


begin
    



    process (CLK) is
    
    begin
    
        if rising_edge(CLK) then
            A <= Ain;
            B <= Bin;
            C <= Cin;
            Op <= Opin;        
        end if; 

    end process;

        Aout <= A;
        Bout <= B;
        Cout <= C;
        Opout <= Op;

end Behavioral;
