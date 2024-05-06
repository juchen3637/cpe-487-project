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
        v_sync : IN STD_LOGIC;
        lvl_cnt : in std_logic_vector (5 downto 0);
        win : in std_logic; -- make this an output please
        pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        red : OUT STD_LOGIC;
        green : OUT STD_LOGIC;
        blue : OUT STD_LOGIC;
        ball_y_out : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        ball_x_out : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        bsize_out : IN INTEGER;
        flip_l : out std_logic_VECTOR(14 DOWNTO 0);
        flip_r : out std_logic_VECTOR(14 DOWNTO 0);
        flip_u : out std_logic_VECTOR(14 DOWNTO 0);
        flip_d : out std_logic_VECTOR(14 DOWNTO 0)
    );
end level;

architecture Behavioral of level is
    SIGNAL cnt_brick : integer := 0;
    SIGNAL l_brick_alive : std_logic;
    signal red1 : std_logic;
    signal green1 : std_logic;
    signal blue1 : std_logic;
    signal red2 : std_logic;
    signal green2 : std_logic;
    signal blue2 : std_logic;
    component brick is
        port (
            v_sync : in std_logic;
            brick_x : IN std_logic_vector (10 DOWNTO 0);
            brick_y : IN std_logic_vector (10 DOWNTO 0);
            power_up : IN std_logic;
            pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            brick_alive : out std_logic;
            red : OUT STD_LOGIC;
            green : OUT STD_LOGIC;
            blue : OUT STD_LOGIC;
            ball_y_out : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            ball_x_out : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            bsize_out : IN INTEGER;
            flip_l : out std_logic;
            flip_r : out std_logic;
            flip_u : out std_logic;
            flip_d : out std_logic
        );
    end component;
begin
red <= red1 or red2;
green <= green1 or green2;
blue <= blue1 or blue2;
brick1 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(400, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(300, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1,
    green => green1,
    blue => blue1,
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    flip_l => flip_l(0),
    flip_r => flip_r(0),
    flip_u => flip_u(0),
    flip_d => flip_d(0)
);
brick2 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(530, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(300, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red2,
    green => green2,
    blue => blue2,
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    flip_l => flip_l(1),
    flip_r => flip_r(1),
    flip_u => flip_u(1),
    flip_d => flip_d(1)
);

end Behavioral;
