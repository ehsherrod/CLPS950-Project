% Clear the workspace and the screen
sca;
close all;
clear;

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

circlecolor = black; % border color
penWidth = 3; % border width

% Define dimensions of grid using pixel coordinates, and # of shapes
DistractorX_loc = linspace(100, 500, 10);
DistractorY_loc = linspace(100, 500, 10);
Distractor_mat = [DistractorX_loc, DistractorY_loc];

% Loops through the positions for each shape, drawing 10x10 grid of circles
% Given screen = 600 x 600 pixels,
% Pentagon Location: (8, 2) = Pixel Location: (412, 145)
% Pentagon Location: (3, 7) = Pixel Location: (190, 368)
% Pentagon Location: (6, 9) = Pixel Location: (190, 368)

% If we make variables to loop through...
%pent_coordX = [8, 3];
%pent_coordY = [2, 7];
%pent_pixelX = [412, 190];
%pent_pixelY = [145, 368];

for x = 1:length(DistractorX_loc)
    for y = 1:length(DistractorY_loc)  
        if (x == 6) && (y == 9)
            numSides = 5;
            anglesDeg = linspace(0, 360, numSides + 1);
            anglesRad = anglesDeg * (pi / 180);
            radius = 20; 
            xPosVector = -sin(anglesRad) .* radius + 322;
            yPosVector = -cos(anglesRad) .* radius + 457;
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