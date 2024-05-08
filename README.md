# CPE 487 Project (Atari Breakout)
Authors: Justin Chen, Joseph Stefanoni

Remake of Atari Breakout utilizing VHDL & Nexys A7 100-T board, referencing source code from https://github.com/byett/dsd/tree/CPE487-Spring2024/Nexys-A7/Lab-6

Utilizing these alternate files to use BTNL and BTNR buttons on board to move the bat rather than a potentiometer

# Expected behavior
After connecting the board to a power source and monitor via a VGA to HDMI adapter, the screen should display a pink background with a cyan bat and 40 white bricks. When pressing the BTNC button on the board the game should start by spawning a red ball that bounces off the bricks, sides of the screen, and bat. When the ball hits the bricks the bricks will become deleted and have a randomized chance of dropping a power up in the form of a falling green ball. If this ball is caught by the bat the player will recieve either a powerup such as an increased bat width or a power down like a decreased bat width. Everytime the player kills a brick their score will go up and be displayed on the 7 segment digital display and when the player kills all the bricks the bricks will all reset and the player can continue infinitely until the ball drops. 
# Inputs & Outputs
# Images/Videos
# Modifications
# Summary
