----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2022 12:03:40
-- Design Name: 
-- Module Name: test_memory_bank_data - Behavioral
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

entity test_memory_bank_data is

end test_memory_bank_data;

architecture Behavioral of test_memory_bank_data is

 component memory_bank_data is
    Port ( Addr : in STD_LOGIC_VECTOR (7 downto 0);
           I : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (7 downto 0));
end component; 

-- inputs 
signal Addr : std_logic_vector(7 downto 0) := (others => '0');
signal entree : std_logic_vector(7 downto 0) := (others => '0');
signal RW : std_logic := '0';
signal RST : std_logic := '0';
signal CLK : std_logic := '0';

-- outputs 
signal sortie : std_logic_vector(7 downto 0) := (others => '0');

constant clock_period : TIME  := 20 ns;
begin
    uut : memory_bank_data PORT MAP(
      Addr => Addr,
      I => entree,
      RW => RW,
      RST => RST,
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
    

    RST <= '0';

    wait for 25 ns;
    -- Write some data
    RST<='1';
    RW <= '1';
    entree <= x"0f";
    Addr <= x"00";
    wait for 25 ns;
    -- Write some data
    Addr <= x"02";
    entree <= x"ff";
    wait for 25 ns;
    -- Read some data
    RW<='0';
    Addr <= x"00";
    wait for 25 ns;
    -- Reset
    --RST <= '0';
    --wait for 25 ns;
    --RST <= '1';
    --wait for 25 ns;
    -- Read
    RW<='0';
    Addr <= x"02";
    wait for 25 ns;
    
    end process;
end Behavioral;
