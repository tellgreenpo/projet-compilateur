----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2022 12:16:28
-- Design Name: 
-- Module Name: processor - Behavioral
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


entity processor is
    Port ( CLK : in STD_LOGIC;
            RST : in STD_LOGIC);
end processor;

architecture Behavioral of processor is


component mux is
    Port ( Op : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Pre : in STD_LOGIC_VECTOR (7 downto 0);
           DataOut : out STD_LOGIC_VECTOR (7 downto 0));
end component;


component memory_bank_instruction is
    Port ( Addr : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component buffer_pipeline is
    Port ( Ain : in STD_LOGIC_VECTOR (7 downto 0);
           Bin : in STD_LOGIC_VECTOR (7 downto 0);
           Cin : in STD_LOGIC_VECTOR (7 downto 0);
           Opin : in STD_LOGIC_VECTOR (7 downto 0);
           Aout : out STD_LOGIC_VECTOR (7 downto 0);
           Bout : out STD_LOGIC_VECTOR (7 downto 0);
           Cout : out STD_LOGIC_VECTOR (7 downto 0);
           Opout : out STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC);
end component;

COMPONENT register_bank
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
END COMPONENT;

component lcPreAlu is
    Port ( Op : in STD_LOGIC_VECTOR (7 downto 0);
           DataOut : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component alu is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctr_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           Negative : out STD_LOGIC;
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC;
           Carry : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component muxUAL is
    Port ( Op : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Pre : in STD_LOGIC_VECTOR (7 downto 0);
           DataOut : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component muxPostMem is
    Port ( B : in STD_LOGIC_VECTOR (7 downto 0);
           Pre : in STD_LOGIC_VECTOR (7 downto 0);
           Op : in STD_LOGIC_VECTOR (7 downto 0);
           DataOut : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component muxPreMem is
    Port ( B : in STD_LOGIC_VECTOR (7 downto 0);
           A : in STD_LOGIC_VECTOR (7 downto 0);
           Op : in STD_LOGIC_VECTOR (7 downto 0);
           DataOut : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component lcPreMem is
    Port ( Op : in STD_LOGIC_VECTOR (7 downto 0);
           DataOut : out STD_LOGIC);
end component;

component memory_bank_data is
    Port ( Addr : in STD_LOGIC_VECTOR (7 downto 0);
           I : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component lcPreReg is
    Port ( Op : in STD_LOGIC_VECTOR (7 downto 0);
           DataOut : out STD_LOGIC);
end component;

-- ==================== Signals ==================

signal instruction_input : std_logic_vector(7 downto 0) := (others => '0');

signal instruction_output : std_logic_vector(31 downto 0) := (others => '0');

signal lidi_a_out : std_logic_vector(7 downto 0) := (others => '0');
signal lidi_op_out : std_logic_vector(7 downto 0) := (others => '0');
signal lidi_b_out : std_logic_vector(7 downto 0) := (others => '0');
signal lidi_c_out : std_logic_vector(7 downto 0) := (others => '0');

signal diex_a_out : std_logic_vector(7 downto 0) := (others => '0');
signal diex_op_out : std_logic_vector(7 downto 0) := (others => '0');
signal diex_b_out : std_logic_vector(7 downto 0) := (others => '0');
signal diex_c_out : std_logic_vector(7 downto 0) := (others => '0');

signal exmem_a_out : std_logic_vector(7 downto 0) := (others => '0');
signal exmem_op_out : std_logic_vector(7 downto 0) := (others => '0');
signal exmem_b_out : std_logic_vector(7 downto 0) := (others => '0');

signal memre_a_out : std_logic_vector(7 downto 0) := (others => '0');
signal memre_op_out : std_logic_vector(7 downto 0) := (others => '0');
signal memre_b_out : std_logic_vector(7 downto 0) := (others => '0');

signal empty : std_logic_vector(7 downto 0) := (others => '0');

signal register_W :  std_logic := '0';
signal register_RST : std_logic := '1';
signal register_QA : std_logic_vector (7 downto 0) := (others => '0');
signal register_QB : std_logic_vector (7 downto 0):= (others => '0');
signal register_QX : std_logic_vector (7 downto 0):= (others => '0');

signal mux_register_out : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

signal lc_alu_out : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');

signal alu_negative : STD_LOGIC := '0';
signal alu_overflow : STD_LOGIC := '0';
signal alu_zero : STD_LOGIC := '0';
signal alu_carry : STD_LOGIC := '0';
signal alu_output : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

signal mux_alu_output : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

signal mux_premem_output : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

signal lc_premem_out : STD_logic := '0';

signal memory_data_rst : STD_LOGIC := '1';
signal memory_data_output : STD_LOGIC_VECTOR (7 downto 0):= (others => '0');

signal mux_postmem_output : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

signal lc_prereg_out : STD_logic := '0';

begin

-- ================ maping
    instruction_memory : memory_bank_instruction port map (
            Addr => instruction_input,
            CLK => CLK, 
            O => instruction_output
    );
    
    lidi : buffer_pipeline port map (
            Ain => instruction_output(31 downto 24),
            Bin => instruction_output(15 downto 8),
            Cin => instruction_output(7 downto 0),
            Opin => instruction_output(23 downto 16),
            Aout => lidi_a_out,
            Bout => lidi_b_out,
            Cout => lidi_c_out,
            Opout => lidi_op_out,
            CLK => CLK
    );
    
    registers : register_bank port map (
            adrA => lidi_b_out(3 downto 0),
            adrB => lidi_c_out(3 downto 0),
            adrW => memre_a_out(3 downto 0),
            W => lc_prereg_out,
            DATA => memre_b_out,
            RST => register_RST,
            CLK => CLK,
            QA => register_QA,
            QB => register_QB,
            QX => register_QX  
    );
    
    mux_register : mux port map(
            Op => lidi_op_out,
            B => lidi_b_out,
            Pre => register_QA,
            DataOut => mux_register_out    
    
    );
    
    diex : buffer_pipeline port map (
            Ain => lidi_a_out,
            Bin => mux_register_out,
            Cin => register_QB,
            Opin => lidi_op_out,
            Aout => diex_a_out,
            Bout => diex_b_out,
            Cout => diex_c_out,
            Opout => diex_op_out,
            CLK => CLK
    );
    
    -- continue here with LC ALU and MUX
    
    lc_alu : lcPreAlu port map (
        Op => diex_op_out,
        DataOut => lc_alu_out
    );
    
    ual : alu port map (
            A => diex_b_out,
            B => diex_c_out,
            Ctr_Alu => lc_alu_out,
            Negative => alu_negative,
            Overflow => alu_overflow,
            Zero => alu_zero,
            Carry => alu_carry,
            S => alu_output
    );
    
    mux_alu : muxUAL port map (
            Op => diex_op_out,
            B => diex_b_out,
            Pre => alu_output,
            DataOut => mux_alu_output
    );
    
     
    exmem : buffer_pipeline port map (
            Ain => diex_a_out,
            Bin => mux_alu_output,
            Cin => empty,
            Opin => diex_op_out,
            Aout => exmem_a_out,
            Bout => exmem_b_out,
            Cout => empty,
            Opout => exmem_op_out,
            CLK => CLK
    );
    
    mux_premem : muxPreMem port map (
            B => exmem_b_out,
            A => exmem_a_out,
            Op => exmem_op_out,
            DataOut => mux_premem_output
    
    );
    
    lc_premem : lcPreMem port map (
            Op => exmem_op_out,    
            DataOut => lc_premem_out
    );
    
    memory_data : memory_bank_data port map (
            Addr => mux_premem_output,
            I => exmem_b_out,
            RW => lc_premem_out,
            RST => memory_data_rst,
            CLK => CLK,
            O => memory_data_output
    );
    
    mux_postmem : muxPostMem port map (
            B => exmem_b_out,
            Pre => memory_data_output,
            Op => exmem_op_out,
            DataOut => mux_postmem_output
    );
    
    memre : buffer_pipeline port map (
            Ain => exmem_a_out,
            Bin => mux_postmem_output,
            Cin => empty,
            Opin => exmem_op_out,
            Aout => memre_a_out,
            Bout => memre_b_out,
            Cout => empty,
            Opout => memre_op_out,
            CLK => CLK
    );
    
    lc_prereg : lcPreReg port map (
        Op => memre_op_out,
        DataOut => lc_prereg_out
    );
    
    
    
    process
    begin
        
        wait until CLK'Event and CLK='1';
        if RST = '0' then 
             register_rst <= '0';
             memory_data_rst <= '0';
        else
            register_rst <= '1';
            memory_data_rst <= '1';
        end if;
        instruction_input <= instruction_input+1;
        
        
        
    end process;
end Behavioral;
