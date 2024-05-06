----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2024 01:10:12 PM
-- Design Name: 
-- Module Name: brick - Behavioral
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

entity brick is
    PORT (
        v_sync : IN STD_LOGIC;
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
    
    
end brick;

architecture Behavioral of brick is
    SIGNAL alive : STD_LOGIC := '1';
    SIGNAL brick_on : std_logic;
    SIGNAL brick_w : integer := 60;
    SIGNAL brick_h : integer := 40;
    
begin
    red <= NOT brick_on;
    green <= brick_on;
    blue <= brick_on;
    brick_draw : process (brick_x, brick_y, pixel_row, pixel_col) is
    BEGIN 
        IF ((pixel_col >= brick_x - brick_w) OR (brick_x <= brick_w)) AND
             pixel_col <= brick_x + brick_w AND
             pixel_row >= brick_y - brick_h AND
             pixel_row <= brick_y + brick_h AND
             alive = '1' THEN
                brick_on <= '1';
        ELSE
            brick_on <= '0';
        END IF;
       END PROCESS;
    check_collision : process is
    BEGIN
        WAIT UNTIL rising_edge(v_sync);
        -- Bounce off Bottom of Brick
        if alive = '1' then
            IF (ball_y_out + bsize_out/2) >= (brick_y - brick_h)
            AND (ball_y_out - bsize_out/2) <= (brick_y - brick_h + 15) 
            AND (ball_x_out + bsize_out/2) >= (brick_x - brick_w)
            AND (ball_x_out - bsize_out/2) <= (brick_x + brick_w)  THEN -- bounce off top wall
                flip_d <= '1';
                alive <= '0';
            ELSE
                flip_d <= '0';
            end if;
            -- Bounce off Top of Brick
            IF (ball_y_out + bsize_out/2) >= (brick_y + brick_h - 15)
            AND (ball_y_out - bsize_out/2) <= (brick_y + brick_h) 
            AND (ball_x_out + bsize_out/2) >= (brick_x - brick_w)
            AND (ball_x_out - bsize_out/2) <= (brick_x + brick_w)  THEN -- bounce off top wall
                flip_u <= '1';
                alive <= '0';
            ELSE
                flip_u <= '0';
            end if;
            -- Bounce off Left side of Brick
            IF (ball_y_out + bsize_out/2) >= (brick_y - brick_h)
            AND (ball_y_out - bsize_out/2) <= (brick_y + brick_h) 
            AND (ball_x_out + bsize_out/2) >= (brick_x - brick_w)
            AND (ball_x_out - bsize_out/2) <= (brick_x - brick_w + 15)  THEN -- bounce off top wall
                flip_l <= '1';
                alive <= '0';
            ELSE
                flip_l <= '0';
            end if;
            -- Bounce off Right side of Brick
            IF (ball_y_out + bsize_out/2) >= (brick_y - brick_h)
            AND (ball_y_out - bsize_out/2) <= (brick_y + brick_h) 
            AND (ball_x_out + bsize_out/2) >= (brick_x + brick_w - 15)
            AND (ball_x_out - bsize_out/2) <= (brick_x + brick_w)  THEN -- bounce off top wall
                flip_r <= '1';
                alive <= '0';
            ELSE
                flip_r <= '0';
            end if;
        else
            flip_l <= '0';
            flip_r <= '0';
            flip_u <= '0';
            flip_d <= '0';
        end if;
    End process;
end Behavioral;
