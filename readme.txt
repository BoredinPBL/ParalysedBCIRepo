Repo created by Thomas Shiels as part of building a BCI for paralysed individuals.
Presently this repo contains functions that pertain to prompting and simultaneous EEG recording

Installation:
	1. Collect the dependancies
		1. Download psychtoolbox
		2. Download the TMSi Matlab toolbox
		3. Have a version of Matlab
	2. Replace the default TMSiGUI.m with my version
	3. In tmsiMatlabInterface/+TMSI there is a m file called RealTimePlot.m. Replace this file with my version
	4. Copy the prompter1function into the same folder as the TMSiGUI.m

What are the files:

TMSiGUI.m is a modified version of the TMSIi GUI m file. The principle difference is that it contains a batch function
prompter1function.m is a function that is called by the batch function in the TMSiGUI. 
RealTimePlot.m is the file which plots the TMSi EEG signals in realtime. I have modified it so that it doesn't prompt for a name when 
you press the save as button. The name is automatically generated based on the subject number and session number. These variables exist in the TMSiGUI.m file

Ignore the other files, they're old

How to use:

1. Change the subject variable in the TMSiGUI.m file to that of the subject number
2. Change the session variable in the TMSiGUI.m file to that of the session number
3. If you are restarting mid-session. Change the block number to the block you are up to
4. Run the TMSiGUI
5. Set the GUI then click the submit button - this will not work without being connected to the TMSI drivers and device
6. Click save as- you shouldn't be prompted for a name
7. Click start recording - the window will freeze
8. Ensure your subject is ready to go
9. Press F8, this will start the recording and the prompting, ideally keeping them in sync

When you run the TMSiGUI, the prompter1function will run. It will open up a psychtoolbox screen and await instruction. While open this window
can no longer be accessed via the Matlab command line. To control the prompting function there are 3 keyboard commands that are listened for
Esc is listened for as the prompt is disappearing. This closes the screen
F12 is listened for as the prompt is disappearing. This ends the block and takes you to the end of session screen
F8 is listened for on the first screen. You must press F8 to start each round.