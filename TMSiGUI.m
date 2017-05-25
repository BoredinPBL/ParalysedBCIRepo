function varargout = TMSiGUI(varargin)
% TMSIGUI MATLAB code for TMSiGUI.fig
%      TMSIGUI, by itself, creates a new TMSIGUI or raises the existing
%      singleton*.
%
%      H = TMSIGUI returns the handle to a new TMSIGUI or the handle to
%      the existing singleton*.
%
%      TMSIGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TMSIGUI.M with the given input arguments.
%
%      TMSIGUI('Property','Value',...) creates a new TMSIGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TMSiGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TMSiGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TMSiGUI

% Last Modified by GUIDE v2.5 06-Jan-2017 18:06:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @TMSiGUI_OpeningFcn, ...
    'gui_OutputFcn',  @TMSiGUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

 %live = 0;
 %F = parfeval(gcp(),@prompterlive,live,3,3);

% --- Executes just before TMSiGUI is made visible.
function TMSiGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TMSiGUI (see VARARGIN)
global channelArray;
global capLocations;
global channelList;
global chanPopupHandles;
global numChannels;
global filtType;
global subnumber;
global sessionnumber;

numChannels = 32;
filtType = 'BPF';
addpath('C:\Users\shielst\ParalysedSubjectProject\tmsiMatlabInterface-clone\eeglab13_6_5b');
eeglab;
close;
channelList = {'Ch1', 'Ch2', 'Ch3', 'Ch4', 'Ch5', 'Ch6', 'Ch7', 'Ch8', 'Ch9', 'Ch10',...
    'Ch11', 'Ch12', 'Ch13', 'Ch14', 'Ch15', 'Ch16', 'Ch17', 'Ch18', 'Ch19', 'Ch20', 'Ch21', 'Ch22',...
    'Ch23', 'Ch24'};

capLocations = [get(handles.popupmenu2, 'Value'), get(handles.popupmenu3, 'Value'),...
    get(handles.popupmenu6, 'Value'), get(handles.popupmenu7, 'Value'),...
    get(handles.popupmenu8, 'Value'), get(handles.popupmenu9, 'Value'),...
    get(handles.popupmenu10, 'Value'), get(handles.popupmenu11, 'Value'),...
    get(handles.popupmenu12, 'Value'), get(handles.popupmenu13, 'Value'),...
    get(handles.popupmenu14, 'Value'), get(handles.popupmenu15, 'Value'),...
    get(handles.popupmenu52, 'Value'), get(handles.popupmenu53, 'Value'),...
    get(handles.popupmenu54, 'Value'), get(handles.popupmenu55, 'Value'),...
    get(handles.popupmenu56, 'Value'), get(handles.popupmenu57, 'Value'),...
    get(handles.popupmenu58, 'Value'), get(handles.popupmenu59, 'Value'),...
    get(handles.popupmenu60, 'Value'), get(handles.popupmenu61, 'Value'),...
    get(handles.popupmenu62, 'Value'), get(handles.popupmenu63, 'Value')];

chanPopupHandles = [handles.popupmenu2, handles.popupmenu3, handles.popupmenu6, handles.popupmenu7,...
    handles.popupmenu8, handles.popupmenu9, handles.popupmenu10, handles.popupmenu11,...
    handles.popupmenu12, handles.popupmenu13, handles.popupmenu14, handles.popupmenu15,...
    handles.popupmenu52, handles.popupmenu53, handles.popupmenu54, handles.popupmenu55,...
    handles.popupmenu56, handles.popupmenu57, handles.popupmenu58, handles.popupmenu59,...
    handles.popupmenu60, handles.popupmenu61, handles.popupmenu62, handles.popupmenu63];
% Choose default command line output for TMSiGUI

set(chanPopupHandles,'String',{'Idle', 'FPz', 'F3', 'Fz', 'F4', 'FC5',...
    'FC1', 'FC2', 'FC6', 'T7', 'C3', 'C4', 'Cz', 'T8', 'CP5', 'CP1',...
    'CP2', 'CP6', 'P7', 'P3', 'Pz', 'P4', 'P8', 'PO7', 'PO3', 'POz',...
    'PO4', 'PO8', 'O1', 'Oz', 'O2'});
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.checkbox1,'Value',1)
set(handles.checkbox2,'Value',1)
set(handles.checkbox3,'Value',1)
set(handles.checkbox4,'Value',1)
set(handles.checkbox5,'Value',1)
set(handles.checkbox6,'Value',1)
set(handles.checkbox7,'Value',1)
set(handles.checkbox8,'Value',1)
set(handles.checkbox9,'Value',1)
set(handles.checkbox10,'Value',1)
set(handles.checkbox11,'Value',1)
set(handles.checkbox12,'Value',1)
set(handles.checkbox13,'Value',1)
set(handles.checkbox14,'Value',1)
set(handles.checkbox15,'Value',1)
set(handles.checkbox16,'Value',1)
set(handles.checkbox17,'Value',1)
set(handles.checkbox18,'Value',1)
set(handles.checkbox19,'Value',1)
set(handles.checkbox20,'Value',1)
set(handles.checkbox21,'Value',1)
set(handles.checkbox22,'Value',1)
set(handles.checkbox23,'Value',1)
set(handles.checkbox24,'Value',1)
set(handles.checkbox50,'Value',1)
set(handles.checkbox51,'Value',1)
set(handles.checkbox52,'Value',1)
set(handles.checkbox53,'Value',1)
set(handles.checkbox54,'Value',1)
set(handles.checkbox55,'Value',1)
set(handles.checkbox56,'Value',1)
set(handles.checkbox57,'Value',1)
set(handles.radiobutton4,'Value',1)
set(handles.radiobutton5,'Value',0)
set(handles.edit1,'Enable','off')
set(handles.edit2,'Enable','off')
set(handles.popupmenu1,'Enable','off')

set(handles.radiobutton8, 'value', 1);
set(handles.radiobutton9, 'value', 0);
set(handles.radiobutton10, 'value', 0);
channelArray = 1:32;
% UIWAIT makes TMSiGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

clust = parcluster('local');
subnumber = 1; sessionnumber = 1; stimulus_time = 4;
wordList = {'Walk', 'Lean Back', 'Left Hand', 'Right Hand', 'Left Foot', 'Right Foot', 'Think'}; 
j = batch(clust, @prompter1function, 1, {subnumber,sessionnumber,stimulus_time,wordList}, 'Pool', 1);



% --- Outputs from this function are returned to the command line.
function varargout = TMSiGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure


varargout{1} = handles.output;


% --- Executes on button press in checkbox23.
function checkbox23_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox23
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 23];
else
    channelArray = channelArray(channelArray~=23);
end
channelArray = sort(channelArray);



% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    
    channelArray = [channelArray 1];
else
    channelArray = channelArray(channelArray~=1);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 2];
    disp(channelArray);
else
    channelArray = channelArray(channelArray~=2);
end
channelArray = sort(channelArray);



% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 3];
else
    channelArray = channelArray(channelArray~=3);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 4];
else
    channelArray = channelArray(channelArray~=4);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox12
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 12];
else
    channelArray = channelArray(channelArray~=12);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 11];
else
    channelArray = channelArray(channelArray~=11);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 10];
else
    channelArray = channelArray(channelArray~=10);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 9];
else
    channelArray = channelArray(channelArray~=9);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 8];
else
    channelArray = channelArray(channelArray~=8);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 7];
else
    channelArray = channelArray(channelArray~=7);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 5];
else
    channelArray = channelArray(channelArray~=5);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 6];
else
    channelArray = channelArray(channelArray~=6);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox13.
function checkbox13_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox13
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 13];
else
    channelArray = channelArray(channelArray~=13);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox14.
function checkbox14_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox14
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 14];
else
    channelArray = channelArray(channelArray~=14);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox15.
function checkbox15_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox15
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 15];
else
    channelArray = channelArray(channelArray~=15);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox16.
function checkbox16_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox16
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 16];
else
    channelArray = channelArray(channelArray~=16);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox24.
function checkbox24_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox24
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 24];
else
    channelArray = channelArray(channelArray~=24);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox22.
function checkbox22_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox22
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 22];
else
    channelArray = channelArray(channelArray~=22);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox21.
function checkbox21_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox21
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 21];
else
    channelArray = channelArray(channelArray~=21);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox20.
function checkbox20_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox20
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 20];
else
    channelArray = channelArray(channelArray~=20);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox19.
function checkbox19_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox19
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 19];
else
    channelArray = channelArray(channelArray~=19);
end
channelArray = sort(channelArray);
% --- Executes on button press in checkbox17.
function checkbox17_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox17
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 17];
else
    channelArray = channelArray(channelArray~=17);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox18.
function checkbox18_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox18
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 18];
    %     disp(channelArray);
else
    channelArray = channelArray(channelArray~=18);
end
channelArray = sort(channelArray);

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global filtType;
filtType = [];

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
    case 'HPF' % User selects peaks.
        filtType = 'HPF';
        set(handles.edit1,'Enable','on')
        set(handles.edit2,'Enable','off')
    case 'LPF' % User selects membrane.
        filtType = 'LPF';
        set(handles.edit1,'Enable','on')
        set(handles.edit2,'Enable','off')
    case 'BPF' % User selects sinc.
        filtType = 'BPF';
        set(handles.edit1,'Enable','on')
        set(handles.edit2,'Enable','on')
    case 'BSF' % User selects sinc.
        filtType = 'BSF';
        set(handles.edit1,'Enable','on')
        set(handles.edit2,'Enable','on')
    case 'Notch Filter' % User selects sinc.
        filtType = 'Notch';
        set(handles.edit1,'Enable','on')
        set(handles.edit2,'Enable','off')
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.


% Save the handles structure.
guidata(hObject,handles)


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global channelArray;
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filtType;
global numChannels;
global indexArray;
if get(handles.radiobutton4, 'Value')
    showChannelSubset(channelArray, numChannels, indexArray);
else
    if get(handles.radiobutton5, 'Value')
        lowerCutoff=get(handles.edit1,'String');
        upperCutoff=get(handles.edit2,'String');
        if isempty(str2num(lowerCutoff))
            set(handles.edit1,'string','');
            warndlg('Input must be numerical', 'Error');
        else
            if isempty(str2num(upperCutoff)) && (strcmp(filtType, 'BPF') || strcmp(filtType, 'BSF'))
                set(handles.edit2,'string','');
                warndlg('Input must be numerical', 'Error');
            elseif (str2num(upperCutoff) < str2num(lowerCutoff)) && (strcmp(filtType, 'BPF') || strcmp(filtType, 'BSF'))
                warndlg('Upper Cutoff Frequency should be geater than Lower Cutoff Frequency', 'Error');
            else
                filteredChannels(channelArray, filtType, str2num(lowerCutoff), str2num(upperCutoff), numChannels, indexArray);
            end
        end
    end
end


% --- Executes on button press in checkbox50.
function checkbox50_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox50
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 28];
else
    channelArray = channelArray(channelArray~=28);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox51.
function checkbox51_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox51
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 27];
else
    channelArray = channelArray(channelArray~=27);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox52.
function checkbox52_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox52
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 26];
else
    channelArray = channelArray(channelArray~=26);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox53.
function checkbox53_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox53

global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 25];
else
    channelArray = channelArray(channelArray~=25);
end
channelArray = sort(channelArray);


% --- Executes on button press in checkbox54.
function checkbox54_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox54
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 32];
else
    channelArray = channelArray(channelArray~=32);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox55.
function checkbox55_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox55
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 31];
else
    channelArray = channelArray(channelArray~=31);
end
channelArray = sort(channelArray);

% --- Executes on button press in checkbox56.
function checkbox56_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox56
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 30];
else
    channelArray = channelArray(channelArray~=30);
end
channelArray = sort(channelArray);


% --- Executes on button press in checkbox57.
function checkbox57_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox57
global channelArray;
if get(hObject,'Value') == get(hObject,'Max')
    channelArray = [channelArray 29];
else
    channelArray = channelArray(channelArray~=29);
end
channelArray = sort(channelArray);


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
if get(hObject,'Value') == get(hObject,'Max')
    set(handles.edit1,'Enable','off')
    set(handles.edit2,'Enable','off')
    set(handles.popupmenu1,'Enable','off')
    set(handles.radiobutton5, 'Value', 0)
else
    set(handles.radiobutton4,'Value',1)
end

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5

if get(hObject,'Value') == get(hObject,'Max')
    set(handles.edit1,'Enable','on')
    set(handles.edit2,'Enable','on')
    set(handles.popupmenu1,'Enable','on')
    set(handles.radiobutton4, 'Value', 0)
else
    set(handles.radiobutton5,'Value',1)
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
global capLocations;
loc = 1;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
global capLocations;
loc = 2;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6
global capLocations;
loc = 3;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7
global capLocations;
loc = 4;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8
global capLocations;
loc = 5;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu9.
function popupmenu9_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu9
global capLocations;
loc = 6;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu10.
function popupmenu10_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu10
global capLocations;
loc = 7;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu11.
function popupmenu11_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu11
global capLocations;
loc = 8;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu12.
function popupmenu12_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu12
global capLocations;
loc = 9;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu13.
function popupmenu13_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu13 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu13
global capLocations;
loc = 10;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu14.
function popupmenu14_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu14
global capLocations;
loc = 11;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu15.
function popupmenu15_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu15 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu15
global capLocations;
loc = 12;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu52.
function popupmenu52_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu52 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu52
global capLocations;
loc = 13;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu52_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu53.
function popupmenu53_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu53 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu53
global capLocations;
loc = 14;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu53_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu54.
function popupmenu54_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu54 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu54
global capLocations;
loc = 15;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu54_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu55.
function popupmenu55_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu55 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu55
global capLocations;
loc = 16;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu55_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu56.
function popupmenu56_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu56 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu56
global capLocations;
loc = 17;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu56_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu57.
function popupmenu57_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu57 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu57
global capLocations;
loc = 18;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu57_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu58.
function popupmenu58_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu58 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu58
global capLocations;
loc = 19;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu58_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu59.
function popupmenu59_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu59 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu59
global capLocations;
loc = 20;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu59_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu60.
function popupmenu60_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu60 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu60
global capLocations;
loc = 21;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu60_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu61.
function popupmenu61_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu61 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu61
global capLocations;
loc = 22;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu61_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu62.
function popupmenu62_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu62 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu62
global capLocations;
loc = 23;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu62_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu63.
function popupmenu63_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu63 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu63
global capLocations;
loc = 24;
capLocations(loc) = get(hObject,'Value');
if get(hObject, 'Value') ~= 1
    if ismember(get(hObject, 'Value'), capLocations)
        index = find(capLocations == get(hObject, 'Value'));
        if length(index) > 1
            index = index(index ~= loc);
            waitfor(errordlg(sprintf(('This electrode is already assigned to Channel %d'), index),'Error'))
            set(hObject,'Value', 1);
            capLocations(loc) = get(hObject,'Value');
        end
    end
end

% --- Executes during object creation, after setting all properties.
function popupmenu63_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global numChannels;
global chanPopupHandles;
% Hint: get(hObject,'Value') returns toggle state of radiobutton8
if get(hObject,'Value') == get(hObject,'Max')
    set(handles.radiobutton9, 'Value', 0)
    set(handles.radiobutton10, 'Value', 0)
    numChannels = 32;
    
    set(chanPopupHandles,'String',{'Idle', 'FPz', 'F3', 'Fz', 'F4', 'FC5',...
    'FC1', 'FC2', 'FC6', 'T7', 'C3', 'C4', 'Cz', 'T8', 'CP5', 'CP1',...
    'CP2', 'CP6', 'P7', 'P3', 'Pz', 'P4', 'P8', 'PO7', 'PO3', 'POz',...
    'PO4', 'PO8', 'O1', 'Oz', 'O2'});
else
    set(handles.radiobutton8,'Value',1)
    numChannels = 32;
    
    set(chanPopupHandles,'String',{'Idle', 'FPz', 'F3', 'Fz', 'F4', 'FC5',...
    'FC1', 'FC2', 'FC6', 'T7', 'C3', 'C4', 'Cz', 'T8', 'CP5', 'CP1',...
    'CP2', 'CP6', 'P7', 'P3', 'Pz', 'P4', 'P8', 'PO7', 'PO3', 'POz',...
    'PO4', 'PO8', 'O1', 'Oz', 'O2'});
end



% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton10
global numChannels;
global chanPopupHandles;
if get(hObject,'Value') == get(hObject,'Max')
    set(handles.radiobutton9, 'Value', 0)
    set(handles.radiobutton8, 'Value', 0)
    numChannels = 128;
    
    set(chanPopupHandles,'String',{'Idle', 'FP1', 'FP2', 'FP3', 'F7A',...
        'F3A', 'FP1P', 'FP2P', 'F4A', 'F8A', 'F5A', 'F1A', 'F2A', 'F6A',...
        'F7', 'F5', 'F3', 'F1', 'FZ', 'F2', 'F4', 'F6', 'F8', 'TF5A',...
        'F5A1', 'F3A1', 'F1A1', 'F2A1', 'F4A1', 'F6A1', 'TF6A', 'T1',...
        'T3A', 'F5P', 'F3P', 'F1P', 'FPZ', 'F2P', 'F4P', 'F6P', 'T4A',...
        'T2', 'C7A', 'C5A', 'C3A', 'C1A', 'C2A', 'C4A', 'C6A', 'C8A',...
        'T3L', 'T3', 'C5', 'C3', 'C1', 'C2', 'C4','C6', 'T4', 'T4L',...
        'C7P', 'C5P', 'C3P', 'C1P', 'C2P', 'C4P', 'C6P', 'C8P', 'T5AL',...
        'T5A', 'P5A', 'P3A', 'P1A', 'PZA', 'P2A', 'P4A', 'P6A', 'T6A',...
        'T6AL', 'TP5A', 'P53A', 'P31A', 'PZ1A', 'PZ2A', 'P24A', 'P46A',...
        'PT6A', 'T5L', 'T5', 'P5', 'P3', 'P1', 'PZ', 'P2','P4', 'P6',...
        'T6', 'T6L', 'P5P', 'P1P', 'P2P', 'P6P', 'T7L1', 'T7', 'P3P',...
        'PZP', 'P4P', 'T8', 'T8L1', 'T7L', 'O1', 'OZ', 'O2', 'T8L',...
        'OZ1P', 'OZ2P', 'O1P', 'OZP', 'O2P', 'O1A', 'O2A'});
else
    set(handles.radiobutton10,'Value',1)
    numChannels = 128;
    
    set(chanPopupHandles,'String',{'Idle', 'FP1', 'FP2', 'FP3', 'F7A',...
        'F3A', 'FP1P', 'FP2P', 'F4A', 'F8A', 'F5A', 'F1A', 'F2A', 'F6A',...
        'F7', 'F5', 'F3', 'F1', 'FZ', 'F2', 'F4', 'F6', 'F8', 'TF5A',...
        'F5A1', 'F3A1', 'F1A1', 'F2A1', 'F4A1', 'F6A1', 'TF6A', 'T1',...
        'T3A', 'F5P', 'F3P', 'F1P', 'FPZ', 'F2P', 'F4P', 'F6P', 'T4A',...
        'T2', 'C7A', 'C5A', 'C3A', 'C1A', 'C2A', 'C4A', 'C6A', 'C8A',...
        'T3L', 'T3', 'C5', 'C3', 'C1', 'C2', 'C4','C6', 'T4', 'T4L',...
        'C7P', 'C5P', 'C3P', 'C1P', 'C2P', 'C4P', 'C6P', 'C8P', 'T5AL',...
        'T5A', 'P5A', 'P3A', 'P1A', 'PZA', 'P2A', 'P4A', 'P6A', 'T6A',...
        'T6AL', 'TP5A', 'P53A', 'P31A', 'PZ1A', 'PZ2A', 'P24A', 'P46A',...
        'PT6A', 'T5L', 'T5', 'P5', 'P3', 'P1', 'PZ', 'P2','P4', 'P6',...
        'T6', 'T6L', 'P5P', 'P1P', 'P2P', 'P6P', 'T7L1', 'T7', 'P3P',...
        'PZP', 'P4P', 'T8', 'T8L1', 'T7L', 'O1', 'OZ', 'O2', 'T8L',...
        'OZ1P', 'OZ2P', 'O1P', 'OZP', 'O2P', 'O1A', 'O2A'});
end


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9
global numChannels;
global chanPopupHandles;
if get(hObject,'Value') == get(hObject,'Max')
    set(handles.radiobutton8, 'Value', 0)
    set(handles.radiobutton10, 'Value', 0)
    numChannels = 64;
    
    set(chanPopupHandles,'String',{'Idle', 'FP1', 'FPz', 'FP2', 'AF7', 'AF3', 'AFz',...
        'AF4', 'AF8', 'F7', 'F5', 'F3', 'F1', 'Fz', 'F2', 'F4', 'F6', 'F8', 'FT7', 'FC5',...
        'FC3', 'FC1', 'FCz', 'FC2', 'FC4', 'FC6', 'FT8',...
        'T7/T3', 'C5', 'C3', 'C1', 'Cz', 'C2', 'C4', 'C6', 'T8/T4', 'TP7', 'CP5', 'CP3', 'CP1', 'CPz',...
        'CP2', 'CP4', 'CP6', 'TP8', 'P7/T5', 'P5', 'P3', 'P1', 'Pz', 'P2', 'P4', 'P6', 'P8/T6',...
        'PO7', 'PO5', 'PO3', 'POz', 'PO4', 'PO6', 'PO8', 'O1', 'Oz', 'O2'});
else
    set(handles.radiobutton9,'Value',1)
    numChannels = 64;
    
    set(chanPopupHandles,'String',{'Idle', 'FP1', 'FPz', 'FP2', 'AF7', 'AF3', 'AFz',...
        'AF4', 'AF8', 'F7', 'F5', 'F3', 'F1', 'Fz', 'F2', 'F4', 'F6', 'F8', 'FT7', 'FC5',...
        'FC3', 'FC1', 'FCz', 'FC2', 'FC4', 'FC6', 'FT8',...
        'T7/T3', 'C5', 'C3', 'C1', 'Cz', 'C2', 'C4', 'C6', 'T8/T4', 'TP7', 'CP5', 'CP3', 'CP1', 'CPz',...
        'CP2', 'CP4', 'CP6', 'TP8', 'P7/T5', 'P5', 'P3', 'P1', 'Pz', 'P2', 'P4', 'P6', 'P8/T6',...
        'PO7', 'PO5', 'PO3', 'POz', 'PO4', 'PO6', 'PO8', 'O1', 'Oz', 'O2'});
end



% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global capLocations;
global channelList;
global numChannels;
strChannelList = char(channelList);

x = inputdlg('Save Configuration As (.txt)',...
    'File Name', [1 50]);
if isempty(x)
    
else if strcmp(x{1}, '')
        errordlg('Invalid Name','File Error');
    else
        y = strcat(x{1}, '.txt');
        if exist(y, 'file')
            choice = questdlg('File name already exists! Would you like to replace the existing file?', 'Yes', 'No');
            % Handle response
            switch choice
                case 'Yes'
                    fileName = y;
                    file = fopen(fileName,'w');
                    fprintf(file, '%d\r\n', numChannels);
                    formatSpec = '%s %d\r\n';
                    for i = 1:24
                        fprintf(file, formatSpec, strChannelList(i,:), capLocations(i));
                    end
                    fclose(file);
                    msgbox('Configuration Saved', 'Success')
                    
                case 'No'
                    
            end
        else
            fileName = y;
            file = fopen(fileName,'w');
            fprintf(file, '%d\r\n', numChannels);
            formatSpec = '%s %d\r\n';
            for i = 1:24
                fprintf(file, formatSpec, strChannelList(i,:), capLocations(i));
            end
            fclose(file);
            msgbox('Configuration Saved', 'Success')
        end
        
    end
end



% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global capLocations;
global numChannels;
global chanPopupHandles;
readFileName = uigetfile('*.txt','Select the Text file');
fileID = fopen(readFileName, 'r');
tline = fgetl(fileID);
numChannels = str2double(tline);
numChannel = 1;
while ischar(tline) && numChannel <= 24
    tline = fgetl(fileID);
    splitString = strsplit(tline);
    numChannel = numChannel + 1;
    capLocations(numChannel) = str2double(splitString{2});
end
capLocations = capLocations(2:25);
if numChannels == 32
    set(handles.radiobutton9, 'Value', 0);
    set(handles.radiobutton10, 'Value', 0);
    set(handles.radiobutton8, 'Value', 1)
    set(chanPopupHandles,'String',{'Idle', 'FPz', 'F3', 'Fz', 'F4', 'FC5',...
    'FC1', 'FC2', 'FC6', 'T7', 'C3', 'C4', 'Cz', 'T8', 'CP5', 'CP1',...
    'CP2', 'CP6', 'P7', 'P3', 'Pz', 'P4', 'P8', 'PO7', 'PO3', 'POz',...
    'PO4', 'PO8', 'O1', 'Oz', 'O2'});
    
    set(chanPopupHandles, 'Enable', 'on');
    
    for i = 1:24
        set(chanPopupHandles(i), 'Value', capLocations(i));
    end
    
elseif numChannels == 64
    set(handles.radiobutton9, 'Value', 1);
    set(handles.radiobutton10, 'Value', 0);
    set(handles.radiobutton8, 'Value', 0)
    set(chanPopupHandles,'String',{'Idle', 'FP1', 'FPz', 'FP2', 'AF7', 'AF3', 'AFz',...
        'AF4', 'AF8', 'F7', 'F5', 'F3', 'F1', 'Fz', 'F2', 'F4', 'F6', 'F8', 'FT7', 'FC5',...
        'FC3', 'FC1', 'FCz', 'FC2', 'FC4', 'FC6', 'FT8',...
        'T7/T3', 'C5', 'C3', 'C1', 'Cz', 'C2', 'C4', 'C6', 'T8/T4', 'TP7', 'CP5', 'CP3', 'CPz', 'CP1'...
        'CP2', 'CP4', 'CP6', 'TP8', 'P7/T5', 'P5', 'P3', 'P1', 'Pz', 'P2', 'P4', 'P6', 'P8/T6',...
        'PO7', 'PO3', 'POz', 'PO4', 'PO8', 'O1', 'Oz', 'O2'});
    set(chanPopupHandles, 'Enable', 'on');
    
    for i = 1:24
        set(chanPopupHandles(i), 'Value', capLocations(i));
    end
elseif numChannels == 128
    set(handles.radiobutton9, 'Value', 0);
    set(handles.radiobutton10, 'Value', 1);
    set(handles.radiobutton8, 'Value', 0)
    set(chanPopupHandles,'String',{'Idle', 'FP1', 'FP2', 'FP3', 'F7A',...
        'F3A', 'FP1P', 'FP2P', 'F4A', 'F8A', 'F5A', 'F1A', 'F2A', 'F6A',...
        'F7', 'F5', 'F3', 'F1', 'FZ', 'F2', 'F4', 'F6', 'F8', 'TF5A',...
        'F5A1', 'F3A1', 'F1A1', 'F2A1', 'F4A1', 'F6A1', 'TF6A', 'T1',...
        'T3A', 'F5P', 'F3P', 'F1P', 'FPZ', 'F2P', 'F4P', 'F6P', 'T4A',...
        'T2', 'C7A', 'C5A', 'C3A', 'C1A', 'C2A', 'C4A', 'C6A', 'C8A',...
        'T3L', 'T3', 'C5', 'C3', 'C1', 'C2', 'C4','C6', 'T4', 'T4L',...
        'C7P', 'C5P', 'C3P', 'C1P', 'C2P', 'C4P', 'C6P', 'C8P', 'T5AL',...
        'T5A', 'P5A', 'P3A', 'P1A', 'PZA', 'P2A', 'P4A', 'P6A', 'T6A',...
        'T6AL', 'TP5A', 'P53A', 'P31A', 'PZ1A', 'PZ2A', 'P24A', 'P46A',...
        'PT6A', 'T5L', 'T5', 'P5', 'P3', 'P1', 'PZ', 'P2','P4', 'P6',...
        'T6', 'T6L', 'P5P', 'P1P', 'P2P', 'P6P', 'T7L1', 'T7', 'P3P',...
        'PZP', 'P4P', 'T8', 'T8L1', 'T7L', 'O1', 'OZ', 'O2', 'T8L',...
        'OZ1P', 'OZ2P', 'O1P', 'OZP', 'O2P', 'O1A', 'O2A'});
    set(chanPopupHandles, 'Enable', 'on');
    for i = 1:24
        set(chanPopupHandles(i), 'Value', capLocations(i));
    end
end
fclose(fileID);


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global numChannels;
global capLocations;
global indexArray;
if numChannels == 32
    fileID = fopen('chan32.locs', 'r');
    tempfid = fopen('temp32.loc', 'w');
    formatSpec = '%s\r\n';
    tline = fgetl(fileID);
    count = 1;
    countVec = 1;
    indexArray = [];
    while ischar(tline) && count <= 30
        tline = fgetl(fileID);
        stringsplt = strsplit(tline);
        if ismember((str2double(stringsplt(1)) + 1), capLocations)
            index = find(capLocations == (str2double(stringsplt(1)) + 1));
            indexArray = [indexArray index];
            fprintf(tempfid, formatSpec, tline);
            countVec = countVec + 1;
        end
        count = count + 1;
    end
    fclose(fileID);
    fclose(tempfid);
    
    
elseif numChannels == 64
    fileID = fopen('chan64.loc', 'r');
    tempfid = fopen('temp64.loc', 'w');
    formatSpec = '%s\r\n';
    tline = fgetl(fileID);
    count = 1;
    countVec = 1;
    indexArray = [];
    while ischar(tline) && count <= 60
        tline = fgetl(fileID);
        stringsplt = strsplit(tline);
        if ismember((str2double(stringsplt(1)) + 1), capLocations)
            index = find(capLocations == (str2double(stringsplt(1)) + 1));
            indexArray = [indexArray index];
            fprintf(tempfid, formatSpec, tline);
            countVec = countVec + 1;
        end
        count = count + 1;
    end
    fclose(fileID);
    fclose(tempfid);
end
