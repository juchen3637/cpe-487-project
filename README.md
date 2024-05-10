# CPE 487 Project (Atari Breakout)
Authors: Justin Chen, Joseph Stefanoni

Remake of Atari Breakout utilizing VHDL & Nexys A7 100-T board, referencing source code from (Lab 6) https://github.com/byett/dsd/tree/CPE487-Spring2024/Nexys-A7/Lab-6

Utilizing these alternate files to use BTNL and BTNR buttons on board to move the bat rather than a potentiometer
https://github.com/byett/dsd/tree/CPE487-Spring2024/Nexys-A7/Lab-6/Alternative

# Block Diagram
![block_diagram](https://github.com/juchen3637/cpe-487-project/blob/main/487%20Block%20Diagram.png)

# Expected behavior
After connecting the board to a power source and monitor via a VGA to HDMI adapter, the screen should display a black background with a cyan bat and 40 red bricks. When pressing the BTNC button on the board the game should start by spawning a red ball that bounces off the bricks, sides of the screen, and bat. When the ball hits the bricks the bricks will become deleted. Certain bricks are modified to drop a power up that will slowly drop to the bottom. If the bat interacts with the power up, the bat's width will increase or decrease. Green power ups will increase the width by 5 pixels while red power ups will decrease the width by 5 pixels. The power ups are in the shape of a ball. The player can move the bat by using the buttons to the left and to the right of BTNC. Once all the bricks are broken, the game can only reset when the ball is dropped and the BTNC button is pressed again. Using the J15 switch, when turned on, will cause the game to be slightly harder by making the starting width of the bat twenty pixels less and the ball speed is faster.

# Steps needed to run on board
In order to run this program, you must download the (9) source files from https://github.com/juchen3637/cpe-487-project/tree/main/Atari_Breakout/Atari_Breakout.srcs/sources_1/imports/new and put them into a new Vivado project under the source files. You must also download the contraint file from https://github.com/juchen3637/cpe-487-project/tree/main/Atari_Breakout/Atari_Breakout.srcs/constrs_1/imports/new and move it into the Vivado under the constraint files. Lastly, you must have the board connected to a monitor using a VGA to HDMI adapter. Then generate the bitstream and program the device.
# Inputs & Outputs
For our inputs, we have BTNL, BTNC, and BTNR as our button inputs, hard_mode as J15 switch input, and we have the VGA screen and the leddec display as outputs. We added the J15 switch input as a way of turning on "hard_mode" in the game which increases the ball speed and decreases the initial bat width.
# Images/Videos
  Easy Mode Test Video (will need to download to see):
    https://github.com/juchen3637/cpe-487-project/blob/main/Easy_Mode_Test.mov
    
  Hard Mode Test Video (will need to download to see):
    https://github.com/juchen3637/cpe-487-project/blob/main/Hard_Mode_Test.mov
# Modifications
  The starter code comes from Lab 6's pong project.
  ## Pong Modifications:
  In the pong.vhd file, we added the switch input as the variable named "hard_mode" and added the anode and segment arrays as inputs as well. We also include the buttons BTNL and BTNR as inputs for later moving our bat left and right. We also added the component and proper signals needed for the leddec16 display to work. We changed the speed of the bat movement from adding/subtracting 10 to 13 so that the bat would move faster when pushing the buttons. We changed the signals "S_red", "S_green", and "S_blue" to be two bits instead of 1 and in the vga_sync instance, we had them & with "11" instead of "000" to give the screen a brighter look. 
  ## Bat_n_ball Modifications:
  In the bat_n_ball.vhd file, we changed the values of the output variables "red", "green", and "blue" to be 2 bits instead of 1. We created a new output variable called "game_on_out" to initially be set to '0' which would be sent to children components. We also created a new input variable called "hard_mode" whose value came from the pong.vhd file. In the architecture, we created four new signals called "flip_l", "flip_r", "flip_u", and "flip_d" which were each 40 bits long and set initially to all zeroes. We also created three new signal called "l_red", "l_green", and "l_blue" each as single bits. Lastly, we added a new integer signal called "bat_changer" which was initially set to 0. In bat_n_ball, the "level" component is added and used as a child of bat_n_ball. We modified the code so that when hard_mode was set to "1" (the switch J15 was switched on) then the "ball_speed" would be set to 5 and the "bat_w" (bat width) would be set to 25 pixels, otherwise, the "ball_speed" would be set to 3 and "bat_w" would be set to 35 pixels. The variable "game_on_out" gets set to the value of "game_on" every rising edge of "v_sync" in the "mball" (move ball) process. In that same process, there are if statements to check if the four flip signal we created are set to 0. If not, then the ball's motion is flipped in the corresponding direction. (For example, if there is a 1 in the "flip_l" variable, then the ball's x motion will inverse so that it will move left.) The code for checking if the ball is touching the bat has also been modified so that the variable "bat_changer" (an output from level.vhd) is added to the bat width. This is for when the bat's size increases or decreases, then the check will include that change. The color ouputs "red", "green", and "blue" have also been & with the corresponding "l_red", "l_green", and "l_blue" signals which are outputted from the "level1" module ("level.vhd" component). This basically takes in the color signals used in "bat_n_ball" as the first bit and the color signals in "level.vhd" as the second bit and outputs them together to "pong.vhd".
  ## Level Modifications:
  level.vhd is a newly created file from us which is used as the in-between for "bat_n_ball.vhd" and "brick.vhd" for sending signals. It's main goal is instantiating 40 instances of the "brick.vhd" components onto the screen with set x and y positions and the value "choice" indicating whether or not it has a good power up, a bad power up, or no power up. It uses 40 bit signals for each of the three colors that are going to get outputted to "bat_n_ball". But since the color outputs need to be one bit each, the code in "level" uses the outputted "red" bit as one bit in its main "red1" signal. If the "red1" signal does not equal 0 (aka one of the red bits is equal to 1), then the outputted "red" signal is '1'. Same for the other two colors. This method is basically a faster way of "or"ing all the signals at once. Lastly, "level.vhd" has an integer output called "bat_changer_total" which represents the total amount of pixels needed to change the bat by inside "bat_n_ball". It is set to the addition of all 40 "brick"'s "bat_changer" values. In other words, If two of the bricks had the increase power up active, then "bat_changer_total" would be set to 4 and be outputted to "bat_n_ball".
  ## Brick Modifications:
  brick.vhd is another newly created file and sends signals between "level.vhd" and "power_up.vhd". It's primary goals are to draw a brick on the screen given inputted coordinates, and check for a collision with the ball in which the drawn brick will disappear. It sends appropriate signals to "level.vhd" (and later to bat_n_ball) to signify which part of the brick was hit and therefore which direction the ball should bounce. It does this by having four separate "collision boxes" which are 4 skinny rectangles representing the edges of the brick, allowing the ball to know which way to bounce. It takes in inputs from "level.vhd" (and bat_n_ball) for knowing when game_on='1' so that the brick can get redrawn when the game restarts. "brick.vhd" also outputs an "alive" signal to "power_up.vhd" which is used for spawning in the power ups later. "brick.vhd"'s color outputs are "or"ed with the color output of "power_up.vhd". In other words, both use the same bit to draw to the screen and if either one is active, the the color outputted will be active.
  ## Power_up Modifications:
  power_up.vhd is also a new file that was created as a child of "brick.vhd". It's focus is to see when the brick gets destroyed and checks to see if it contains a good power up, a bad power up, or neither. If it does contain a power up, a colored ball will spawn from the position of where the brick was and will slowly fall to the bottom of the screen. The color of the ball reflects whether or not the power up is good or bad. The ball is drawn using the same process as "ball_draw" from the "bat_n_ball.vhd" file. If the bat touches the power up, then it will disappear and the bat will output the correct signal as "bat_changer" to tell bat_n_ball to modify the bat width correctly. If the power up does not get picked up and touches the bottom of the screen, then it will disappear and not activate.
## pong.xdc Modifications:
  Added J15 switch input as the name "hard_mode". This is used in "bat_n_ball" for determining the speed of the ball and initial width of the bat. Also added the anodes and segments used in the leddec16 display file.

# Summary
  We worked on this project together and took turns from a person's computer writing code. Most of it was talked out between each other. We each spent 14-16 hours working on this project from 5/6 to 5/9. We first started with taking the pong file and making any changes that we needed, like adding the leddec16 file in to allow us to use the provided alternate files for utilizing the buttons on the board to move the bat rather than the potentiometer and removing unnecessary variables. We then started creating the level and brick modules. Originally, we had level extend from pong instead of bat_n_ball and decided to change that later due to all the signals being sent from each other. We started out by trying to draw one brick to the screen using the same formula used to draw the bat, but had a very hard time understanding how to output the colors since the "bat_n_ball" file was already using the colors that were sent to the vga_sync module. It took us a while but we learned that we could set the second bit of each color in pong as an output from anything drawn in "level.vhd". (This ultimately was solved later when we realized we could just "or" color signals together to get one output). After figuring out how to draw bricks on the screen we then encountered the next obstacle of collision checking the brick with the moving ball. Our solution was to write a constant process inside of the brick file which used the passed-in x and y values of where the brick was drawn to check if the ball touches the left, right, top, or bottom of the brick. This would then send an output flip signal to bat_n_ball which caused the ball to invert it's speed accordingly. We also made the bricks disappear once it was touched by adding a "brick_alive" signal which would turn to "0" after it collided with the ball. The brick drawing was also synced with "game_on" which made it redraw every time a new game was started, making it replayable and retestable without constantly being reprogrammed. We then wanted to implement a power-up drop every time the player hit a brick, we first created the "power_up" file which used the same formula to draw the ball in bat_n_ball. We drew the ball at the center of the bricks using the already passed in brick_x and brick_y inputs, we then made a process that checked if the brick was dead or alive and if it was dead then the ball would begin falling downwards towards the end of the screen. Next, our goal was to create a randomizer to randomly choose which brick contained the power-up or power-down or nothing at all, our approach was to create a counter process that took in v_sync as a parameter and incremented by 1 each time. We then modded the counter by 4 and if the result of the counter modded by 4 was 1 then it was a power-up, if it was 2 then it was a power-down, if it was 3 or 0 then it would be nothing. This ultimately did not work as we did not see any bricks appear on the screen and we believe it was because the counter wasn't counting in the first place. We then decided to remedy this by hard coding the values into the bricks themselves and choosing which ones had the good and bad power ups. We also copied the same collision logic to allow the ball to bounce off the bat in bat_n_ball to allow the player to collect the power ups, the increasing or decreasing values of these powers would be added to a 40-size integer array that would be totaled and passed back into bat_n_ball to increase or decrease the size of the bat accordingly. During this project we also encountered multiple random spawn errors that wouldn't tell us any information or errors with being able to program newly generated bitstreams to the board, we resolved these issues by constantly making new projects inside of Vivado and importing the files again. We also added some final changes by incorporating 2 separate modes for our game, an easy mode where your bat starts larger and the ball moves at a normal speed, and a harder mode where the bat starts smaller and the ball moves faster. These modes can be toggled using the J15 switch. If we had more time we could have further improved the project by adding more power-ups such as a score multiplier or increasing the amount of balls on the screen, adding more levels the user can play after completing the game, and a scoreboard so the user can track their progress. 
