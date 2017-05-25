function trigger = prompter1function(subnumber,sessionnumber,stimulus_time,wordList)

%prompter1 is heavily dependent on PsychToolBox and you need to make sure
%this is installed correctly. If using a laptop with an integrated and
%dedicated GPU, consider turning off the dedicated GPU as this has caused
%issues in the past.
%prompter1 has been adapted from a sample strooptest prompt and heavily
%modified for Thomas's BCI experiment. Some residual parts of this original
%strooptest remain. 
%prompter one displays prompts according to the times set in the timing
%information column. In its current state, each trial lasts 8s. A block is
%composed of 42 trials with 6 trials per word. At the end of the 42 trials
%the code will pause. Pressing a key will start a new block. If you want to
%exit press and hold the escape key as it is checked each trial. If you
%just want to end the block, hold the F12 key during this checking interval

%This code is initiated by F8, ideally in sync with the recording program.
%The TMSi code has a wait for F8 that needs to be ended after you press
%save

%The response matrix produces 6 fields, the first 2 correspond to the
%appearance and disappearance times of the ready prompt. The 3rd
%corresponds to the word number that was displayed. The 4th and 5th
%correspond to the appearance and disappearance of the word prompt. The 6th
%column contains the time stamp that the block started as well as a the
%number of that block. All values are in system time. Each block is
%separated by a row of 10s to show that the results are no longer
%continuous. 

% Clear the workspace
sca;

% Setup PTB with some default values
PsychDefaultSetup(2);
%Screen('Preference', 'SkipSyncTests', 1);

% Seed the random number generator. Here we use the an older way to be
% compatible with older systems. Newer syntax would be rng('shuffle'). Look
% at the help function of rand "help rand" for more information
rand('seed', sum(100 * clock));

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Define black, white and grey

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white * 0.5;

% Open the screen
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

[xCenter, yCenter] = RectCenter(windowRect);


%----------------------------------------------------------------------
%                       Timing Information
%----------------------------------------------------------------------

% Interstimulus interval time in seconds and frames
%isiTimeSecs = 5;
%isiTimeFrames = round(isiTimeSecs / ifi);

%nominalFrameRate = Screen('NominalFrameRate', window);
%second = nominalFrameRate;

% Number of frames to wait before re-drawing
%waitframes = 1;

%in this script the pause function is used to control the timing of
%stimulus presentation. These parameters can be adjusted here:
ready_time = 1;
ready_stimulus_time = 1;
%stimulus_time = 4;
break_time = 3;

%----------------------------------------------------------------------
%                     Colors in words and RGB
%----------------------------------------------------------------------

%wordList should come from the function call
%wordList = {'Walk', 'Lean Back', 'Left Hand', 'Right Hand', 'Left Foot', 'Right Foot', 'Think'}; 
%rgbColors = [1 0 0; 0 1 0; 0 0 1; 0 1 1; 1 0 1];

%Set Text Size
Screen('Preference', 'DefaultFontSize', 150); %Font Size

% Make the matrix which will determine our condition combinations
trialsPerCondition = 6;  % 6 trials per class gives a total of 42 trials per block. Adjust to 7 if you drop a trial type
condMatrixBase = sort(repmat(1:trialsPerCondition, 1, max(length(wordList)))); % original = condMatrixBase = sort(repmat(1:length(wordList), 1, max(length(wordList))));

% Duplicate the condition matrix to get the full number of trials
condMatrix = condMatrixBase; %original = condMatrix = repmat(condMatrixBase, 1, trialsPerCondition);

% Get the size of the matrix
[~, numTrials] = size(condMatrix);

% Randomise the conditions
shuffler = Shuffle(1:numTrials);

%----------------------------------------------------------------------
%                     Make a response matrix
%----------------------------------------------------------------------

%name the session
%subnumber = 1; sessionnumber = 1; %these are set as defaults. On in the
%script, off in the function
session_name = strcat('prompt_imagined','_sub',num2str(subnumber),'_session',num2str(sessionnumber)); %you may want to plant this in the TMSI code
dir_name = 'C:\Users\shielst\ParalysedSubjectProject\Collected_data\'; %this effectively functions as the path to where things are going to be saved
respMat = zeros(numTrials,6); %5 rows so I can display the ready time in the response matrix. The 6th row is for the session start time

%ensure that there is a subject folder to save the results to. If there
%isn't, create a subject folder
folderexists = exist(strcat(dir_name,'/subject',num2str(subnumber)));
if folderexists ~= 7
    mkdir(fullfile(dir_name, (strcat('subject',num2str(subnumber)))));
end

%----------------------------------------------------------------------
%                       Experimental loop
%----------------------------------------------------------------------

% Animation loop: we loop for the total number of trials
blockcounter = 1;

respMatSession = []; %the response matrix for the session starts empty
while 1 == 1
shuffler = Shuffle(1:numTrials);
condMatrixShuffled = condMatrix(:, shuffler);    
trial = 1;
%Create a bell curve of durations with equal dimensions to the condition
%matrix
R = normrnd(stimulus_time,1,[1 numTrials]);

    while trial <= numTrials

        % Word and color number
        wordNum = condMatrixShuffled(1, trial);

        % The color word and the color it is drawn in
        theWord = wordList(wordNum);

        % If this is the first trial we present a start screen and wait for a
        % key-press
        if trial == 1
            Screen('TextSize', window, 80);
            DrawFormattedText(window, 'Imagine the movement \n\n Press Any Key To Begin',...
                'center', 'center', black);
            Screen('Flip', window);
            KbF8 = KbName('f8');
            while 1 == 1
                [~,~,keyCode] = KbCheck;
                if keyCode(KbF8) > 0
                    break
                end
                pause(0.01)
            end
        end

        % Flip again to sync us to the vertical retrace at the same time as
        % drawing our fixation point
        Screen('DrawDots', window, [xCenter; yCenter], 50, black, [], 2);
        Screen('Flip', window);
        pause(break_time)

        % Now we present the isi interval with fixation point minus one frame
        % because we presented the fixation point once already when getting a
        % time stamp

        % Draw the fixation point
        Screen('DrawDots', window, [xCenter; yCenter], 50, black, [], 2);
        % Flip to the screen
        [~, time] = Screen('Flip', window);

        if trial == 1
            tBlockStart = GetSecs;
            trigger = 1;
        end

        % Draw the ready and take a time marker

        DrawFormattedText(window, 'Ready?','center', 'center', black);
        [~, readyappear] = Screen('Flip', window);
        pause(ready_time)

        % Draw the fixation point
        Screen('DrawDots', window, [xCenter; yCenter], 50, black, [], 2);
        [~, readydisappear] = Screen('Flip', window);
        pause(ready_stimulus_time)

        DrawFormattedText(window, char(theWord), 'center', 'center', black); %draw the word from the word matrix
        [~, timeappear] = Screen('Flip', window);
        pause(R(trial)) %hold for standard distribution of the stimulus time
        timedisappear = GetSecs;

        %fill the response matrix
        respMat(trial, 1) = readyappear;
        respMat(trial, 2) = readydisappear;
        respMat(trial, 3) = wordNum;
        respMat(trial, 4) = timeappear;
        respMat(trial, 5) = timedisappear;

        Screen('DrawDots', window, [xCenter; yCenter], 50, black, [], 2);
        Screen('Flip', window);

        [keyIsDown,secs,keyCode] = KbCheck; %If a key is pressed during the disappearance of the stimulus, kill the screen
        KbEscape = KbName('escape'); %this will kill the prompting window
        KbF12 = KbName ('f12'); %this will just end the block prematurely
        
        if keyCode(KbEscape) > 0
            sca
            break
        elseif keyCode(KbF12) > 0
            break
        end

        trial = trial + 1;
    end

%respMat(numTrials+1,:) = 10; 
respMat(1,6) = tBlockStart; %place the block start time in the top right corner of the resp matrix
respMat(2,6) = blockcounter; %place a number indicating which session this block corresponds to
% End of experiment screen. We clear the screen once they have made their
% response
Screen('TextSize', window, 80);
DrawFormattedText(window, 'Round Finished \n\n Press Any Key To Start the next round',...
    'center', 'center', black);
Screen('Flip', window);

%write to CSV and collate data. Take each block as a just in case
block_name = strcat(session_name,'_block',num2str(blockcounter)); %name the last block
csvwrite(strcat(dir_name,'subject',num2str(subnumber),'\',block_name,'.csv'),respMat);
respMat(numTrials+1,:) = 10; % Implant a marker that the block has ended and that there is a break

%collect the data from the session so far. This is the data I will
%hopefully use
respMatSession = [respMatSession; respMat]; %move the block into the overall session response matrix
csvwrite(strcat(dir_name,'subject',num2str(subnumber),'\',session_name,'.csv'),respMatSession);
blockcounter = blockcounter + 1;
KbStrokeWait; %this has been switched to pause function for beta testing. Make sure to switch it back to KbStrokeWait

end
sca;

end