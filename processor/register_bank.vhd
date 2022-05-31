----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 10:32:38
-- Design Name: 
-- Module Name: register_bank - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_bank is
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
end register_bank;




architecture Behavioral of register_bank is

type registers is array (0 to 15 ) of std_logic_vector(7 downto 0);
signal bank : registers := (others => X"00");

begin
    process (CLK) is
    begin
        if rising_edge(CLK) then
            if (RST = '0') then
                bank <= (others => x"00");
            end if;
            if (W = '1') then
                bank(to_integer(unsigned(adrW))) <= DATA;
            end if;
        end if;
    end process;
    
    QX <= DATA when W='1' and ((adrA = adrW)  or (adrB = adrW));
    QA <= bank(to_integer(unsigned(adrA)));
    QB <= bank(to_integer(unsigned(adrB)));

end Behavioral;
