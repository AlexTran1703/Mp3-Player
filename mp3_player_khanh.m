function varargout = mp3_player_khanh(varargin)
%MP3_PLAYER_KHANH MATLAB code file for mp3_player_khanh.fig
%      MP3_PLAYER_KHANH, by itself, creates a new MP3_PLAYER_KHANH or raises the existing
%      singleton*.
%
%      H = MP3_PLAYER_KHANH returns the handle to a new MP3_PLAYER_KHANH or the handle to
%      the existing singleton*.
%
%      MP3_PLAYER_KHANH('Property','Value',...) creates a new MP3_PLAYER_KHANH using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to mp3_player_khanh_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MP3_PLAYER_KHANH('CALLBACK') and MP3_PLAYER_KHANH('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MP3_PLAYER_KHANH.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mp3_player_khanh

% Last Modified by GUIDE v2.5 28-Dec-2021 13:59:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mp3_player_khanh_OpeningFcn, ...
                   'gui_OutputFcn',  @mp3_player_khanh_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before mp3_player_khanh is made visible.
function mp3_player_khanh_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for mp3_player_khanh
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mp3_player_khanh wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.volume_slider,'value',1);
set(handles.speed_slider,'value',1);
handles.volume = get(handles.volume_slider,'value');
handles.speed = get(handles.speed_slider,'value');
set(handles.loop_button,'value',0);    
set(handles.random_button,'value',0);
set(handles.random_text,'string','Random : Off');
set(handles.loop_text,'string','Loop : Off');
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = mp3_player_khanh_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function time_adjust_Callback(hObject, eventdata, handles)
% hObject    handle to time_adjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global player m f time_slider
speed = 1;
volume = 1;

volume = get(handles.volume_slider,'value');
speed = get(handles.speed_slider,'value')
time_slider = get(handles.time_adjust,'value');
total_sample = get(player,'TotalSamples');
 adjust_sample = total_sample*time_slider;
time_sample = adjust_sample/f;
stop(player);
player = audioplayer(m*volume,f*speed);
play(player,player.samplerate*time_sample/speed);
set(handles.time_adjust,'value',time_slider);

% --- Executes during object creation, after setting all properties.
function time_adjust_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_adjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in resume.
function resume_Callback(hObject, eventdata, handles)
% hObject    handle to resume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player
play_status = get(handles.resume,'string');
switch play_status 
  case 'Resume'
    set(handles.resume,'string','Pause');
    resume(player);
   case 'Pause'
    set(handles.resume,'string','Resume');
    pause(player);
end

% --- Executes on slider movement.
function volume_slider_Callback(hObject, eventdata, handles)
% hObject    handle to volume_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global player m f time_rate
%get and set volume, get speed too
volume = get(handles.volume_slider,'value');
setappdata(0,'volume',volume);
speed = getappdata(0,'speed');

 stop(player);
player = audioplayer(volume*m,speed*f);
play(player,player.samplerate*time_rate/speed);


guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function volume_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volume_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function speed_slider_Callback(hObject, eventdata, handles)
% hObject    handle to speed_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global player m f time_rate
speed = get(handles.speed_slider,'value');

setappdata(0,'speed',speed);

volume = getappdata(0,'volume');

 stop(player);
player = audioplayer(volume*m,speed*f);
play(player,player.samplerate*time_rate/speed);


% --- Executes during object creation, after setting all properties.
function speed_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speed_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in default.
function default_Callback(hObject, eventdata, handles)
% hObject    handle to default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player m f time_rate
speed = getappdata(0,'speed');
set(handles.volume_slider,'value',1);
set(handles.speed_slider,'value',1);
setappdata(0,'volume',1);
setappdata(0,'speed',1);
stop(player);
player = audioplayer(m,f);
play(player,player.samplerate*time_rate);

guidata(hObject,handles);

% --- Executes on selection change in listbox.
function listbox_Callback(hObject, eventdata, handles)
% hObject    handle to listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox


% --- Executes during object creation, after setting all properties.
function listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in select.
function select_Callback(hObject, eventdata, handles)
% hObject    handle to select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,path,check] = uigetfile({'*.mp3'},'Select an audio file','MultiSelect','on');
%check if selected files is multi files or not
check_size = iscell(filename);
setappdata(0,'num_of_index',size(filename,2));
% Check if the user selected one file or multiple
if(check ~=0)
    %Reset selection to first entry
    set(handles.listbox, 'Value', 1);
    %Show selected file names in the listbox
    set(handles.listbox,'String', filename);
end
setappdata(0,'check_size',check_size);
setappdata(0,'path',path);

% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path = getappdata(0,'path');
check_size = getappdata(0,'check_size');
size_data = getappdata(0,'size_data');
index = get(handles.listbox,'value');
setappdata(0,'index',index);
music_data = get(handles.listbox,'string');
    if check_size == 0 && index == 1 %make sure if 1 song is selected, the mp3 player will work fine
        handles.path = strcat(path,music_data);
        set(handles.text,'string',['Playing ' music_data]);
       else
        handles.path = strcat(path,music_data{index});
        set(handles.text,'string',['Playing ' music_data{index}]);
    end
global player  m f time_rate
[m,f] = audioread(handles.path);
player = audioplayer(m,f); 
play(player);
set(handles.volume_slider,'value',1);
set(handles.speed_slider,'value',1);

t= get(player,'TotalSamples');
total_time = t/f; 
mins = total_time/60; mins = floor(mins);
secs = mod (total_time,60); 
secs = round(secs);
set(handles.time_duration,'String',[num2str(mins) ':' num2str(secs)]);
set(handles.duration,'String','Duration');

total_sample =get(player,'TotalSamples');
pause(0.01);
speed = getappdata(0,'speed');
num_of_index = getappdata(0,'num_of_index');
while total_sample ~=  get(player,'CurrentSample')
    current_sample = get(player,'CurrentSample');
    %Taking current_sample to determine time the music play
    time_slider = current_sample/total_sample;
    %time_slider = time the music play
    current_time = current_sample/f; 
    time_rate = round(current_time);
    %time_rate is used for volume,speed button
    %current mins and secs for display
    current_mins = current_time /60; 
    current_mins = floor(current_mins);
    current_secs = mod(current_time,60); 
    current_secs = round(current_secs);
    %set value for time_adjust slider
    set(handles.time_adjust,'Value',time_slider);
    %Display current time for the song
    set(handles.time_current,'String',[num2str(current_mins) ':' num2str(current_secs)]);
    %make sure the time display work fine
    if current_sample == 1 & ~isplaying(player) & ~get(handles.random_button,'value') & get(handles.loop_button,'value') 
        if num_of_index == index
        index = 1;
        setappdata(0,'speed',1);
        setappdata(0,'volume',1);
        set(handles.volume_slider,'value',1);
        set(handles.speed_slider,'value',1);
                handles.path = strcat(path,music_data{index});
        set(handles.text,'string',['Playing ' music_data{index}]);
        [m,f] = audioread(handles.path);
        player = audioplayer(m,f); 
        play(player);
        total_sample= get(player,'TotalSamples');
        total_time = total_sample/f; 
        mins = total_time/60; mins = floor(mins);
        secs = mod (total_time,60); 
        secs = round(secs);
        set(handles.time_duration,'String',[num2str(mins) ':' num2str(secs)]);
        set(handles.time_current,'String',[num2str(current_mins) ':' num2str(current_secs)]);
        setappdata(0,'current_sample',get(player,'CurrentSample'));   
         time_slider = current_sample/total_sample;
         set(handles.time_adjust,'Value',time_slider);
        else
        index = index + 1;
        setappdata(0,'speed',1);
        setappdata(0,'value',1);
        set(handles.volume_slider,'value',1);
        set(handles.speed_slider,'value',1);
                handles.path = strcat(path,music_data{index});
        set(handles.text,'string',['Playing ' music_data{index}]);
        [m,f] = audioread(handles.path);
        player = audioplayer(m,f); 
        play(player);
        total_sample= get(player,'TotalSamples');
        total_time = total_sample/f; 
        mins = total_time/60; mins = floor(mins);
        secs = mod (total_time,60); 
        secs = round(secs);
        set(handles.time_duration,'String',[num2str(mins) ':' num2str(secs)]);
        set(handles.time_current,'String',[num2str(current_mins) ':' num2str(current_secs)]);
        setappdata(0,'current_sample',get(player,'CurrentSample'));   
        time_slider = current_sample/total_sample;
        set(handles.time_adjust,'Value',time_slider);
        end
    end
        if current_sample == 1 && ~isplaying(player) && get(handles.random_button,'value')
            while  index
                i = index;
           index = randi(num_of_index);
                if i ~= index
                     break;
                end
            end
        setappdata(0,'speed',1);
        setappdata(0,'value',1);
        set(handles.volume_slider,'value',1);
        set(handles.speed_slider,'value',1);
                handles.path = strcat(path,music_data{index});
        set(handles.text,'string',['Playing ' music_data{index}]);
        [m,f] = audioread(handles.path);
        player = audioplayer(m,f); 
        play(player);
        total_sample= get(player,'TotalSamples');
        total_time = total_sample/f; 
        mins = total_time/60; mins = floor(mins);
        secs = mod (total_time,60); 
        secs = round(secs);
        set(handles.time_duration,'String',[num2str(mins) ':' num2str(secs)]);
        set(handles.time_current,'String',[num2str(current_mins) ':' num2str(current_secs)]);
        setappdata(0,'current_sample',get(player,'CurrentSample'));   
        time_slider = current_sample/total_sample;
        set(handles.time_adjust,'Value',time_slider);
        end
    pause(0.1);
 end


guidata(hObject, handles);

% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player
stop(player);
handles.listbox.String = [];
set(handles.text,'string','');
set(handles.duration,'string','');
set(handles.time_current,'string','');
set(handles.time_duration,'string','');
set(handles.volume_slider,'value',1);
set(handles.speed_slider,'value',1);
clc; clear all;

% --- Executes on button press in loop_button.
function loop_button_Callback(hObject, eventdata, handles)
% hObject    handle to loop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of loop_button
if get(handles.loop_button,'value')
    set(handles.loop_text,'string','Loop : On');
else
    set(handles.loop_text,'string','Loop : Off');
end

% --- Executes on button press in random_button.
function random_button_Callback(hObject, eventdata, handles)
% hObject    handle to random_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of random_button
if get(handles.random_button,'value')
    set(handles.random_text,'string','Random : On');
else
    set(handles.random_text,'string','Random : Off');
end
