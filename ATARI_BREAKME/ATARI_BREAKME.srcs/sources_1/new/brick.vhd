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
    
    
end brick;

architecture Behavioral of brick is
    SIGNAL alive : STD_LOGIC := '1';
    SIGNAL brick_on : std_logic;
    SIGNAL brick_w : integer := 60;
    SIGNAL brick_h : integer := 40;
    
begin
    red <= brick_on;
    green <= NOT brick_on;
    blue <= NOT brick_on;
    brick_draw : process (brick_x, brick_y, pixel_row, pixel_col) is
    BEGIN 
        IF ((pixel_col >= brick_x - brick_w) OR (brick_x <= brick_w)) AND
             pixel_col <= brick_x + brick_w AND
             pixel_row >= brick_y - brick_h AND
             pixel_row <= brick_y + brick_h THEN
                brick_on <= '1';
        ELSE
            brick_on <= '0';
        END IF;
       END PROCESS;

end Behavioral;
