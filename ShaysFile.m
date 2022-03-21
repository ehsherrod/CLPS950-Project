% Code for multiple circles screen!
% prep workspace and screen
sca;
close all;
clear;
PsychDefaultSetup(2);
screens = Screen('Screens');
screenNumber = max(screens);

% define b&w
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% screen window 
screensize = [0 0 600 400];
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white, screensize);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

% Make a base Rect of 200 by 200 pixels
baseRect = [0 0 100 100];

% Screen X positions of our shapes
circleXpos = [screenXpixels * 0.25 screenXpixels * 0.5 screenXpixels * 0.75];
numCirclesX = length(circleXpos);

% set shape colors
allColors = black;

% Make our rectangle coordinates
draw_oval = nan(4, 4);
for i = 1:numCirclesX 
    maxDiameter = max(baseRect) * 1.01; 
    penWidth = 6;
    draw_oval(:, i) = CenterRectOnPointd(baseRect, circleXpos(i), yCenter);
   
end

% Draw the circle to the screen
Screen('FrameOval', window, allColors, draw_oval, penWidth);
Screen('Flip', window);

% Wait for a key press
KbStrokeWait;

% Clear the screen
sca;




% drawing image
v = [-10 0; 0 0; 10 0]; % this is three locations at (-10,0), (0,0), and (10,0)
location = randi(size(v, 1));
for i = 1:size(v,1)
    if location == i
        draw_triangle(v(i,:)); %pseudocode, just put in the function for what to draw
    else
        draw_circle(v(i,:));
    end
end

% keeping score
ntrials = 5;
noddball = 3;
trial_types = zeros(ntrials, 1);
trial_types(1:noddball)=1;
shuffle(trial_types);
--- % within this
this_trial = trial_types(ix);
if kbcheck & [this_trial==1]
    score = score + 1;
elseif kbcheck & [this_trial == 0]




%TRIANGLE

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

% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Number of sides for our triangle
numSides = 3;

% Angles at which our polygon vertices endpoints will be. We start at zero
% and then equally space vertex endpoints around the edge of a circle. The
% polygon is then defined by sequentially joining these end points.
anglesDeg = linspace(0, 360, numSides + 1);
anglesRad = anglesDeg * (pi / 180);
radius = 200;

% X and Y coordinates of the points defining out polygon, centred on the
% centre of the screen
yPosVector = sin(anglesRad) .* radius + yCenter;
xPosVector = cos(anglesRad) .* radius + xCenter;

% Set the color of the rect to black
rectColor = black;

% Width of the lines for our frame
lineWidth = 6;

% Draw the rect to the screen
Screen('FramePoly', window, rectColor, [xPosVector; yPosVector]', lineWidth);

% Flip to the screen
Screen('Flip', window);

% Wait for a key press
KbStrokeWait;

% Clear the screen
sca;





% Clear the workspace and the screen
sca;
close all;
clear;

PsychDefaultSetup(2);

rng('default');

screens = Screen('Screens');

screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

%CHANGE SCREENSIZE
screensize = [0 0 600 400];

% Open an on screen window and color it black
% For help see: Screen OpenWindow?
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black, screensize);

% Get the size of the on screen window in pixels
% For help see: Screen WindowSize?
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(windowRect);

% Enable alpha blending for anti-aliasing
% For help see: Screen BlendFunction?
% Also see: Chapter 6 of the OpenGL programming guide
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

% Use the meshgrid command to create our base dot coordinates. This will
% simply be a grid of equally spaced coordinates in the X and Y dimensions,
% centered on 0,0
% For help see: help meshgrid
dim = 10;
[x, y] = meshgrid(-dim:1:dim, -dim:1:dim);

% Here we scale the grid so that it is in pixel coordinates. We just scale
% it by the screen size so that it will fit. This is simply a
% multiplication. Notive the "." before the multiplicaiton sign. This
% allows us to multiply each number in the matrix by the scaling value.
pixelScale = screenYpixels / (dim * 2 + 2);
x = x .* pixelScale;
y = y .* pixelScale;

% Calculate the number of dots
% For help see: help numel
numDots = numel(x);

% Make the matrix of positions for the dots. This need to be a two row
% vector. The top row will be the X coordinate of the dot and the bottom
% row the Y coordinate of the dot. Each column represents a single dot. For
% help see: help reshape
dotPositionMatrix = [reshape(x, 1, numDots); reshape(y, 1, numDots)];


% We can define a center for the dot coordinates to be relaitive to. Here
% we set the centre to be the centre of the screen
dotCenter = [xCenter yCenter];

% Set the color of our dot to be random i.e. a random number between 0 and
% 1
dotColors = rand(3, numDots) .* white;

% Set the size of the dots randomly between 10 and 30 pixels
dotSizes = rand(1, numDots) .* 20 + 10;

% Draw all of our dots to the screen in a single line of code
% For help see: Screen DrawDots
Screen('DrawDots', window, dotPositionMatrix, 1, [0 0 0], [0 0], 1);

% Flip to the screen. This command basically draws all of our previous
% commands onto the screen. See later demos in the animation section on more
% timing details. And how to demos in this section on how to draw multiple
% rects at once.
% For help see: Screen Flip?
Screen('Flip', window);

% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the demo. For help see: help KbStrokeWait
KbStrokeWait;

% Clear the screen. "sca" is short hand for "Screen CloseAll". This clears
% all features related to PTB. Note: we leave the variables in the
% workspace so you can have a look at them if you want.
% For help see: help sca
sca;



% COMBINED INTRO/INSTRUCTIONS/IMAGES/END CODE

%Screen('Preference', 'SkipSyncTests', 1);  

%  INTRODUCTORY SLIDE FOR TASK
% Clear the workspace and the screen
sca;
close all;
clear;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer.
% For help see: Screen Screens?
screens = Screen('Screens');

% Draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen. When only one screen is attached to the monitor we will draw to
% this.
% For help see: help max
screenNumber = max(screens);


% Define black and white (white will be 1 and black 0). This is because
% in general luminace values are defined between 0 and 1 with 255 steps in
% between. With our setup, values defined between 0 and 1.
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;

%CHANGE SCREENSIZE
screensize = [0 0 600 400];

% Open an on screen window and color it black
% For help see: Screen OpenWindow?
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white, screensize);

% Set the blend function for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Get the size of the on screen window in pixels
% For help see: Screen WindowSize?
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(windowRect);

% Draw text in the upper portion of the screen in Times in black
Screen('TextSize', window, 70);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Visual Search Task', 'center', screenYpixels*0.25, black);

% Draw text in the lower portion of the screen in Times in black
Screen('TextSize', window, 25);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'A CLPS950 Project by Monica, Shay, & Eden', 'center', screenYpixels*0.75, black);

% Draw text in the lower portion of the screen in Times in black
Screen('TextSize', window, 10);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'press any key to continue', 'center', screenYpixels*0.95, black);

% Flip to the screen
Screen('Flip', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the demo
KbStrokeWait;

%INSTRUCTIONS SLIDE FOR TASK
% Draw text in the upper portion of the screen in Times in black
Screen('TextSize', window, 30);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Instructions:', 'center', screenYpixels*0.35, black);

% Draw text in the middle of the screen in Times in black
Screen('TextSize', window, 15);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'For each image displayed, identify whether there is an inconsistent shape present or not', 'center', screenYpixels*0.6, black);

% Draw text in the lower portion of the screen in Times in black
Screen('TextSize', window, 10);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'press any key to continue', 'center', screenYpixels*0.95, black);

% Flip to the screen
Screen('Flip', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the demo
KbStrokeWait;

% Make a base Rect of 200 by 200 pixels. This is the rect which defines the
% size of our square in pixels. Rects are rectangles, so the
% sides do not have to be the same length. The coordinates define the top
% left and bottom right coordinates of our rect [top-left-x top-left-y
% bottom-right-x bottom-right-y]. The easiest thing to do is set the first
% two coordinates to 0, then the last two numbers define the length of the
% rect in X and Y. The next line of code then centers the rect on a
% particular location of the screen.
%baseRect will be our indivudal images/figure
baseRect = [0 0 200 200];

% Center the rectangle on the centre of the screen using fractional pixel
% values.
% For help see: CenterRectOnPointd
centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);

% Set the color of our square to full red. Color is defined by red green
% and blue components (RGB). So we have three numbers which
% define our RGB values. The maximum number for each is 1 and the minimum
% 0. So, "full red" is [1 0 0]. "Full green" [0 1 0] and "full blue" [0 0
% 1]. Play around with these numbers and see the result.

rectColor = [1 0 0]; % Define red square...(this will be replaced by the actual images)
Screen('FillRect', window, rectColor, centeredRect);% Display red square...
Screen('Flip', window);
WaitSecs(3);

rectColor = [0 0 0]; % Define black square... (screen will be black, so this could be 
% where the task taker has x seconds (two in this case) to say whether
% all the shapes were the same(right arrow) or not (left arrow))
        %insert if statement here
Screen('FillRect', window, rectColor, centeredRect);% Display black square...
Screen('Flip', window);
WaitSecs(2);

rectColor = [1 1 0]; % Define yellow square... (this will be replaced by the actual images)
Screen('FillRect', window, rectColor, centeredRect);% Display yellow square...
Screen('Flip', window);
WaitSecs(3);


rectColor = [0 0 0]; % Define black square... (screen will be black, so this could be 
% where the task taker has x seconds (two in this case) to say whether
% all the shapes were the same(right arrow) or not (left arrow))
        %insert if statement here
Screen('FillRect', window, rectColor, centeredRect);% Display black square...
Screen('Flip', window);
WaitSecs(2);

rectColor = [0 0 1]; % Define blue square...(this will be replaced by the actual images)
Screen('FillRect', window, rectColor, centeredRect);% Display blue square...
Screen('Flip', window);
WaitSecs(2);
 
% if the figures get more complex, we can increase the time the tester has
% to view the image but keep the time they have to respond the same.

% Draw text in the upper portion of the screen in Times in black
Screen('TextSize', window, 20);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Congratulations! You have completed the task :)', 'center', screenYpixels*0.35, black);

% Draw text in the middle of the screen in Times in black
Screen('TextSize', window, 15);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'SCORE:', 'center', screenYpixels*0.6, black); %After figuring out how to collect responses diplay here.

% Draw text in the lower portion of the screen in Times in black
Screen('TextSize', window, 10);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'press any key to exit', 'center', screenYpixels*0.95, black);

% Flip to the screen
Screen('Flip', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the demo
KbStrokeWait;

% Clear the screen
sca;







% IMAGE DISPLAY CODE

% Clear the workspace and the screen, set up PTB (general intro)
sca;
close all;
clear;

PsychDefaultSetup(2);

screens = Screen('Screens'); % Get the screen numbers

screenNumber = max(screens); % Draw to the external screen if avaliable

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
inc = white - grey;

% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Here we load in an image from file.
theImage = imread("MATLAB\download.jpg");

% Get the size of the image
[s1, s2, s3] = size(theImage);

% Here we check if the image is too big to fit on the screen and abort if
% it is. See ImageRescaleDemo to see how to rescale an image.
% if s1 > screenYpixels || s2 > screenYpixels
%     disp('ERROR! Image is too big to fit on the screen');
%     sca;
%     return;
% end

% Make the image into a texture
imageTexture = Screen('MakeTexture', window, theImage);

% Draw the image to the screen, unless otherwise specified PTB will draw
% the texture full size in the center of the screen. We first draw the
% image in its correct orientation.
Screen('DrawTexture', window, imageTexture, [], [], 0);

% Flip to the screen
Screen('Flip', window);

% Wait for two seconds
WaitSecs(2);

% Clear the screen
sca;
clear screen;




% CODE FOR ANSWERING USING KEYBOARD INPUTS

press = 0;
while press==0
  [z,b,c] = KbCheck;
  if (find(c)==37)  %they chose left
	  press = 1;
  elseif (find(c)==39 %they chose right
	  press = 2;
  elseif (find(c)==27 %they chose esc to bail out
	  press = 3;
	  Screen(‘Closeall’)
	  return
  end
end
