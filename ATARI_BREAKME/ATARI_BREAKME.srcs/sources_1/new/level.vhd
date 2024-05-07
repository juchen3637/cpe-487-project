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
        game_on : INOUT STD_LOGIC;
        flip_l : out std_logic_VECTOR(39 DOWNTO 0);
        flip_r : out std_logic_VECTOR(39 DOWNTO 0);
        flip_u : out std_logic_VECTOR(39 DOWNTO 0);
        flip_d : out std_logic_VECTOR(39 DOWNTO 0)
    );
end level;

architecture Behavioral of level is
    SIGNAL cnt_brick : integer := 0;
    SIGNAL l_brick_alive : std_logic;
    signal red1 : std_logic_vector(39 DOWNTO 0);
    signal green1 : std_logic_vector(39 DOWNTO 0);
    signal blue1 : std_logic_vector(39 DOWNTO 0);
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
            game_on : IN STD_LOGIC;
            flip_l : out std_logic;
            flip_r : out std_logic;
            flip_u : out std_logic;
            flip_d : out std_logic
        );
    end component;
begin
    red <= '0' when red1 = CONV_STD_LOGIC_VECTOR(0, 40) else
           '1';
    green <= '0' when green1 = CONV_STD_LOGIC_VECTOR(0, 40) else
           '1';
    blue <= '0' when blue1 = CONV_STD_LOGIC_VECTOR(0, 40) else
           '1';
brick1 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(49, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(50, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(0),
    green => green1(0),
    blue => blue1(0),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(0),
    flip_r => flip_r(0),
    flip_u => flip_u(0),
    flip_d => flip_d(0)
);
brick2 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(127, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(50, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(1),
    green => green1(1),
    blue => blue1(1),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(1),
    flip_r => flip_r(1),
    flip_u => flip_u(1),
    flip_d => flip_d(1)
);

brick3 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(205, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(50, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(2),
    green => green1(2),
    blue => blue1(2),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(2),
    flip_r => flip_r(2),
    flip_u => flip_u(2),
    flip_d => flip_d(2)
);
brick4 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(283, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(50, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(3),
    green => green1(3),
    blue => blue1(3),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(3),
    flip_r => flip_r(3),
    flip_u => flip_u(3),
    flip_d => flip_d(3)
);

brick5 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(361, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(50, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(4),
    green => green1(4),
    blue => blue1(4),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(4),
    flip_r => flip_r(4),
    flip_u => flip_u(4),
    flip_d => flip_d(4)
);

brick6 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(439, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(50, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(5),
    green => green1(5),
    blue => blue1(5),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(5),
    flip_r => flip_r(5),
    flip_u => flip_u(5),
    flip_d => flip_d(5)
);

brick7 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(517, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(50, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(6),
    green => green1(6),
    blue => blue1(6),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(6),
    flip_r => flip_r(6),
    flip_u => flip_u(6),
    flip_d => flip_d(6)
);

brick8 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(595, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(50, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(7),
    green => green1(7),
    blue => blue1(7),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(7),
    flip_r => flip_r(7),
    flip_u => flip_u(7),
    flip_d => flip_d(7)
);

brick9 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(673, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(50, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(8),
    green => green1(8),
    blue => blue1(8),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(8),
    flip_r => flip_r(8),
    flip_u => flip_u(8),
    flip_d => flip_d(8)
);

brick10 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(751, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(50, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(9),
    green => green1(9),
    blue => blue1(9),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(9),
    flip_r => flip_r(9),
    flip_u => flip_u(9),
    flip_d => flip_d(9)
);

brick11 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(49, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(106, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(10),
    green => green1(10),
    blue => blue1(10),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(10),
    flip_r => flip_r(10),
    flip_u => flip_u(10),
    flip_d => flip_d(10)
);
brick12 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(127, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(106, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(11),
    green => green1(11),
    blue => blue1(11),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(11),
    flip_r => flip_r(11),
    flip_u => flip_u(11),
    flip_d => flip_d(11)
);

brick13 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(205, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(106, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(12),
    green => green1(12),
    blue => blue1(12),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(12),
    flip_r => flip_r(12),
    flip_u => flip_u(12),
    flip_d => flip_d(12)
);
brick14 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(283, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(106, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(13),
    green => green1(13),
    blue => blue1(13),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(13),
    flip_r => flip_r(13),
    flip_u => flip_u(13),
    flip_d => flip_d(13)
);

brick15 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(361, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(106, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(14),
    green => green1(14),
    blue => blue1(14),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(14),
    flip_r => flip_r(14),
    flip_u => flip_u(14),
    flip_d => flip_d(14)
);

brick16 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(439, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(106, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(15),
    green => green1(15),
    blue => blue1(15),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(15),
    flip_r => flip_r(15),
    flip_u => flip_u(15),
    flip_d => flip_d(15)
);

brick17 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(517, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(106, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(16),
    green => green1(16),
    blue => blue1(16),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(16),
    flip_r => flip_r(16),
    flip_u => flip_u(16),
    flip_d => flip_d(16)
);

brick18 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(595, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(106, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(17),
    green => green1(17),
    blue => blue1(17),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(17),
    flip_r => flip_r(17),
    flip_u => flip_u(17),
    flip_d => flip_d(17)
);

brick19 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(673, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(106, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(18),
    green => green1(18),
    blue => blue1(18),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(18),
    flip_r => flip_r(18),
    flip_u => flip_u(18),
    flip_d => flip_d(18)
);

brick20 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(751, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(106, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(19),
    green => green1(19),
    blue => blue1(19),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(19),
    flip_r => flip_r(19),
    flip_u => flip_u(19),
    flip_d => flip_d(19)
);

brick21 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(49, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(162, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(20),
    green => green1(20),
    blue => blue1(20),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(20),
    flip_r => flip_r(20),
    flip_u => flip_u(20),
    flip_d => flip_d(20)
);
brick22 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(127, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(162, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(21),
    green => green1(21),
    blue => blue1(21),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(21),
    flip_r => flip_r(21),
    flip_u => flip_u(21),
    flip_d => flip_d(21)
);

brick23 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(205, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(162, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(22),
    green => green1(22),
    blue => blue1(22),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(22),
    flip_r => flip_r(22),
    flip_u => flip_u(22),
    flip_d => flip_d(22)
);
brick24 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(283, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(162, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(23),
    green => green1(23),
    blue => blue1(23),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(23),
    flip_r => flip_r(23),
    flip_u => flip_u(23),
    flip_d => flip_d(23)
);

brick25 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(361, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(162, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(24),
    green => green1(24),
    blue => blue1(24),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(24),
    flip_r => flip_r(24),
    flip_u => flip_u(24),
    flip_d => flip_d(24)
);

brick26 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(439, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(162, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(25),
    green => green1(25),
    blue => blue1(25),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(25),
    flip_r => flip_r(25),
    flip_u => flip_u(25),
    flip_d => flip_d(25)
);

brick27 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(517, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(162, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(26),
    green => green1(26),
    blue => blue1(26),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(26),
    flip_r => flip_r(26),
    flip_u => flip_u(26),
    flip_d => flip_d(26)
);

brick28 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(595, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(162, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(27),
    green => green1(27),
    blue => blue1(27),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(27),
    flip_r => flip_r(27),
    flip_u => flip_u(27),
    flip_d => flip_d(27)
);

brick29 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(673, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(162, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(28),
    green => green1(28),
    blue => blue1(28),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(28),
    flip_r => flip_r(28),
    flip_u => flip_u(28),
    flip_d => flip_d(28)
);

brick30 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(751, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(162, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(29),
    green => green1(29),
    blue => blue1(29),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(29),
    flip_r => flip_r(29),
    flip_u => flip_u(29),
    flip_d => flip_d(29)
);

brick31 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(49, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(218, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(30),
    green => green1(30),
    blue => blue1(30),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(30),
    flip_r => flip_r(30),
    flip_u => flip_u(30),
    flip_d => flip_d(30)
);
brick32 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(127, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(218, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(31),
    green => green1(31),
    blue => blue1(31),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(31),
    flip_r => flip_r(31),
    flip_u => flip_u(31),
    flip_d => flip_d(31)
);

brick33 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(205, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(218, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(32),
    green => green1(32),
    blue => blue1(32),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(32),
    flip_r => flip_r(32),
    flip_u => flip_u(32),
    flip_d => flip_d(32)
);
brick34 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(283, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(218, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(33),
    green => green1(33),
    blue => blue1(33),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(33),
    flip_r => flip_r(33),
    flip_u => flip_u(33),
    flip_d => flip_d(33)
);

brick35 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(361, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(218, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(34),
    green => green1(34),
    blue => blue1(34),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(34),
    flip_r => flip_r(34),
    flip_u => flip_u(34),
    flip_d => flip_d(34)
);

brick36 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(439, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(218, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(35),
    green => green1(35),
    blue => blue1(35),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(35),
    flip_r => flip_r(35),
    flip_u => flip_u(35),
    flip_d => flip_d(35)
);

brick37 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(517, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(218, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(36),
    green => green1(36),
    blue => blue1(36),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(36),
    flip_r => flip_r(36),
    flip_u => flip_u(36),
    flip_d => flip_d(36)
);

brick38 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(595, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(218, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(37),
    green => green1(37),
    blue => blue1(37),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(37),
    flip_r => flip_r(37),
    flip_u => flip_u(37),
    flip_d => flip_d(37)
);

brick39 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(673, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(218, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(38),
    green => green1(38),
    blue => blue1(38),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(38),
    flip_r => flip_r(38),
    flip_u => flip_u(38),
    flip_d => flip_d(38)
);

brick40 : brick
PORT MAP (
    v_sync => v_sync,
    brick_x => CONV_STD_LOGIC_VECTOR(751, 11),
    brick_y => CONV_STD_LOGIC_VECTOR(218, 11),
    power_up => '0',
    pixel_row => pixel_row,
    pixel_col => pixel_col,
    brick_alive => l_brick_alive,
    red => red1(39),
    green => green1(39),
    blue => blue1(39),
    ball_y_out => ball_y_out,
    ball_x_out => ball_x_out,
    bsize_out => bsize_out,
    game_on => game_on,
    flip_l => flip_l(39),
    flip_r => flip_r(39),
    flip_u => flip_u(39),
    flip_d => flip_d(39)
);

end Behavioral;
