----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2022 11:20:48
-- Design Name: 
-- Module Name: lcPreMem - Behavioral
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

entity lcPreMem is
    Port ( Op : in STD_LOGIC_VECTOR (7 downto 0);
           DataOut : out STD_LOGIC);
end lcPreMem;

architecture Behavioral of lcPreMem is

begin

    DataOut <= '1' when Op = X"08" else '0';

end Behavioral;
