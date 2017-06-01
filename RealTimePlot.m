classdef RealTimePlot < TMSi.HiddenHandle
    
    %REALTIMEPLOT Provides a very basic visualization of the data that can be sampled from a device.
    %
    %   Closing of the plot can be done with the key 'q' or through closing the figure. Scaling of the
    %   individual channels can be done with the key 'a'. Scaling will scale the channels to min-max.
    %   Set a fixed range can be done with the key 'r'. A dialog will show
    %   where you can enter the +/- uV range.
    %
    %REALTIMEPLOT Properties:
    %   is_visible - If plot is ready to be used (i.e. appended to).
    %   window_size - The time period of the plot.
    %   channels - A list of numbers representing the channels that are to be displayed.
    %   channel_list - Array of channels to be displayed
    %   name - Name of this GUI.
    %   sample_rate - The sample rate of the sampled data.
    %   figure - The figure handle used.
    %
    %REALTIMEPLOT Methods:
    %   RealTimePlot - Constructor for the RealTimePlot class.
    %   setWindowSize - Set the size of the x-axis in seconds.
    %   append - Add samples to the RealTimePlot.
    %   show - Show the figure in which the data is going to be displayed.
    %   hide - Destroy the current figure object associated with this object.
    %   draw - Updates the current figure with the newly appended data.
    %   recState - State variable to determine the start of recording
    %   resetRecState - Reset state variable after saving a file 
    %   saveRecAs - Poly5 object creation for saving file
    %   sendFileCount - State variable which sends the file name when triggered
    %   sendFName - Sends file name as an output argument, when creating
    %               the poly5 file
    %   startRec - Start saving recording (State variable is changed during execution)
    %   stopRec - Stop recording data
    %   plotState - Sends the details of the plot (Chan num and FFT/PSD) as an output argument
    %   figureHandle - Sends figure handle for FFT/PSD as an output argument
    %   dispTopo - Callback function for 'Display Topoplot' keypress
    %   sendState - State variable which decides displaying the plot
    %   resetState - Reset the state variable associated with topoplot, after closing the plot
    %
    %REALTIMEPLOT Example:
    %   sampler = device.createSampler();
    %   realTimePlot = TMSi.RealTimePlot('Example', sampler.sample_rate, sampler.device.channels);
    %   realTimePlot.show();
    %
    %   sampler.connect();
    %   sampler.start();
    %   while realTimePlot.is_visible
    %       samples = sampler.sample();
    %       realTimePlot.append(samples);
    %   end
    %   sampler.stop();
    %   sampler.disconnect();
    
    properties (SetAccess = public)
        % If GUI is visible, not stopped.
        is_visible
        
        % The time period of the plot.
        window_size
        
        % A list of numbers representing the channels that are to be displayed.
        channels
        
        channel_list
        
        % Name of this GUI.
        name
        
        % The sample rate of the sampled data.
        sample_rate
        
        % The figure handle used.
        figure
        
    end
    
    properties(Access = private)
        % A internal buffer used to store the samples required for displaying.
        window_buffer
        
        % Number of samples seen so far in the GUI.
        samples_seen
        
        % The factor with which the shown data is downsampled.
        downsample_factor
        
        % List of axes for each chanel
        axes_list
        
        % List of plots for each channel
        plot_list
        
        % The plot handle used.
        plot
        
        % The axes handle used.
        axes_left
        
        % The axes handle used.
        axes_right
    end
    
    methods
        function obj = RealTimePlot(name, sample_rate, channels, channel_list)
            %REALTIMEPLOT - Constructor for the RealTimePlot class.
            %
            %   Constructor for the RealTimePlot class, will use the sampler object to sample
            %   from.
            global rec;
            global count;
            global plotfftWelch;
            global topoplotState;
            topoplotState = 0;
            
            plotfftWelch = [0, 0];
            count = 1;
            rec = 0;
            obj.name = name;
            obj.sample_rate = sample_rate;
            obj.channels = channels;
            obj.channel_list = channel_list;
            obj.is_visible = false;
            obj.window_size = 5;
            obj.window_buffer = [];
            obj.samples_seen = 0;
            obj.downsample_factor = obj.downSamplingFactor(4096, 4096);
            
            obj.window_buffer = nan(numel(obj.channels), ceil(obj.window_size * obj.sample_rate));
            
        end
        
        function show(obj)
            %SHOW - Show the figure in which the data is going to be displayed.
            global startRecBtn;
            global stopRecBtn;
            global saveBtn;
            global FFT;
            global welchPSD;
            global tpBtn;
            global promptBtn;
            if obj.is_visible
                return;
            end
            
            save obj.channels
            % ==================================================================
            %   FIGURE
            % ==================================================================
            obj.figure = figure('Name', obj.name, 'Position', [200, 80, 1600, 870]);
            
            
           %---------------------Special Functions buttons-----------------
            autoScaleBtn = uicontrol('Style', 'pushbutton', 'String', 'Auto-Scale',...
                'Position', [200 20 100 40],'fontunits','normalized','fontsize',0.3,...
                'Callback', @obj.autoScale);
            rangeBtn = uicontrol('Style', 'pushbutton', 'String', 'Range',...
                'Position', [400 20 100 40],'fontunits','normalized','fontsize',0.3,...
                'Callback', @obj.range);
            closeBtn = uicontrol('Style', 'pushbutton', 'String', 'Close',...
                'Position', [600 20 100 40],'fontunits','normalized','fontsize',0.3,...
                'Callback', @obj.closeRequestEvent);
            saveBtn = uicontrol('Style', 'pushbutton', 'String', 'Save Recording As',...
                'Position', [40 750 110 40],'fontunits','normalized','fontsize',0.3,...
                'Callback', @obj.saveRecAs);
            startRecBtn = uicontrol('Style', 'pushbutton', 'String', 'Start Recording',...
                'Position', [40 700 110 40],'fontunits','normalized','fontsize',0.3,...
                'Callback', @obj.startRec);
            stopRecBtn = uicontrol('Style', 'pushbutton', 'String', 'Stop Recording',...
                'Position', [40 650 110 40],'fontunits','normalized','fontsize',0.3,...
                'Callback', @obj.stopRec);
            promptBtn = uicontrol('Style', 'pushbutton', 'String', 'Start Prompt',...
                'Position', [40 800 110 40],'fontunits','normalized','fontsize',0.3,...
                'Callback', @obj.startPrompt);
            welchPSD = uicontrol('Style', 'radiobutton', 'String', 'Welch PSD',...
                'Position', [40 550 100 30],'fontunits','normalized','fontsize',0.5,...
                'Callback', @obj.welchON);
            FFT = uicontrol('Style', 'radiobutton', 'String', 'FFT',...
                'Position', [40 580 100 30],'fontunits','normalized','fontsize',0.5,...
                'Callback', @obj.fftON);
            
            tpBtn = uicontrol('Style', 'pushbutton', 'String', 'Display Topoplot',...
                'Position', [1200 20 120 40],'fontunits','normalized','fontsize',0.3,...
                'Callback', @obj.dispTopo);
            
            %----------------Buttons for displaying FFT--------------------
            fftCh1 = uicontrol('Style', 'pushbutton', 'String', 'Ch1',...
                'Position', [40 510 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT1);
            fftCh2 = uicontrol('Style', 'pushbutton', 'String', 'Ch2',...
                'Position', [40 480 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT2);
            fftCh3 = uicontrol('Style', 'pushbutton', 'String', 'Ch3',...
                'Position', [40 450 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT3);
            fftCh4 = uicontrol('Style', 'pushbutton', 'String', 'Ch4',...
                'Position', [40 420 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT4);
            fftCh5 = uicontrol('Style', 'pushbutton', 'String', 'Ch5',...
                'Position', [40 390 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT5);
            fftCh6 = uicontrol('Style', 'pushbutton', 'String', 'Ch6',...
                'Position', [40 360 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT6);
            fftCh7 = uicontrol('Style', 'pushbutton', 'String', 'Ch7',...
                'Position', [40 330 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT7);
            fftCh8 = uicontrol('Style', 'pushbutton', 'String', 'Ch8',...
                'Position', [40 300 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT8);
            fftCh9 = uicontrol('Style', 'pushbutton', 'String', 'Ch9',...
                'Position', [40 270 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT9);
            fftCh10 = uicontrol('Style', 'pushbutton', 'String', 'Ch10',...
                'Position', [40 240 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT10);
            fftCh11 = uicontrol('Style', 'pushbutton', 'String', 'Ch11',...
                'Position', [40 210 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT11);
            fftCh12 = uicontrol('Style', 'pushbutton', 'String', 'Ch12',...
                'Position', [40 180 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT12);
            
            Bip1 = uicontrol('Style', 'pushbutton', 'String', 'Bip1',...
                'Position', [40 140 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT25);
            Bip2 = uicontrol('Style', 'pushbutton', 'String', 'Bip2',...
                'Position', [40 110 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT26);
            Bip3 = uicontrol('Style', 'pushbutton', 'String', 'Bip3',...
                'Position', [40 80 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT27);
            Bip4 = uicontrol('Style', 'pushbutton', 'String', 'Bip4',...
                'Position', [40 50 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT28);
            
            fftCh13 = uicontrol('Style', 'pushbutton', 'String', 'Ch13',...
                'Position', [80 510 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT13);
            fftCh14 = uicontrol('Style', 'pushbutton', 'String', 'Ch14',...
                'Position', [80 480 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT14);
            fftCh15 = uicontrol('Style', 'pushbutton', 'String', 'Ch15',...
                'Position', [80 450 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT15);
            fftCh16 = uicontrol('Style', 'pushbutton', 'String', 'Ch16',...
                'Position', [80 420 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT16);
            fftCh17 = uicontrol('Style', 'pushbutton', 'String', 'Ch17',...
                'Position', [80 390 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT17);
            fftCh18 = uicontrol('Style', 'pushbutton', 'String', 'Ch18',...
                'Position', [80 360 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT18);
            fftCh19 = uicontrol('Style', 'pushbutton', 'String', 'Ch19',...
                'Position', [80 330 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT19);
            fftCh20 = uicontrol('Style', 'pushbutton', 'String', 'Ch20',...
                'Position', [80 300 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT20);
            fftCh21 = uicontrol('Style', 'pushbutton', 'String', 'Ch21',...
                'Position', [80 270 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT21);
            fftCh22 = uicontrol('Style', 'pushbutton', 'String', 'Ch22',...
                'Position', [80 240 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT22);
            fftCh23 = uicontrol('Style', 'pushbutton', 'String', 'Ch23',...
                'Position', [80 210 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT23);
            fftCh24 = uicontrol('Style', 'pushbutton', 'String', 'Ch24',...
                'Position', [80 180 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT24);
            
            Aux1 = uicontrol('Style', 'pushbutton', 'String', 'Aux1',...
                'Position', [80 140 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT29);
            Aux2 = uicontrol('Style', 'pushbutton', 'String', 'Aux2',...
                'Position', [80 110 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT30);
            Aux3 = uicontrol('Style', 'pushbutton', 'String', 'Aux3',...
                'Position', [80 80 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT31);
            Aux4 = uicontrol('Style', 'pushbutton', 'String', 'Aux4',...
                'Position', [80 50 40 30],'fontunits','normalized','fontsize',0.4,...
                'Callback', @obj.dispFFT32);
            
            fftButtonArray = [fftCh1 fftCh2 fftCh3 fftCh4 fftCh5 fftCh6 fftCh7 fftCh8 fftCh9 fftCh10 fftCh11 fftCh12...
                fftCh13 fftCh14 fftCh15 fftCh16 fftCh17 fftCh18 fftCh19 fftCh20 fftCh21 fftCh22 fftCh23 fftCh24 Bip1...
                Bip2 Bip3 Bip4 Aux1 Aux2 Aux3 Aux4];
            
            set(fftButtonArray, 'Enable', 'off');
            set(FFT, 'Value', 1);
            set(welchPSD, 'Value', 0);
            
            for i = 1:length(obj.channel_list)
                set(fftButtonArray(obj.channel_list(i)), 'Enable', 'on');
            end

            set(stopRecBtn,'Enable','off');
            set(startRecBtn,'Enable','off');
            set(obj.figure, 'CloseRequestFcn', @obj.closeRequestEvent);
            set(obj.figure, 'KeyPressFcn', @obj.keyPressEvent);
            set(obj.figure, 'ResizeFcn', @obj.resizeEvent);
            
            % ==================================================================
            %   AXES LEFT
            % ==================================================================
            position = [0, 0, 1, 1];
            obj.axes_left = axes('OuterPosition', position);
            
            set(obj.axes_left, 'XLim', [0 obj.window_size]);
            set(obj.axes_left, 'YLim', [0 size(obj.window_buffer, 1) * 2]);
            set(obj.axes_left, 'YTick', 1:2:size(obj.window_buffer, 1)*2);
            
            set(obj.axes_left, 'Box', 'on');
            set(obj.axes_left, 'XGrid', 'on');
            set(obj.axes_left, 'YGrid', 'on');
            %set(obj.axes_left, 'XMinorGrid', 'on');
            %set(obj.axes_left, 'YMinorGrid', 'on');
            
            YTick = {};
            for i=1:size(obj.window_buffer, 1)
                YTick{size(obj.window_buffer, 1) - i + 1} = obj.channels{i}.name;
            end
            
            set(obj.axes_left, 'YTickLabel', YTick);
            
            xlabel('Time (s)');
            ylabel('Channels');
            
            % ==================================================================
            %   AXES RIGHT
            % ==================================================================
            obj.axes_right = axes('Position', get(obj.axes_left, 'Position'));
            set(obj.axes_right, 'XLim', [0 obj.window_size]);
            set(obj.axes_right, 'YLim', [0 size(obj.window_buffer, 1) * 4]);
            set(obj.axes_right, 'YTick', 0:size(obj.window_buffer, 1) * 4);
            set(obj.axes_right, 'Color', 'none');
            set(obj.axes_right, 'XTick', []);
            set(obj.axes_right, 'YAxisLocation', 'right');
            
            % ==================================================================
            %   CHANNELS
            % ==================================================================
            obj.axes_list = [];
            obj.plot_list = [];
            YTick_right = {};
            for i=1:size(obj.window_buffer, 1)
                obj.axes_list(i) = axes('Position', get(obj.axes_left, 'Position'));
                obj.plot_list(i) = plot(1:10);
                set(obj.axes_list(i), 'XTick', []);
                set(obj.axes_list(i), 'YTick', []);
                set(obj.axes_list(i), 'Color', 'none');
                
                value_d = 2^31;
                value_mean = 0;
                
                set(obj.axes_list(i), 'XLim', [0 obj.window_size]);
                set(obj.axes_list(i), 'YLim', [value_mean - ((size(obj.window_buffer, 1) - i + 1) - 0.5) * value_d, value_mean + (size(obj.window_buffer, 1) - (size(obj.window_buffer, 1) - i + 1) + 0.5) * value_d]);
                
                YTick_right{size(obj.window_buffer, 1) * 4 - ((i - 1) * 4 + 1) + 2} = '';
                YTick_right{size(obj.window_buffer, 1) * 4 - ((i - 1) * 4 + 2) + 2} = sprintf('%0.2e', value_mean + value_d);
                YTick_right{size(obj.window_buffer, 1) * 4 - ((i - 1) * 4 + 3) + 2} = sprintf([obj.channels{i}.unit_name]);
                YTick_right{size(obj.window_buffer, 1) * 4 - (i * 4) + 2} = sprintf('%0.5e', value_mean - value_d);
            end
            set(obj.axes_right, 'YTickLabel', YTick_right, 'FontSize',7);
            
            position = get(obj.figure, 'Position');
            obj.downsample_factor = obj.downSamplingFactor(position(3), position(4));
            
            obj.is_visible = true;
        end
        
        function hide(obj)
            %HIDE - Destroy the current figure object associated with this object.
            
            %             if ~obj.is_visible
            %                 return;
            %             end
            
            delete(obj.figure);
            
            obj.figure = 0;
            obj.axes_left = 0;
            obj.axes_list = [];
            obj.plot_list = [];
            
            obj.is_visible = false;
        end
        
        function append(obj, samples)
            %APPEND - Add samples to the RealTimePlot.
            %
            %   Give samples to the RealTimePlot. Make sure that samples contains only the channels you specified
            %   at creation of this object.
            if size(samples, 2) > 0
                if size(samples, 1) > numel(obj.channels)
                    throw(MException('RealTimePlot:append', 'Too many channels.'));
                end
                
                white_out = floor(obj.window_size * obj.sample_rate * 0.05);
                indices = mod(obj.samples_seen + (1:size(samples, 2) + white_out) - 1, size(obj.window_buffer, 2)) + 1;
                obj.window_buffer(:, indices(1:end-white_out)) = samples;
                obj.window_buffer(:, indices(end-white_out + 1:end)) = NaN;
            end
            
            obj.samples_seen = obj.samples_seen + size(samples, 2);
        end
        
        function draw(obj)
            %DRAW - Updates the current figure with the newly appended data.
            
            if ~obj.is_visible
                obj.show();
            end
            
            y_data_raw = obj.window_buffer(:, 1:obj.downsample_factor:end);
            x_axes = (1:size(y_data_raw, 2)) * (1 / size(y_data_raw, 2) * obj.window_size);
            
            for i=1:numel(obj.channels)
                set(obj.plot_list(i), 'XData', x_axes, 'YData', y_data_raw(i, :));
            end
            
            
            drawnow;
        end
        
        function setWindowSize(obj, seconds)
            %SETWINDOWSIZE - Set the size of the x-axis in seconds.
            %
            %   By default the windows size is set to 5 seconds.
            %
            %   seconds - The size of x-axis in seconds.
            
            obj.window_size = seconds;
            obj.window_buffer = nan(numel(obj.channels), ceil(obj.window_size * obj.sample_rate));
        end
        
        function startPrompt(~,~,~)
            global dir_name;
            global subname;
            global sessionnumber;
            global imaginedoractive;
            global promptBtn;
            global clust;
            set(promptBtn,'Enable','off');
            j = batch(clust, @prompter, 0, {subname,sessionnumber,imaginedoractive,dir_name}, 'Pool', 1);
            pause(20); %I put this here and it started working. I don't know why, but now I'm too scared to take it away
        end
        
        
        
        %-------------------Start Recording Samples Trigger------------------------
        function startRec(~,~,~)
            global rec;
            global startRecBtn;
            global stopRecBtn;
            global saveBtn;
            rec = 1;
            set(startRecBtn,'Enable','off');
            set(stopRecBtn,'Enable','on');
            set(saveBtn,'Enable','off');
        end
        
        %-------------Send Parametric Value of the state of Recording------
        % rec = 0    No recording
        % rec = 1    Initialized recording
        % rec = 2    Finished Recording
        function y = recState(~,~,~)
            global rec;
            y = rec;
        end
        
        %------------Reset Recording State after saving file---------------
        function resetRecState(state,~,~)
            global rec;
            global saveBtn;
            rec = state;
            
            set(saveBtn,'Enable','on');
        end
        
        %--------------------------Stop recording--------------------------
        function stopRec(~,~,~) %function has been changed to trigger a resave
            global rec;
            global startRecBtn;
            global stopRecBtn;
            global saveBtn;
            rec = 2;
            set(startRecBtn,'Enable','off');
            set(stopRecBtn,'Enable','off');
            set(saveBtn,'Enable','off');
            saveRecAs
        end
        
        %---------File operations related to saving the recording----------
        function saveRecAs(~,~,~)
            global fileName;
            global count;
            global startRecBtn;
            global saveBtn;
            global subname;
            global sessionnumber;
            global imaginedoractive;
            
            x = strcat('EEGsigs',imaginedoractive,'_subject',subname,'_session',num2str(sessionnumber));
            
            block_name = strcat(x,'_block1'); %name it block1 by default.
            block_name_dir = strcat(pwd,'\',block_name,'.Poly5');
            fprintf('%s', block_name_dir);

            if exist(block_name_dir, 'file') %if block1 exists,
                namesearch = strcat(pwd,'\',x,'_block','*'); %use wildcard to get the number that we should be at
                dupenumber = length(dir(namesearch))+1; %effectively increment for the next block number
                x = strcat(x,'_block',num2str(dupenumber));
            else
                x = block_name;
            end
            
            y = strcat(x, '.Poly5');
            fileName = y;
            count = 0;
            set(startRecBtn,'Enable','on');
            set(saveBtn,'Enable','off');
            
        end
        
        %--------Intermediate function used for passing the filename-------
        function countFile = sendFileCount(~,~,~)
            global count;
            countFile = count;
            count = 1;
        end
        
        %-------------Function to pass the name of the file----------------
        function fName = sendFName(~,~,~)
            global fileName;
            fName = fileName;
        end
        
        %------Pass the channel number and type of plot for plotting-------
        function sendPlot = plotState(~,~,~)
            global plotfftWelch;
            sendPlot = plotfftWelch;
        end
        
        %-----------Pass figure handle of the FFT/Welch PSD plot-----------
        function figHandle = figureHandle(~,~,~)
            global fig;
            figHandle = fig;
        end
        
        %-------------Pass figure handle of the topoplot figure------------
        function topHandle = topoplotHandle(~,~,~)
            global topofig;
            topHandle = topofig;
        end
        
        %----------------Functions for keypresses of FFT plot--------------
        function dispFFT1(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [1, 1];
            else
                plotfftWelch = [1, 2];  
            end
        end
        
        function dispFFT2(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [2, 1];
            else
                plotfftWelch = [2, 2];  
            end
        end
        
        function dispFFT3(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [3, 1];
            else
                plotfftWelch = [3, 2];  
            end
        end
        
        function dispFFT4(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [4, 1];
            else
                plotfftWelch = [4, 2];  
            end
        end
        
        function dispFFT5(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [5, 1];
            else
                plotfftWelch = [5, 2];  
            end
        end
        
        function dispFFT6(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [6, 1];
            else
                plotfftWelch = [6, 2];  
            end
        end
        
        function dispFFT7(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [7, 1];
            else
                plotfftWelch = [7, 2];  
            end
        end
        
        function dispFFT8(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [8, 1];
            else
                plotfftWelch = [8, 2];  
            end
        end
        
        function dispFFT9(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [9, 1];
            else
                plotfftWelch = [9, 2];  
            end
        end
        
        function dispFFT10(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [10, 1];
            else
                plotfftWelch = [10, 2];  
            end
        end
        
        function dispFFT11(obj,~,~)
           global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [11, 1];
            else
                plotfftWelch = [11, 2];  
            end
        end
        
        function dispFFT12(obj,~,~)
           global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [12, 1];
            else
                plotfftWelch = [12, 2];  
            end
        end
        
        function dispFFT13(obj,~,~)
           global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [13, 1];
            else
                plotfftWelch = [13, 2];  
            end
        end
        
        function dispFFT14(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [14, 1];
            else
                plotfftWelch = [14, 2];  
            end
        end
        
        function dispFFT15(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [15, 1];
            else
                plotfftWelch = [15, 2];  
            end
        end
        
        function dispFFT16(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [16, 1];
            else
                plotfftWelch = [16, 2];  
            end
        end
        
        function dispFFT17(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [17, 1];
            else
                plotfftWelch = [17, 2];  
            end
        end
        
        function dispFFT18(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [18, 1];
            else
                plotfftWelch = [18, 2];  
            end
        end
        
        function dispFFT19(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [19, 1];
            else
                plotfftWelch = [19, 2];  
            end
        end
        
        function dispFFT20(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [20, 1];
            else
                plotfftWelch = [20, 2];
            end
        end
        
        function dispFFT21(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [21, 1];
            else
                plotfftWelch = [21, 2];
            end
        end
        
        function dispFFT22(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [22, 1];
            else
                plotfftWelch = [22, 2];  
            end
        end
        
        function dispFFT23(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [23, 1];
            else
                plotfftWelch = [23, 2];  
            end
        end
        
        function dispFFT24(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [24, 1];
            else
                plotfftWelch = [24, 2];  
            end
        end
        
        function dispFFT25(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [25, 1];
            else
                plotfftWelch = [25, 2];  
            end
        end
        function dispFFT26(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [26, 1];
            else
                plotfftWelch = [26, 2];  
            end
        end
        
        function dispFFT27(obj,~,~)
           global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [27, 1];
            else
                plotfftWelch = [27, 2];  
            end
        end
        
        function dispFFT28(obj,~,~)
           global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [28, 1];
            else
                plotfftWelch = [28, 2];  
            end
        end
        
        function dispFFT29(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [29, 1];
            else
                plotfftWelch = [29, 2];  
            end
        end 
        
          function dispFFT30(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [30, 1];
            else
                plotfftWelch = [30, 2];  
            end
          end
        
        function dispFFT31(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [31, 1];
            else
                plotfftWelch = [31, 2];  
            end
        end
        
        function dispFFT32(obj,~,~)
            global FFT;
            global plotfftWelch;
            global fig;
            fig = figure;
            if get(FFT,'Value') == get(FFT,'Max')
                plotfftWelch = [32, 1];
            else
                plotfftWelch = [32, 2];  
            end
        end
        
        %----------------Radio button selection of Welch PSD---------------
        function welchON(~,~,~)
            global FFT;
            global welchPSD;
            if get(welchPSD,'Value') == get(welchPSD,'Max')
                set(FFT, 'Value', 0)
            else
                set(welchPSD,'Value',1);
            end
        end
        
        %-----------------Radio button selection of FFT plot---------------
        function fftON(~,~,~)
            global FFT;
            global welchPSD;
            if get(FFT,'Value') == get(FFT,'Max')
                set(welchPSD, 'Value', 0)
            else
                set(FFT,'Value',1);
            end
        end
        
        %--------------Keypress function of Disply Topoplot----------------
        function dispTopo(~,~,~)
            global topofig;
            global topoplotState;
            topoplotState = 1;
            topofig = figure;
        end
        
        %-----Pass parametric value for triggering of topoplot display-----
        function state = sendState(~,~,~)
            global topoplotState;
            state = topoplotState;
        end
        
        %-------------Reset state after closing the topoplot---------------
        function resetState(state,~,~)
            global topoplotState
            topoplotState = state;
        end
        
    end
    methods(Access = private)
        function autoScale(obj,~,~)
            %KEYRELEASEEVENT - A callback function used to identify the quit event.
            %
            %   Currently, only key 'q' is acceppted and is used to close the
            %   plotting properly.
            
            
            YTick_right = get(obj.axes_right, 'YTickLabel');
            
            for i=1:size(obj.window_buffer, 1)
                value_min = min(obj.window_buffer(i, :));
                value_max = max(obj.window_buffer(i, :));
                value_d = value_max - value_min;
                value_mean = (value_min + value_max) / 2;
                
                % Cannot have a limit from 0 to 0.
                if value_d == 0 || isnan(value_d)
                    value_d = 2^31;
                end
                
                if isnan(value_mean)
                    value_mean = 0;
                end
                
                value_d = value_d * 1.05;
                
                set(obj.axes_list(i), 'YLim', [value_mean - ((size(obj.window_buffer, 1) - i + 1) - 0.5) * value_d, value_mean + (size(obj.window_buffer, 1) - (size(obj.window_buffer, 1) - i + 1) + 0.5) * value_d]);
                YTick_right{size(obj.window_buffer, 1) * 4 - ((i - 1) * 4 + 2) + 2} = sprintf('%0.5e', value_mean + value_d / 4);
                YTick_right{size(obj.window_buffer, 1) * 4 - i * 4 + 2} = sprintf('%0.5e', value_mean - value_d / 4);
            end
            set(obj.axes_right, 'YTickLabel', YTick_right);
        end
        
        function range(obj,~,~)
            
            r = inputdlg('Enter desired signal range [uV]:',...
                'Amplitude Range', [1 50]);
            range = str2num(r{:});
            
            YTick_right = get(obj.axes_right, 'YTickLabel');
            
            for i=1:size(obj.window_buffer, 1)
                
                value_d = range;
                
                value_min = range/2 *-1;
                value_max = range/2;
                value_mean = 0;
                
                %                     value_mean = (value_min + value_max) / 2;
                
                % Cannot have a limit from 0 to 0.
                if value_d == 0 || isnan(value_d)
                    value_d = 2^31;
                end
                
                if isnan(value_mean)
                    value_mean = 0;
                end
                
                %                     value_d = value_d * 1.05;
                
                set(obj.axes_list(i), 'YLim', [value_mean - ((size(obj.window_buffer, 1) - i + 1) - 0.5) * value_d, value_mean + (size(obj.window_buffer, 1) - (size(obj.window_buffer, 1) - i + 1) + 0.5) * value_d]);
                YTick_right{size(obj.window_buffer, 1) * 4 - ((i - 1) * 4 + 2) + 2} = sprintf('%+.2f', value_mean + value_d);
                YTick_right{size(obj.window_buffer, 1) * 4 - i * 4 + 2} = sprintf('%+.2f', value_mean - value_d);
            end
            set(obj.axes_right, 'YTickLabel', YTick_right);
        end
        
        function closeRequestEvent(obj, ~, ~)
            %KEYRELEASEEVENT - A callback function used to identify the quit event.
            %
            %   Currently, only key 'q' is acceppted and is used to close the
            %   plotting properly.
            
            obj.hide();
        end
        
        
        function resizeEvent(obj, src, ~)
            %RESIZEEVENT - A callback that changes the downsample factor when resizing.
            %
            %   The downsample factor causes the data points to be reduced to 2 samples
            %   per pixel on the screen.
            
            position = get(src, 'Position');
            obj.downsample_factor = obj.downSamplingFactor(position(3), position(4));
            
            set(obj.axes_right, 'Position', get(obj.axes_left, 'Position'));
            
            for i=1:numel(obj.axes_list)
                set(obj.axes_list, 'Position', get(obj.axes_left, 'Position'));
            end
        end
        
        function keyPressEvent(obj, src, ~)
            global rec;
            global startRecBtn;
            global stopRecBtn;
            global saveBtn;
            KbName('UnifyKeyNames') %initalise the psychtoolbox keyboard listener
            [~,~,keyCode] = KbCheck;

            KbF8 = KbName('f8');
            KbF9 = KbName('f9');
            if keyCode(KbF8) > 0
                rec = 1;
                set(startRecBtn,'Enable','off');
                set(stopRecBtn,'Enable','on');
                set(saveBtn,'Enable','off');
            elseif keyCode(KbF9) > 0 && rec == 1
               rec = 2;
               set(startRecBtn,'Enable','off');
               set(stopRecBtn,'Enable','off');
               set(saveBtn,'Enable','off');
            end

           
        end        

        function downsample = downSamplingFactor(obj, width, height)
            %DOWNSAMPLINGFACTOR - A dynamic factor that should range somewhere between 15 and 1.
            
            downsample = ceil(obj.window_size * obj.sample_rate / (width * 4));
        end
    end
end