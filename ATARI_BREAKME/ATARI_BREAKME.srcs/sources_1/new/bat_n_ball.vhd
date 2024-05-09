LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY bat_n_ball IS
    PORT (
        v_sync : IN STD_LOGIC;
        pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        bat_x : IN STD_LOGIC_VECTOR (10 DOWNTO 0); -- current bat x position
        serve : IN STD_LOGIC; -- initiates serve
        red : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        green : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        blue : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        game_on_out : OUT STD_LOGIC := '0'
    );
END bat_n_ball;

ARCHITECTURE Behavioral OF bat_n_ball IS
    SIGNAL flip_l : STD_LOGIC_VECTOR(39 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(0, 40);
    SIGNAL flip_r : STD_LOGIC_VECTOR(39 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(0, 40);
    SIGNAL flip_u : STD_LOGIC_VECTOR(39 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(0, 40);
    SIGNAL flip_d : STD_LOGIC_VECTOR(39 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(0, 40);
    CONSTANT bsize : INTEGER := 8; -- ball size in pixels
    CONSTANT bat_w : INTEGER := 30; -- bat width in pixels
    CONSTANT bat_h : INTEGER := 4; -- bat height in pixels
    -- distance ball moves each frame
    CONSTANT ball_speed : STD_LOGIC_VECTOR (10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR (4, 11);
    SIGNAL ball_on : STD_LOGIC; -- indicates whether ball is at current pixel position
    SIGNAL bat_on : STD_LOGIC; -- indicates whether bat at over current pixel position
    SIGNAL game_on : STD_LOGIC := '0'; -- indicates whether ball is in play
    -- current ball position - intitialized to center of screen
    SIGNAL ball_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(400, 11);
    SIGNAL ball_y : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(300, 11);
    -- bat vertical position
    CONSTANT bat_y : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(500, 11);
    -- current ball motion - initialized to (+ ball_speed) pixels/frame in both X and Y directions
    SIGNAL ball_x_motion, ball_y_motion : STD_LOGIC_VECTOR(10 DOWNTO 0) := ball_speed;
    SIGNAL l_red, l_green, l_blue : STD_LOGIC;
    SIGNAL bat_changer : INTEGER := 0;

    component level is
        PORT (
            v_sync : IN STD_LOGIC;
            lvl_cnt : in std_logic_vector (5 downto 0);
            win : in std_logic;
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
            flip_d : out std_logic_VECTOR(39 DOWNTO 0);
            bat_x : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
            bat_changer_total : OUT INTEGER
        );
    end component;
BEGIN
    red <= ball_on & l_red; -- color setup for red ball and cyan bat on white background
    green <= bat_on & l_green;
    blue <= bat_on & l_blue;
    -- process to draw round ball
    -- set ball_on if current pixel address is covered by ball position
    balldraw : PROCESS (ball_x, ball_y, pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
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
            ball_on <= game_on;
        ELSE
            ball_on <= '0';
        END IF;
    END PROCESS;
    -- process to draw bat
    -- set bat_on if current pixel address is covered by bat position
    batdraw : PROCESS (bat_x, pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= bat_x - (bat_w + bat_changer)) OR (bat_x <= (bat_w+bat_changer))) AND
         pixel_col <= bat_x + (bat_w+bat_changer) AND
             pixel_row >= bat_y - bat_h AND
             pixel_row <= bat_y + bat_h THEN
                bat_on <= '1';
        ELSE
            bat_on <= '0';
        END IF;
    END PROCESS;
    -- process to move ball once every frame (i.e., once every vsync pulse)
    mball : PROCESS
        VARIABLE temp : STD_LOGIC_VECTOR (11 DOWNTO 0);
    BEGIN
        WAIT UNTIL rising_edge(v_sync);
        game_on_out <= game_on;
        IF serve = '1' AND game_on = '0' THEN -- test for new serve
            game_on <= '1';
            ball_y_motion <= (NOT ball_speed) + 1; -- set vspeed to (- ball_speed) pixels
        ELSIF ball_y <= bsize THEN -- bounce off top wall
            ball_y_motion <= ball_speed; -- set vspeed to (+ ball_speed) pixels
        ELSIF ball_y + bsize >= 600 THEN -- if ball meets bottom wall
            ball_y_motion <= (NOT ball_speed) + 1; -- set vspeed to (- ball_speed) pixels
            game_on <= '0'; -- and make ball disappear
        END IF;
        -- allow for bounce off left or right of screen
        IF ball_x + bsize >= 800 THEN -- bounce off right wall
            ball_x_motion <= (NOT ball_speed) + 1; -- set hspeed to (- ball_speed) pixels
        ELSIF ball_x <= bsize THEN -- bounce off left wall
            ball_x_motion <= ball_speed; -- set hspeed to (+ ball_speed) pixels
        END IF;
        -- allow for bounce off bat
        IF (((ball_x + bsize/2) >= (bat_x - (bat_w+bat_changer))) OR
           ((bat_w+bat_changer) > bat_x and (ball_x + bsize/2) >= bat_x)) AND
         (ball_x - bsize/2) <= (bat_x + (bat_w+bat_changer)) AND
             (ball_y + bsize/2) >= (bat_y - bat_h) AND
             (ball_y - bsize/2) <= (bat_y + bat_h) THEN
                ball_y_motion <= (NOT ball_speed) + 1; -- set vspeed to (- ball_speed) pixels
        END IF;
        -- Flipping off Bricks
        if flip_l /= CONV_STD_LOGIC_VECTOR(0, 40) then
            ball_x_motion <= (NOT ball_speed) + 1;
        elsif flip_r /= CONV_STD_LOGIC_VECTOR(0, 40) then
            ball_x_motion <= ball_speed;
        end if;
        if flip_u /= CONV_STD_LOGIC_VECTOR(0, 40) then
            ball_y_motion <= ball_speed;
        elsif flip_d /= CONV_STD_LOGIC_VECTOR(0, 40) then
            ball_y_motion <= (NOT ball_speed) + 1;
        end if;
        -- compute next ball vertical position
        -- variable temp adds one more bit to calculation to fix unsigned underflow problems
        -- when ball_y is close to zero and ball_y_motion is negative
        temp := ('0' & ball_y) + (ball_y_motion(10) & ball_y_motion);
        IF game_on = '0' THEN
            ball_y <= CONV_STD_LOGIC_VECTOR(440, 11);
        ELSIF temp(11) = '1' THEN
            ball_y <= (OTHERS => '0');
        ELSE ball_y <= temp(10 DOWNTO 0); -- 9 downto 0
        END IF;
        -- compute next ball horizontal position
        -- variable temp adds one more bit to calculation to fix unsigned underflow problems
        -- when ball_x is close to zero and ball_x_motion is negative
        temp := ('0' & ball_x) + (ball_x_motion(10) & ball_x_motion);
        IF temp(11) = '1' THEN
            ball_x <= (OTHERS => '0');
        ELSE ball_x <= temp(10 DOWNTO 0);
        END IF;
    END PROCESS;
    
    level1 : level
    PORT MAP (
        v_sync => v_sync,
        lvl_cnt => "000001",
        win => '0', -- this should be an output
        pixel_row => pixel_row,
        pixel_col => pixel_col,
        red => l_red, 
        green => l_green, 
        blue => l_blue,
        ball_y_out => ball_y,
        ball_x_out => ball_x,
        bsize_out => bsize,
        game_on => game_on,
        flip_l => flip_l,
        flip_r => flip_r,
        flip_u => flip_u,
        flip_d => flip_d,
        bat_x => bat_x,
        bat_changer_total => bat_changer
    );
END Behavioral;