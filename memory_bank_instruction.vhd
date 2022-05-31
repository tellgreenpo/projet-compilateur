----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2022 11:40:26
-- Design Name: 
-- Module Name: memory_bank_instruction - Behavioral
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

entity memory_bank_instruction is
    Port ( Addr : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (31 downto 0));
end memory_bank_instruction;

architecture Behavioral of memory_bank_instruction is

    Type RegisterArray is Array(255 downto 0) of STD_LOGIC_VECTOR(31 downto 0); 
    signal Memory : RegisterArray := ( -- AFC
                                       0 => X"01060800",
                                       1 => X"02060800",
                                       2 => X"03060100",
                                       3 => X"04060800",
                                       4 => X"04060800",
                                       5 => X"04060800",
                                       6 => X"04060800",
                                       7 => X"04060800",
                                       8 => X"04060800",
                                       -- Add / SOU operations
                                       -- 9 => X"05010102",
                                       -- 10 => X"06020304",
                                       -- COP
                                       -- 11 => X"0F050400",
                                       -- 12 => X"0E050400",
                                       -- STR
                                       -- 9 => X"00080200",
                                       -- 10 => X"01080100",
                                       -- LOAD
                                       9 => X"03070000",
                                       10 => X"04070200",
                                      
                                       
                                       others => X"00000000"
                                       ); 

   
begin
    process
    
    begin 
    
        wait until CLK'Event and CLK='1';
        O <= Memory(to_integer(unsigned(Addr)));

    end process;


end Behavioral;
