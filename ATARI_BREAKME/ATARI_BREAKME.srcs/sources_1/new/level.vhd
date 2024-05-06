----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2024 01:30:00 PM
-- Design Name: 
-- Module Name: level - Behavioral
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


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity level is
    PORT (
        lvl_cnt : in std_logic_vector (5 downto 0);
        win : in std_logic; -- make this an output please
        pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        red : OUT STD_LOGIC;
        green : OUT STD_LOGIC;
        blue : OUT STD_LOGIC
    );
end level;

architecture Behavioral of level is
    SIGNAL cnt_brick : integer := 0;
    SIGNAL l_brick_alive : std_logic;
    component brick is
        port (
            brick_x : IN std_logic_vector (10 DOWNTO 0);
            brick_y : IN std_logic_vector (10 DOWNTO 0);
            power_up : IN std_logic;
            pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            brick_alive : out std_logic;
            red : OUT STD_LOGIC;
            green : OUT STD_LOGIC;
            blue : OUT STD_LOGIC
        );
    end component;
begin

brick1 : brick
PORT MAP (
    brick_x => CONV_STD_LOGIC_VECTOR(40, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(40, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red,
    green => green,
    blue => blue
);

end Behavioral;
