# CPE 487 Project (Atari Breakout)
Authors: Justin Chen, Joseph Stefanoni

Remake of Atari Breakout utilizing VHDL & Nexys A7 100-T board, referencing source code from https://github.com/byett/dsd/tree/CPE487-Spring2024/Nexys-A7/Lab-6

Utilizing these alternate files to use BTNL and BTNR buttons on board to move the bat rather than a potentiometer

# Expected behavior
After connecting the board to a power source and monitor via a VGA to HDMI adapter, the screen should display a black background with a cyan bat and 40 red bricks. When pressing the BTNC button on the board the game should start by spawning a red ball that bounces off the bricks, sides of the screen, and bat. When the ball hits the bricks the bricks will become deleted. Certain bricks are modified to drop a power up that will slowly drop to the bottom. If the bat interacts with the power up, the bat's width will increase or decrease. Green power ups will increase the width by 5 while red power ups will decrease the width by 5. The power ups are in the shape of a ball. The player can move the bat by using the buttons to the left and to the right of BTNC. Once all the bricks are broken, the game can only reset when the ball is dropped and the BTNC button is pressed again.

# Steps needed to run on board

# Inputs & Outputs
# Images/Videos
# Modifications
# Summary
