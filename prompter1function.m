function trigger = prompter1function(subnumber,sessionnumber,stimulus_time,wordList,imaginedoractive)

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
%subnumber = the subject number, this defines the folder where the timing
%information wil be saved
%sessionnumber = the session number with this subject
%startblock = in the case of having to open and close the program multiple
%times, you can define what number block you are starting with. This should
%prevent it from saving over old version
%stimulustime = the median stimulus time, there is a standard deviation in
%the display time
%wordList = the list of words, needs to be a matrix of strings. If one
%corresponds to 'Think', the program will display a random maths question
%instead of the word 'Think'

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

%If the word 'Think' is in the word list, activate mathmode
mathmodeactive = false;
for q = 1:length(wordList)
    mathtime = strcmp('Think',wordList(q));
    if mathtime == 1
        mathmodeactive = true;
        mathword = q;
    end
end

if strcmp(imaginedoractive,'imagined')
    Instruction = 'Imagine the Movement';
elseif strcmp(imaginedoractive,'active')
    Instruction = 'Follow the Instruction';
else
    fprintf('you need to set the imagined or active field, defaulting to imagined');
    Instruction = 'Imagine the Movement';
end
    
    

%Set Text Size
Screen('Preference', 'DefaultFontSize', 150); %Font Size

% Make the matrix which will determine our condition combinations
trialsPerCondition = 6;  % 6 trials per class gives a total of 42 trials per block. Adjust to 7 if you drop a trial type
condMatrixBase = sort(repmat(1:max(length(wordList)), 1,trialsPerCondition )); % original = condMatrixBase = sort(repmat(1:length(wordList), 1, max(length(wordList))));

% Get the size of the matrix
[~, numTrials] = size(condMatrixBase);

%----------------------------------------------------------------------
%                     Make a response matrix and name the folder
%----------------------------------------------------------------------

respMat = zeros(numTrials,6); %6 rows so I can display the ready time in the response matrix. The 6th row is for the session start time

%name the session
%subnumber = 1; sessionnumber = 1; %these are set as defaults. On in the
%script, off in the function
session_name = strcat('prompttiming_', imaginedoractive,'_sub',num2str(subnumber),'_session',num2str(sessionnumber)); %you may want to plant this in the TMSI code
dir_name = 'D:\UOMHESC_1748801\Collected_Data\'; %this effectively functions as the path to where things are going to be saved


%ensure that there is a subject folder to save the results to. If there
%isn't, create a subject folder
folder_name = strcat('subject',num2str(subnumber)); %generate a string representing the folder name
if exist(strcat(dir_name,folder_name), 'dir') %check for an existing folder
    mkdir(fullfile(dir_name, (folder_name))); %if one doesn't exist already, generate the folder
end

%----------------------------------------------------------------------
%                       Experimental loop
%----------------------------------------------------------------------

% Animation loop: we loop for the total number of trials

respMatSession = []; %the response matrix for the session starts empty
while 1 == 1
shuffler = Shuffle(1:numTrials);
condMatrixShuffled = condMatrixBase(:, shuffler);    
trial = 1;
%Create a bell curve of durations with equal dimensions to the condition
%matrix
R = normrnd(stimulus_time,1,[1 numTrials]);
q = 1; %reset the math counter
%if mathmode is active, generate a matrix of random numbers
if mathmodeactive == true
    randMat = randi(9,[trialsPerCondition, 2]);
end

% %detect whether a poly5 file already exists, if so, move it
% name = strcat('EEGsigs','_subject',num2str(subnumber),'_session',num2str(sessionnumber),'.Poly5');                             
% if exist(name, 'file') 
%     nopoly5 = strcat('EEGsigs','_subject',num2str(subnumber),'_session',num2str(sessionnumber));
%     nopoly5 = strcat(nopoly5, '_block' ,num2str(blockcounter-1)); %this can potentially give a file a zero, if this is happening you have stuffed up somewhere.
%     newname = strcat(nopoly5, '.Poly5');
%     %this code should move the poly5 file produced by TMSI to the folder
%     %where the prompting code is stored and prevent me from saving over it
%     %:D
%     movefile(name, strcat(dir_name, fold_name, '\', newname)) %this line hasn't been validated in the lab but it should work
% end
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
            while 1 == 1
                [~,~,keyCode] = KbCheck;
                if keyCode(KbF8) > 0
                    break
                end
                pause(0.01)
            end
        end

        Screen('DrawDots', window, [xCenter; yCenter], 50, black, [], 2);
        Screen('Flip', window);
        pause(break_time)

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
        
        if mathmodeactive == true
            if wordNum == mathword
                DrawFormattedText(window, strcat('Calculate', '\n\n',num2str(randMat(q,1)),'+',num2str(randMat(q,2)),'='), 'center', 'center', black); %draw the word from the word matrix
                [~, timeappear] = Screen('Flip', window);
                pause(R(trial)) %hold for standard distribution of the stimulus time
                q = q+1;
                timedisappear = GetSecs;
            else
                DrawFormattedText(window, char(theWord), 'center', 'center', black); %draw the word from the word matrix
                [~, timeappear] = Screen('Flip', window);
                pause(R(trial)) %hold for standard distribution of the stimulus time
                timedisappear = GetSecs;
            end
        else
            DrawFormattedText(window, char(theWord), 'center', 'center', black); %draw the word from the word matrix
            [~, timeappear] = Screen('Flip', window);
            pause(R(trial)) %hold for standard distribution of the stimulus time
            timedisappear = GetSecs;
        end

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

respMat(1,6) = tBlockStart; %place the block start time in the top right corner of the resp matrix


% End of round screen. 
Screen('TextSize', window, 80);
DrawFormattedText(window, 'Round Finished \n\n Press Any Key To Start the next round',...
    'center', 'center', black);
Screen('Flip', window);

%name the last block. If this block number already exists look for however
%many duplicates exist and stick a dupenumber on the end. the dupenumber
%corresponds to however many blocks there might be. It's essentially a
%failsafe to ensure I don't overwrite
block_name = strcat(session_name,'_block1'); %name it block1 by default.
block_name_dir = strcat(dir_name,block_name)
if exist(block_name_dir, 'file') %if block1 exists, 
    namesearch = strcat(dir_name, folder_name, '\', session_name,'_block','*'); %use wildcard to get the number that we should be at
    dupenumber = length(dir(namesearch))+1; %effectively increment for the next block number
    block_name = strcat(session_name,'_block',num2str(dupenumber));
else
    dupenumber = 1;
end

respMat(2,6) = dupenumber; %place a number indicating which session this block corresponds to

%write to CSV and collate data. Take each block as a just in case
csvwrite(strcat(dir_name,folder_name,'\',block_name,'.csv'),respMat);
respMat(numTrials+1,:) = 10; % Implant a marker that the block has ended and that there is a break
%collect the data from the session so far. This is the data I will
%hopefully use
export_session_name = strcat(session_name, '_allblocks_v1');
export_session_name_dir = strcat(dir_name,export_session_name)
if exist(export_session_name_dir, 'file')
    namesearch2 = strcat(dir_name, folder_name, '\',session_name,'_allblocks','*');
    dupenumber2 = length(dir(namesearch2))+1;
    export_session_name = strcat(session_name, 'allblocks_v',num2str(dupenumber2))
end

respMatSession = [respMatSession; respMat]; %move the block into the overall session response matrix
csvwrite(strcat(dir_name,folder_name,'\',export_session_name,'.csv'),respMatSession);
KbStrokeWait; 

end
sca;

end