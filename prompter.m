function prompter(subname,sessionnumber,imaginedoractive)

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

%input names:
%subname = the subject number, this defines the folder where the timing
%information wil be saved
%sessionnumber = the session number with this subject
%imagined or active selects whether the word list will be the imagined one
%or the active one
%dir_name probably isn't needed any more



%this version has an added function. If a word in the word list corresponds
%to the word 'Think', the program will randomly generate a maths problem

% Clear the workspace
sca;

% Setup PTB with some default values
PsychDefaultSetup(2);
%Screen('Preference', 'SkipSyncTests', 1);

% Seed the random number generator. Here we use the an older way to be
% compatible with older systems. Newer syntax would be rng('shuffle'). Look
% at the help function of rand "help rand" for more information
% rand('seed', sum(100 * clock));

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

Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');


%----------------------------------------------------------------------
%                       Timing Information
%----------------------------------------------------------------------

%in this script the pause function is used to control the timing of
%stimulus presentation. These parameters can be adjusted here:
ready_time = 2; %set the median ready time
cue_time = 4; %set the median cue time
jitter = 1; %set the jitter, i.e. the timing will deviate by half this value
go_time = 3; %the amount of time that go is shown
break_time = 3; %the amount of time between trials

%----------------------------------------------------------------------
%                       Set the mode of the prompter
%----------------------------------------------------------------------

trialsPerCondition = 6;  % 6 trials per class gives a total of 42 trials per block. Adjust to 7 if you drop a trial type


if strcmp(imaginedoractive,'imagined')
    Instruction = 'Imagine the Movement';
    wordList = {'Imagine \n\nWalking', 'Imagine \n\nLeaning Back', 'Imagine Clenching Your \n\n Left Hand', 'Imagine Clenching Your \n\n Right Hand', 'Imagine Tapping Your \n\n Left Foot', 'Imagine Tapping Your \n\n Right Foot', 'Think'};
    trialsPerCondition = 3; %if imagined is called, only run 3 trials per condition
elseif strcmp(imaginedoractive,'active')
    Instruction = 'Follow the Instruction';
    wordList = {'Lean Right', 'Lean Left', 'Clench Your \n\n Left Hand', 'Clench Your \n\n Right Hand', 'Tap Your \n\n Left Foot', 'Tap Your \n\n Right Foot', 'Think'};
else
    fprintf('you need to set the imagined or active field, defaulting to imagined');
    Instruction = 'Imagine the Movement';
end


%----------------------------------------------------------------------
%                     Create a fixation cross
%----------------------------------------------------------------------
fixCrossDimPix = 40;
xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
allCoords = [xCoords; yCoords];
lineWidthPix = 4;

%----------------------------------------------------------------------
%                     Colors in words and RGB
%----------------------------------------------------------------------

%wordList should come from the function call
%wordList = {'Walk', 'Lean Back', 'Left Hand', 'Right Hand', 'Left Foot', 'Right Foot', 'Think'}; 

%If the word 'Think' is in the word list, activate mathmode
mathmodeactive = false;
for q = 1:length(wordList)
    mathtime = strcmp('Think',wordList(q));
    if mathtime == 1
        mathmodeactive = true;
        mathword = q; %determines which column of the wordlist corresponds to 'Think'
    end
end

%Set Text Size
Screen('Preference', 'DefaultFontSize', 150); %Font Size

% Make the matrix which will determine our condition combinations

condMatrixBase = sort(repmat(1:max(length(wordList)), 1,trialsPerCondition )); % original = condMatrixBase = sort(repmat(1:length(wordList), 1, max(length(wordList))));

% Get the size of the matrix
[~, numTrials] = size(condMatrixBase);

%generate the timing values
Rready = ready_time-(jitter/2):(jitter/(numTrials-1)):ready_time+(jitter/2);
Rcue = cue_time-(jitter/2):(jitter/(numTrials-1)):cue_time+(jitter/2);
Rbreak = break_time-(jitter/2):(jitter/(numTrials-1)):break_time+(jitter/2);

%----------------------------------------------------------------------
%                     Make a response matrix and name the folder
%----------------------------------------------------------------------

respMat = zeros(numTrials,6); %6 rows so I can display the ready time in the response matrix. The 6th row is for the session start time

%name the session
%subnumber = 1; sessionnumber = 1; %these are set as defaults. On in the
%script, off in the function
session_name = strcat('prompttiming_', imaginedoractive,'_sub',subname,'_session',num2str(sessionnumber)); %you may want to plant this in the TMSI code
%dir_name = 'D:\UOMHESC_1748801\Collected_Data\'; %this effectively functions as the path to where things are going to be saved


%check that the directory name has a slash on the end. If it doesn't, stick
%it on there.


%% This section is now redundant, timing data is being saved to the running folder and will be moved by a post-session script
% if ~strcmp(dir_name(end), '\')
%     dir_name = strcat(dir_name,'\');
% end
% %ensure that there is a subject folder to save the results to. If there
% %isn't, create a subject folder
% folder_name = strcat('subject',subname); %generate a string representing the folder name
% if ~exist(strcat(dir_name,folder_name), 'dir') %check for no existing folder
%     mkdir(fullfile(dir_name, folder_name)); %if one doesn't exist already, generate the folder
% end

%----------------------------------------------------------------------
%                       Experimental loop
%----------------------------------------------------------------------

% Animation loop: we loop for the total number of trials

respMatSession = []; %the response matrix for the session starts empty
while 1 == 1
%create a bunch of shuffles
shuffler = Shuffle(1:numTrials);
shuffler2 = Shuffle(1:numTrials);
shuffler3 = Shuffle(1:numTrials);
shuffler4 = Shuffle(1:numTrials);

condMatrixShuffled = condMatrixBase(:, shuffler);    
trial = 1;
%Create a bell curve of durations with equal dimensions to the condition
%matrix

%apply the other 3 shuffles to the jitter effect
Rready = Rready(:, shuffler2); 
Rcue = Rcue(:, shuffler3); 
Rbreak = Rbreak(:, shuffler4); 

q = 1; %reset the math counter
%if mathmode is active, generate a matrix of random numbers
if mathmodeactive == true
    randMat = randi(9,[trialsPerCondition, 2]);
end

    while trial <= numTrials

        % Word and color number
        wordNum = condMatrixShuffled(1, trial);

        % The color word and the color it is drawn in
        theWord = wordList(wordNum);

        % If this is the first trial we present a start screen and wait for a
        % key-press
        if trial == 1
            Screen('TextSize', window, 80);
            DrawFormattedText(window, strcat(Instruction,'\n\n Press F8 To Begin'),...
                'center', 'center', black);
            Screen('Flip', window);
            KbF8 = KbName('f8');
            KbEscape = KbName('escape');
            while 1 == 1
                [~,~,keyCode] = KbCheck;
                if keyCode(KbF8) > 0
                    tBlockStart = GetSecs; %take the time that the block started at
                    break
                elseif keyCode(KbEscape) > 0
                    sca
                    break
                end
                pause(0.01)
            end
            
            % create a one off fixation cross that gives us time for the
            % signals to settle
            Screen('DrawLines', window, allCoords,...
                lineWidthPix, black, [xCenter yCenter], 2);
            Screen('Flip', window);
            pause(5)
        end

        % Draw the ready and take a time marker

        DrawFormattedText(window, 'Ready?','center', 'center', black);
        [~, readyappear] = Screen('Flip', window);
        pause(Rready(trial))

        if mathmodeactive == true
            if wordNum == mathword
                DrawFormattedText(window, 'Calculate', 'center', 'center', black); %draw the word from the word matrix
                [~, cueappear] = Screen('Flip', window);
                pause(Rcue(trial)) %hold for standard distribution of the stimulus time  
                
                DrawFormattedText(window, strcat(num2str(randMat(q,1)),'+',num2str(randMat(q,2)),'='), 'center', 'center', black); %draw the word from the word matrix
                [~, goappear] = Screen('Flip', window);
                pause(go_time)
                q = q+1;
                godisappear = GetSecs;
            else
                DrawFormattedText(window, char(theWord), 'center', 'center', black); %draw the word from the word matrix
                [~, cueappear] = Screen('Flip', window);
                pause(Rcue(trial)) %hold for standard distribution of the stimulus time
                
                DrawFormattedText(window, 'Go', 'center', 'center', black); %draw the word from the word matrix
                [~, goappear] = Screen('Flip', window);
                pause(go_time)
                godisappear = GetSecs;
            end
        else
                DrawFormattedText(window, char(theWord), 'center', 'center', black); %draw the word from the word matrix
                [~, cueappear] = Screen('Flip', window);
                pause(Rcue(trial)) %hold for standard distribution of the stimulus time
                
                DrawFormattedText(window, 'Go', 'center', 'center', black); %draw the word from the word matrix
                [~, goappear] = Screen('Flip', window);
                pause(go_time)
                godisappear = GetSecs;
        end
        
        Screen('DrawLines', window, allCoords,...
            lineWidthPix, black, [xCenter yCenter], 2);
        Screen('Flip', window);
        pause(Rbreak(trial))
       

        %fill the response matrix
        respMat(trial, 1) = wordNum;
        respMat(trial, 2) = readyappear;
        respMat(trial, 3) = cueappear;
        respMat(trial, 4) = goappear;
        respMat(trial, 5) = godisappear;


        [keyIsDown,secs,keyCode] = KbCheck; %If a key is pressed during the disappearance of the stimulus, kill the screen
        KbEscape = KbName('escape'); %this will kill the prompting window
        KbF9 = KbName ('f9'); %this will just end the block prematurely
        
        if keyCode(KbEscape) > 0
            sca
            break
        elseif keyCode(KbF9) > 0
            break
        end

        trial = trial + 1;
    end

respMat(1,6) = tBlockStart; %place the block start time in the top right corner of the resp matrix

% End of round screen. 
Screen('TextSize', window, 80);
DrawFormattedText(window, 'Round Finished \n\n Press F9 to Start the next round',...
    'center', 'center', black);
[~, endsessiontime] = Screen('Flip', window);

%name the last block. If this block number already exists look for however
%many duplicates exist and stick a dupenumber on the end. the dupenumber
%corresponds to however many blocks there might be. It's essentially a
%failsafe to ensure I don't overwrite
block_name = strcat(session_name,'_block1'); %name it block1 by default.
block_name_dir = strcat(block_name,'.txt');
if exist(block_name_dir, 'file') %if block1 exists, 
    namesearch = strcat(session_name,'_block','*'); %use wildcard to get the number that we should be at
    dupenumber = length(dir(namesearch))+1; %effectively increment for the next block number
    block_name = strcat(session_name,'_block',num2str(dupenumber));
else
    dupenumber = 1;
end

respMat(2,6) = dupenumber; %place a number indicating which session this block corresponds to
respMat(3,6) = endsessiontime;

%write to dlm and collate data. Take each block as a just in case. dlm
%rather than csv as we need more significant figures
dlmwrite(strcat(block_name,'.txt'),respMat,'precision',15);

%this section causes the program to make the windows system noise every 4
%seconds or so until the F9 key is pressed
KbF9 = KbName('f9'); p =401;
[~,~,keyCode] = KbCheck;
while ~keyCode(KbF9) > 0
[~,~,keyCode] = KbCheck;
pause(0.01)
p = p +1;
if p > 400
beep
p = 1;
end
end


end

sca;

end