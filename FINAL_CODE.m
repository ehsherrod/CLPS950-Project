% FINAL CODE (3/24 1PM)

% GENERAL SET-UP FOR PTB/SCREEN
sca; % Clearing previous screens
close all;
clear;
PsychDefaultSetup(2); % Setting up Psychtoolbox
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber); black = BlackIndex(screenNumber); % Defining colors
screensize = [0 0 600 600]; % Screensize
% Open an on screen window and color it white
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white, screensize);
% Set the blend function for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
[screenXpixels, screenYpixels] = Screen('WindowSize', window); % Windowsize
[xCenter, yCenter] = RectCenter(windowRect); % Finding center of screen

% TITLE PAGE: "Visual Search Task"
% Displays characters while specifying color, font, location 
Screen('TextSize', window, 60); Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Visual Search Task', 'center', screenYpixels*0.25, black);
% Subtitles
Screen('TextSize', window, 25); Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'A CLPS950 Project by Monica, Shay, & Eden', 'center', screenYpixels*0.75, black);
% EXIT subtitle
Screen('TextSize', window, 20); Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'press any key to continue', 'center', screenYpixels*0.95, black);

Screen('Flip', window); % Flips to display the window on the screen
KbStrokeWait; % Pressing any key to end

%INSTRUCTIONS SLIDE FOR TASK
Screen('TextSize', window, 30); Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Instructions:', 'center', screenYpixels*0.35, black);
% Same format as earlier, with longer instructions
Screen('TextSize', window, 15); Screen('TextFont', window, 'Times');
Instructions = ['You will be presented figures of shapes for 3 seconds.\n\n', ...
    'Identify whether there is an target shape (non-circle) present or not.\n\n\n\n', ...
    'Record your answer when prompted by the response page by pressing the\n\n', ...
    'space bar to indicate there is an target shape present.\n\n', ...
    'Press nothing otherwise.'];  
DrawFormattedText(window, Instructions, 'center', screenYpixels*0.5, black);  
% EXIT subtitle
Screen('TextSize', window, 10); Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'press any key to continue', 'center', screenYpixels*0.95, black);

Screen('Flip', window);
KbStrokeWait;

% Make a base square of 40 by 40 pixels which each distractor circle fits inside
% Make a base square of 35 by 35 pixels for target square shape
baseSquare = [0 0 40 40]; baseSquare2 = [0 0 35 35];
color = black; % border color
penWidth = 3; % border width
% Define dimensions of grid using pixel coordinates, and # of shapes
DistractorX_loc = linspace(100, 500, 10);
DistractorY_loc = linspace(100, 500, 10);

% Shape position of each target in Grid for Trials
% 1st 3 digits: square trials, 2nd 3 = pentagon trials, 3rd 3 = heptagon
target_posX = [3, nan, 9, 6, 8, nan, 5, nan, 1];
target_posY = [2, nan, 7, 9, 2, nan, 10, nan, 8];

% Pixel Coordinates of each target in Grid for Trials
% same format as the shape position vectors(1st 3 digits: square trials)
target_pixelX = [189, nan, 456, 322, 412, nan, 278, nan, 100];
target_pixelY = [145, nan, 367, 457, 145, nan, 500, nan, 411];

% Initialising for the score keeping 
KbName('UnifyKeyNames');
activeKeys = [KbName('space')]; % define the key that will be used to make a response.
RestrictKeysForKbCheck(activeKeys); % only accept the active keys. i.e a respsonse can only be made with the space bar
ListenChar(2); % suppress echo to the command line for keypresses
t2wait = 2; % time to wait for response (in seconds)
score  = 0;

% SQUARE TRIALS
% The following series of loops run through the first three trials, creating 3 different grids
% in which the location of the target changes/might not be present. There
% is a target present in trial 1 and 3, and no target present in trial 2.
for trial_num = 1:3
    for x = 1:length(DistractorX_loc)
        for y = 1:length(DistractorY_loc)
            if (x == target_posX(trial_num)) && (y == target_posY(trial_num))
                draw_square = CenterRectOnPointd(baseSquare2, target_pixelX(trial_num),target_pixelY(trial_num));
                Screen('FrameRect', window, color, draw_square, penWidth);
            else
                draw_circle = CenterRectOnPointd(baseSquare, DistractorX_loc(x), DistractorY_loc(y));
                Screen('FrameOval', window, color, draw_circle, penWidth);
            end
        end
    end
Screen('Flip', window);
WaitSecs(2); % Waits 2 seconds before closing

% ANSWER screen & BUTTON Collecting code
Screen('TextSize', window, 30); Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'RESPONSE PAGE', 'center', screenYpixels*0.35, black);
Screen('TextSize', window, 20); Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'press [space] if non-circle was present', 'center', screenYpixels*0.55, black);
Screen('Flip', window);% show response page
tStart = GetSecs; % start time of waiting for key press
timedout = false;
        while ~timedout % while there is still time to respond...
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if(keyIsDown) && (trial_num == 1 || trial_num == 3)  % if space bar is pressed, and the trial contains a non-circle...
                score = score+1; % current score will go up by 1
                break % exit loop
            elseif ~(keyIsDown) && ((keyTime - tStart) > t2wait) && (trial_num == 2)  % if space bar is not pressed, and the trial does not contain a non circle...                score = score+1; 
                score = score+1; % current score will go up by 1
                break %exit loop
            end
            if( (keyTime - tStart) > t2wait)
                timedout = true; % time has run out, you can no longer make a response.
            end
             score; % keep score
        end
        WaitSecs(2);
        score = score;  
RestrictKeysForKbCheck;
ListenChar(1); % re-enable echo command for key press 
end

% PENTAGON TRIALS
% The following series of loops runs through trials 4, 5, and 6, creating 3 different grids
% in which the location of the target changes/might not be present. There
% is a target present in trial 1 and 2, and no target present in trial 3.
for trial_num = 4:6
    for x = 1:length(DistractorX_loc)
        for y = 1:length(DistractorY_loc)  
            if (x == target_posX(trial_num)) && (y == target_posY(trial_num))
                numSides = 5;
                anglesDeg = linspace(0, 360, numSides + 1);
                anglesRad = anglesDeg * (pi/180);
                radius = 20; 
                xPosVector = -sin(anglesRad) .* radius + target_pixelX(trial_num);
                yPosVector = -cos(anglesRad) .* radius + target_pixelY(trial_num);
                Screen('FramePoly', window, color, [xPosVector; yPosVector]', penWidth);
            else 
                draw_circle = CenterRectOnPointd(baseSquare, DistractorX_loc(x), DistractorY_loc(y));
                Screen('FrameOval', window, color, draw_circle, penWidth);
            end
        end
    end
Screen('Flip', window);
WaitSecs(2);

% ANSWER screen & BUTTON Collecting code
Screen('TextSize', window, 30); Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'RESPONSE PAGE', 'center', screenYpixels*0.35, black);
Screen('TextSize', window, 20); Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'press [space] if non-circle was present', 'center', screenYpixels*0.55, black);
Screen('Flip', window);
tStart = GetSecs; 
timedout = false;
        while ~timedout
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if(keyIsDown) && (trial_num == 4 || trial_num == 5)  
                score = score+1; 
                break
            elseif ~(keyIsDown) && ((keyTime - tStart) > t2wait) && (trial_num == 6) 
                score = score+1; 
                break
            end
            if( (keyTime - tStart) > t2wait)
                timedout = true;
            end
             score;
        end
        WaitSecs(2);
        score = score;  
RestrictKeysForKbCheck;
ListenChar(1);
end

% HEPTAGON TRIALS
% The following series of loops runs through trials 7, 8, and 9, creating 3 different grids
% in which the location of the target changes/might not be present. There
% is a target present in trial 1 and 3, and no target present in trial 2.
for trial_num = 7:9
    for x = 1:length(DistractorX_loc)
        for y = 1:length(DistractorY_loc)  
            if (x == target_posX(trial_num)) && (y == target_posY(trial_num))
                numSides = 7;
                anglesDeg = linspace(0, 360, numSides + 1);
                anglesRad = anglesDeg * (pi/180);
                radius = 20; 
                xPosVector = -sin(anglesRad) .* radius + target_pixelX(trial_num);
                yPosVector = -cos(anglesRad) .* radius + target_pixelY(trial_num);
                Screen('FramePoly', window, color, [xPosVector; yPosVector]', penWidth);
            else 
                draw_circle = CenterRectOnPointd(baseSquare, DistractorX_loc(x), DistractorY_loc(y));
                Screen('FrameOval', window, color, draw_circle, penWidth);
            end
        end
    end
Screen('Flip', window);
WaitSecs(2);

% ANSWER screen & BUTTON Collecting code
Screen('TextSize', window, 30); Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'RESPONSE PAGE', 'center', screenYpixels*0.35, black);
Screen('TextSize', window, 20); Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'press [space] if non-circle was present', 'center', screenYpixels*0.55, black);
Screen('Flip', window);
tStart = GetSecs; 
timedout = false;
        while ~timedout
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if(keyIsDown) && (trial_num == 7 || trial_num == 9)  
                score = score+1; 
                break
            elseif ~(keyIsDown) && ((keyTime - tStart) > t2wait) && (trial_num == 8) 
                score = score+1; 
                break
            end
            if ((keyTime - tStart) > t2wait)
                timedout = true;
            end
             score;
        end
        WaitSecs(2);
        score = score;  
RestrictKeysForKbCheck;
ListenChar(1);
end

% RESULTS SCORE PAGE
Screen('TextSize', window, 20); Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Congratulations! You have completed the task :)', 'center', screenYpixels*0.35, black);
% SCORE
Screen('TextSize', window, 15); Screen('TextFont', window, 'Times');
DrawFormattedText(window, sprintf('Your score: %d\n', score), 'center', screenYpixels*0.6, black);
% EXIT subtitle
Screen('TextSize', window, 12); Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'press any key to exit', 'center', screenYpixels*0.95, black);

Screen('Flip', window); % Displays window to the screen
KbStrokeWait; % Waits for any key to be pressed
sca; % clears screen
