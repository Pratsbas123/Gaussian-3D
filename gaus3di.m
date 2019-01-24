function varargout = gaus3d(varargin)
% GAUS3D MATLAB code for gaus3d.fig
%      GAUS3D, by itself, creates a new GAUS3D or raises the existing
%      singleton*.
%
%      H = GAUS3D returns the handle to a new GAUS3D or the handle to
%      the existing singleton*.
%
%      GAUS3D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAUS3D.M with the given input arguments.
%
%      GAUS3D('Property','Value',...) creates a new GAUS3D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gaus3d_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gaus3d_OpeningFcn via varargin.

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gaus3d_OpeningFcn, ...
                   'gui_OutputFcn',  @gaus3d_OutputFcn, ...
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


% --- Executes just before gaus3d is made visible.
function gaus3d_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gaus3d (see VARARGIN)

handles.output = hObject;
axis off
set(handles.azim,'Enable','off')
set(handles.elev,'Enable','off')
set(handles.opt,'Enable','off')
set(handles.axis,'Enable','off')
set(handles.grid,'Enable','off')
set(handles.reset,'Enable','off')
handles.az=32;
handles.el=32;
guidata(hObject, handles);

% UIWAIT makes gaus3d wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gaus3d_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function azim_Callback(hObject, eventdata, handles)
% hObject    handle to azim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.az=get(hObject,'Value');
view(handles.az,handles.el)
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function azim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to azim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function elev_Callback(hObject, eventdata, handles)
% hObject    handle to elev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.el=get(hObject,'Value');
view(handles.az,handles.el)
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function elev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in gauss.
function gauss_Callback(hObject, eventdata, handles)
% hObject    handle to gauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=fspecial('Gaussian',[100 100],8);
surf(h)
set(handles.azim,'Enable','on')
set(handles.elev,'Enable','on')
set(handles.opt,'Enable','on')
set(handles.axis,'Enable','on')
set(handles.grid,'Enable','on')
set(handles.reset,'Enable','on')
guidata(hObject,handles);

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
view(32,32);

% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close gaus3d

% --- Executes on button press in axis.
function axis_Callback(hObject, eventdata, handles)
% hObject    handle to axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=get(hObject,'Value');
if x==1
    axis on
else
    axis off
end

% --- Executes on selection change in opt.
function opt_Callback(hObject, eventdata, handles)
% hObject    handle to opt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=get(hObject,'Value');
h=fspecial('Gaussian',[100 100],8);
if x==1
    mesh(h)
else
    surf(h)
end


% --- Executes during object creation, after setting all properties.
function opt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to opt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in grid.
function grid_Callback(hObject, eventdata, handles)
% hObject    handle to grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=get(hObject,'Value');
if x==1
    grid on
else
    grid off
end
