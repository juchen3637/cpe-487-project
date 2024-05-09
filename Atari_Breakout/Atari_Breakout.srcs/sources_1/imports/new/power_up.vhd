LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity power_up is
    Port (
        v_sync : IN STD_LOGIC;
        brick_x : IN std_logic_vector (10 DOWNTO 0); --brick_x as input
        brick_y : IN std_logic_vector (10 DOWNTO 0); --brick_y as input
        pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        brick_alive : IN std_logic:='1';
        red : OUT STD_LOGIC;
        green : OUT STD_LOGIC;
        blue : OUT STD_LOGIC;
        bsize : IN INTEGER;
        game_on : IN STD_LOGIC;
        bat_x : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
        bat_changer : OUT INTEGER;
        choice : IN INTEGER
    );
end power_up;

architecture Behavioral of power_up is
    SIGNAL void: std_logic := '0';
    SIGNAL ball_on : std_logic;
    SIGNAL ball_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := brick_x;
    SIGNAL ball_y : STD_LOGIC_VECTOR(10 DOWNTO 0) := brick_y;
    SIGNAL flip : STD_LOGIC := '0'; 
    -- bat properities:
    CONSTANT bat_y : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(500, 11);
    CONSTANT bat_w : INTEGER := 40; -- bat width in pixels
    CONSTANT bat_h : INTEGER := 4; -- bat height in pixels
begin
    red <= ball_on when choice=2 else
        '0';
    green <= ball_on when choice=1 else
        '0';
    blue <= '0';
    ball_draw : process (ball_x, ball_y, pixel_row, pixel_col) is
        VARIABLE vx, vy : STD_LOGIC_VECTOR(10 DOWNTO 0);
    BEGIN 
        if brick_alive='0' and void='0' then
            IF pixel_col <= ball_x THEN -- vx = |ball_x - pixel_col|
                vx := ball_x - pixel_col;
            ELSE
                vx := pixel_col - ball_x;
            END IF;
            IF pixel_row <= ball_y THEN -- vy = |ball_y - pixel_row|
                vy := ball_y - pixel_row;
            ELSE
                vy := pixel_row - ball_y;
            END IF;
            IF ((vx * vx) + (vy * vy)) < (bsize * bsize) THEN -- test if radial distance < bsize
                ball_on <= '1';
            ELSE
                ball_on <= '0';
            END IF;
        else
            ball_on <= '0';
        end if;
    END PROCESS;
    power_up_move: process is
    begin
        wait until rising_edge(v_sync);
        if brick_alive='0' and game_on='1' then
            flip <= '1';
        end if;
        if (choice=1 or choice=2) and void='0' and brick_alive='0' then
            ball_y <= ball_y + 2;
        elsif (choice=0 or choice=3) and void='0' and brick_alive='0' then
            void <= '1';
        end if;
        IF (((ball_x + bsize/2) >= (bat_x - (bat_w))) OR
           ((bat_w) > bat_x and (ball_x + bsize/2) >= bat_x)) AND
           (ball_x - bsize/2) <= (bat_x + (bat_w)) AND
           (ball_y + bsize/2) >= (bat_y - bat_h) AND
           (ball_y - bsize/2) <= (bat_y + bat_h) AND
            brick_alive='0' THEN
            if choice=1 and flip='1' then
                bat_changer <= 5;
            elsif choice=2 and flip='1' then
                bat_changer <= -5;
            end if;
            void <= '1';
        end if;
        if ball_y>CONV_STD_LOGIC_VECTOR(595, 11) then
            void <= '1';
        end if;
        if game_on='0' then
            void <= '0';
            flip <= '0';
            bat_changer <= 0;
            ball_x <= brick_x;
            ball_y <= brick_y;
        end if;
        if brick_alive='1' then
            ball_x <= brick_x;
            ball_y <= brick_y;
        end if;
    end process;
end Behavioral;
