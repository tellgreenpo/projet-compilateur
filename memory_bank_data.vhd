----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2022 11:42:05
-- Design Name: 
-- Module Name: memory_bank_data - Behavioral
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
use IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory_bank_data is
    Port ( Addr : in STD_LOGIC_VECTOR (7 downto 0);
           I : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (7 downto 0));
end memory_bank_data;

architecture Behavioral of memory_bank_data is

    Type RegisterArray is array(0 to 255) of STD_LOGIC_VECTOR(7 downto 0); 
    signal Memory : RegisterArray :=(others => X"00"); 

begin

    process (CLK) is
    
    begin 
    
        if rising_edge(CLK) then
        if RST = '0' then 
            Memory <= (others => X"00"); 
        else
        if RW = '1' then 
            Memory(to_integer(unsigned(Addr))) <= I; 
        else 
            O <= Memory(to_integer(unsigned(Addr))); 
        end if; 
        end if;
        end if ;

    end process;

end Behavioral;
