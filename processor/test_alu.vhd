----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 09:48:36
-- Design Name: 
-- Module Name: test_alu - Behavioral
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

entity test_alu is
    
end test_alu;

architecture Behavioral of test_alu is

COMPONENT alu
Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctr_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           Negative : out STD_LOGIC;
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC;
           Carry : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT;

-- inputs 
signal A : std_logic_vector(7 downto 0) := (others => '0');
signal B : std_logic_vector(7 downto 0) := (others => '0');
signal Operation : std_logic_vector(2 downto 0) := (others => '0');

-- outputs 
signal Negative : std_logic := '0';
signal Overflow: std_logic := '0';
signal Zero : std_logic := '0';
signal Carry : std_logic := '0';
signal S : std_logic_vector(7 downto 0) := (others => '0');

BEGIN

   uut : alu PORT MAP(
      A => A,
      B => B,
      Ctr_Alu => Operation,
      Negative => Negative,
      Overflow => Overflow,
      Zero => Zero,
      Carry => Carry,
      S => S
   );

   PROCESS
   BEGIN
      A <= x"01";
      B <= x"02";
      Operation <= "001";
      WAIT FOR 50 ns;
      A <= x"ff";
      B <= x"01";
      Operation <= "001";
      WAIT FOR 50 ns;
      A <= x"03";
      B <= x"03";
      Operation <= "010";
      WAIT FOR 50 ns;
      A <= x"10";
      B <= x"10";
      Operation <= "010";
      WAIT FOR 50 ns;
      A <= x"ff";
      B <= x"ff";
      Operation <= "010";
      WAIT FOR 50 ns;
      A <= x"07";
      B <= x"04";
      Operation <= "011";
      WAIT FOR 50 ns;
      A <= x"0A";
      B <= x"0A";
      Operation <= "011";
      WAIT FOR 50 ns;
      A <= x"04";
      B <= x"08";
      Operation <= "011";
      WAIT FOR 50 ns;
   END PROCESS;

END Behavioral;