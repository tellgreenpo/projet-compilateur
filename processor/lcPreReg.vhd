----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2022 11:24:32
-- Design Name: 
-- Module Name: lcPreReg - Behavioral
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

entity lcPreReg is
    Port ( Op : in STD_LOGIC_VECTOR (7 downto 0);
           DataOut : out STD_LOGIC);
end lcPreReg;

architecture Behavioral of lcPreReg is

-- Write mode for AFC, COP, ADD, SOU, DIV, MUL, LOAD

begin

    DataOut <= '0' when Op=X"08" or Op=X"00" else '1';


end Behavioral;
