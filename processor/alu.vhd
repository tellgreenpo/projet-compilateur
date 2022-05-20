----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 09:46:54
-- Design Name: 
-- Module Name: alu - Behavioral
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

entity alu is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctr_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           Negative : out STD_LOGIC;
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC;
           Carry : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end alu;

architecture Behavioral of alu is

signal resultatOperation:std_LOGIC_VECTOR(15 downto  0) := (others => '0');

begin
    resultatOperation <= (X"00"&A)+(X"00"&B) when Ctr_Alu = "001" else
                         A*B when Ctr_Alu = "010" else
                         (X"00"&A)-(X"00"&B) when Ctr_Alu = "011" else
                         std_logic_vector(to_unsigned(to_integer(unsigned(X"00" & A)) / to_integer(unsigned(X"00" & B)),16)) when Ctr_Alu = "100";
                         
    Carry <= '1' when (resultatOperation > X"00FF") and (Ctr_Alu = "001") else '0';
    Overflow <= '1' when (resultatOperation > X"00FF") and (Ctr_Alu = "010") else '0';
    Zero <= '1' when resultatOperation = X"0000" else '0';
    Negative <= '1' when (A < B) and (Ctr_Alu = "011") else '0';
    
    S <= resultatOperation(7 downto 0);
    
--    case Ctr_Alu is
--            when "001" =>
--                resultatOperation <= A+B;
--                if resultatOperation > X"00FF" then
--
--                    Carry <= '1';
--                end if;
--            when "010" =>
--                resultatOperation <= A*B;
--                if resultatOperation > X"00FF" then
--                    Overflow <= '1';
--                end if;
--            when "011" =>
--                resultatOperation <= A-B;
--                if resultatOperation < X"00FF" then
--                    Negative <= '1';
--                end if;
--            when others =>
--                S <= x"00";
--            if resultatOperation = X"0000" then
--                Zero <= '1';
--            end if;
--         end case;
--         -- Assign the 8 least significant bits to the output signal
--         S <= resultatOperation(8 downto 0);
--

end Behavioral;