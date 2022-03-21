% Clear the workspace and the screen
sca;
close all;
clear;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% haley addition
screensize = [0 0 600 600];

% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white, screensize);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Make a base square of 40 by 40 pixels which your circle fits inside
baseSquare = [0 0 40 40];

% Set the color of the circle to black, this is just a border, not fill
circlecolor = black;

% Set the width of border
penWidth = 3;

% Define dimensions of grid using pixel coordinates, and # of shapes
DistractorX_loc = linspace(100, 500, 10);
DistractorY_loc = linspace(100, 500, 10);
Distractor_mat = [DistractorX_loc, DistractorY_loc];

% Loops through the positions for each shape, drawing 10x10 grid of circles
for x = 1:length(DistractorX_loc)
    for y = 1:length(DistractorY_loc) 
        if (x == 8) & (y==2)
            numSides = 5;
            anglesDeg = linspace(0, 360, numSides + 1);
            anglesRad = anglesDeg * (pi / 180);
            radius = 20;
            yPosVector = -cos(anglesRad) .* radius + 145;
            xPosVector = -sin(anglesRad) .* radius + 412;
            rectColor = black;
            lineWidth = 3;
            Screen('FramePoly', window, rectColor, [xPosVector; yPosVector]', lineWidth);
        else 
            draw_circle = CenterRectOnPointd(baseSquare, DistractorX_loc(x), DistractorY_loc(y));
            Screen('FrameOval', window, circlecolor, draw_circle, penWidth);
        end
    end
end

% Flip to the screen
Screen('Flip', window);

% Wait for a key press
KbStrokeWait;

% Clear the screen 
sca; 