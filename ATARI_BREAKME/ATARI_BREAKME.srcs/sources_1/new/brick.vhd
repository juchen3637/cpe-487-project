LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity brick is
    PORT (
        v_sync : IN STD_LOGIC;
        brick_x : IN std_logic_vector (10 DOWNTO 0);
        brick_y : IN std_logic_vector (10 DOWNTO 0);
        pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        brick_alive : out std_logic := '1';
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
        flip_d : out std_logic;
        bat_x : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
        bat_changer : OUT INTEGER
    );
    
    
end brick;

architecture Behavioral of brick is
    SIGNAL alive : STD_LOGIC := '1';
    SIGNAL brick_on : std_logic;
    SIGNAL brick_w : integer := 37;
    SIGNAL brick_h : integer := 26;
    SIGNAL flip : STD_lOGIC := '0';
    SIGNAL red_pu, green_pu, blue_pu : STD_LOGIC;
    SIGNAL choice : INTEGER := -1;
    SIGNAL count: INTEGER := 0;
begin
    red <= red_pu or '0';
    green <= green_pu or '0';
    blue <= brick_on or blue_pu;
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
        if game_on='1' and flip='1' then
            alive <= '1';
            brick_alive <= '1';
            choice <= -1;
        end if;
        flip <= NOT game_on;
        if alive = '1' then
            IF (ball_y_out + bsize_out/2) >= (brick_y - brick_h)
            AND (ball_y_out - bsize_out/2) <= (brick_y - brick_h + 6) 
            AND (ball_x_out + bsize_out/2) >= (brick_x - brick_w)
            AND (ball_x_out - bsize_out/2) <= (brick_x + brick_w)  THEN -- bounce off top wall
                flip_d <= '1';
                alive <= '0';
                brick_alive <= '0';
            ELSE
                flip_d <= '0';
            end if;
            -- Bounce off Top of Brick
            IF (ball_y_out + bsize_out/2) >= (brick_y + brick_h - 6)
            AND (ball_y_out - bsize_out/2) <= (brick_y + brick_h) 
            AND (ball_x_out + bsize_out/2) >= (brick_x - brick_w)
            AND (ball_x_out - bsize_out/2) <= (brick_x + brick_w)  THEN -- bounce off top wall
                flip_u <= '1';
                alive <= '0';
                brick_alive <= '0';
            ELSE
                flip_u <= '0';
            end if;
            -- Bounce off Left side of Brick
            IF (ball_y_out + bsize_out/2) >= (brick_y - brick_h)
            AND (ball_y_out - bsize_out/2) <= (brick_y + brick_h) 
            AND (ball_x_out + bsize_out/2) >= (brick_x - brick_w)
            AND (ball_x_out - bsize_out/2) <= (brick_x - brick_w + 6)  THEN -- bounce off top wall
                flip_l <= '1';
                alive <= '0';
                brick_alive <= '0';
            ELSE
                flip_l <= '0';
            end if;
            -- Bounce off Right side of Brick
            IF (ball_y_out + bsize_out/2) >= (brick_y - brick_h)
            AND (ball_y_out - bsize_out/2) <= (brick_y + brick_h) 
            AND (ball_x_out + bsize_out/2) >= (brick_x + brick_w - 6)
            AND (ball_x_out - bsize_out/2) <= (brick_x + brick_w)  THEN -- bounce off top wall
                flip_r <= '1';
                alive <= '0';
                brick_alive <= '0';
            ELSE
                flip_r <= '0';
            end if;
        else
            flip_l <= '0';
            flip_r <= '0';
            flip_u <= '0';
            flip_d <= '0';
        end if;
        count <= (count+1) mod 4;
        if alive = '0' and choice=-1 then
            choice <= count;
        end if;
        if choice=1 then
            bat_changer <= 2;
        elsif choice=2 then
            bat_changer <= -2;
        end if;
    End process;
end Behavioral;
