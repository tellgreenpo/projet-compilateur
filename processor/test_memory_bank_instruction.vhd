----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2022 11:36:22
-- Design Name: 
-- Module Name: test_memory_bank_instruction - Behavioral
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

entity test_memory_bank_instruction is

end test_memory_bank_instruction;

architecture Behavioral of test_memory_bank_instruction is

component memory_bank_instruction is
    Port ( Addr : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- inputs 
signal Addr : std_logic_vector(7 downto 0) := (others => '0');
signal CLK : std_logic := '0';

-- outputs 
signal sortie : std_logic_vector(31 downto 0) := (others => '0');

constant clock_period : TIME  := 20 ns;
begin
    uut : memory_bank_instruction PORT MAP(
      Addr => Addr,
      CLK => CLK,
      O => sortie
   );
   
   clock_process : process
       
       begin
           CLK <= NOT(CLK);
           WAIT FOR clock_period/2;
       end process;
process
    begin
        Addr <= x"01";
        wait for 20 ns;
        Addr <= x"02";
    end process;
end Behavioral;
