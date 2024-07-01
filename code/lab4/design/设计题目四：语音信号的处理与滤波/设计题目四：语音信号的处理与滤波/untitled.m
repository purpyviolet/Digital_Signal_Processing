function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 16-Aug-2021 15:45:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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

% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% 系统录音
function pushbutton1_Callback(hObject, eventdata, handles)
    set(handles.pushbutton1,'BackgroundColor',[0.545,0.753,0.988]);
    set(handles.pushbutton2,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton3,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton4,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton5,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton6,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton7,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton8,'BackgroundColor',[0.651,0.651,0.651]);
    fs = 8000;           % 采样频率
    duration = 4;        % 时间长度(秒） 
    % 创建一个录音文件：fs =8000Hz, 16-bit, 单通道
    voice = audiorecorder(fs, 16, 1);   
    recordblocking(voice, duration);   % 录音2秒钟
    stop(voice);
    y = getaudiodata(voice);
    ymax = max(abs(y));  % 归一化
    y = y/ymax;
    audiowrite('recording.wav',y,fs); % 存储录音文件

% 语音播放
function pushbutton2_Callback(hObject, eventdata, handles)
    set(handles.pushbutton2,'BackgroundColor',[0.545,0.753,0.988]);
    set(handles.pushbutton1,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton3,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton4,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton5,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton6,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton7,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton8,'BackgroundColor',[0.651,0.651,0.651]);
    fs = 8000;           % 采样频率
    duration = 4;        % 时间长度(秒） 
    n = duration*fs;     % 采样点数
    t = (1:n)/fs;
    y = audioread('recording.wav');  %读取音频100到10000部分
    plot(handles.axes1,t,y);                          % 画出声音的时域波形图
    xlabel(handles.axes1,'时间/s');                   % x轴标题
    ylabel(handles.axes1,'相对信号强度');                     % y轴标题
    L = length(y);
    X=fft(y,L);
    A = fftshift(X);
    A=abs(A);
    ws = 2* pi* fs;
    w1 = (-ws/2 + (0:L-1) * ws/L)/(2 * pi);
    plot(handles.axes2,w1, abs(A)); 
    xlabel(handles.axes2,'频率/Hz');
    ylabel(handles.axes2,'幅度');
    clear sound
    sound(y);

% 语音滤波
function pushbutton3_Callback(hObject, eventdata, handles)
    set(handles.pushbutton3,'BackgroundColor',[0.545,0.753,0.988]);
    set(handles.pushbutton2,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton1,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton4,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton5,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton6,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton7,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton8,'BackgroundColor',[0.651,0.651,0.651]);
    fs = 8000;           % 采样频率
    duration = 4;        % 时间长度(秒） 
    n = duration*fs;     % 采样点数
    t = (1:n)/fs;
    y = audioread('recording.wav');
    L = length(y);
    ws = 2* pi* fs;
    w1 = (-ws/2 + (0:L-1) * ws/L)/(2 * pi);
    fs1 = str2double(get(handles.edit1,'String'));  %阻带下边界
    fsu = str2double(get(handles.edit3,'String'));  %阻带上边界
    fpl = str2double(get(handles.edit2,'String'));  %通带下边界
    fpu = str2double(get(handles.edit4,'String'));  %通带上边界 
    As = str2double(get(handles.edit5,'String'));  %阻带最小衰减
    Fs = str2double(get(handles.edit6,'String'));  %抽样频率
    if ( fs1 > 100 || fsu > 100 || fpl > 100 || fpu > 100 || Fs > 100 )
        %msgbox('单位：kHz，请重新输入','注意');
        ha=msgbox('默认单位：kHz，请重新输入 0 ~ 100','注意');
        % 设置显示字体大小和粗细
        hb = findobj(ha, 'Type', 'text');
        set(hb, 'FontSize', 16, 'FontUnit', 'normal','FontWeight','Bold');
        % 设置字体居中
        th = findall(0, 'Tag','MessageBox' );
        boxPosition = get(ha,'position');
        textPosition = get(th, 'position'); 
        set(th, 'position', [boxPosition(3).*1 textPosition(2) textPosition(3)]);
        set(th, 'HorizontalAlignment', 'center');
        set(ha,'position',[400 400 300 50]);% 使用这个语句可以修改msgbox的位置和大小
        return;
    end
    if ( As > 80 )
        %msgbox('As的范围为 0 ~ 80 ，请重新输入','注意');
        ha=msgbox('As的范围为 0 ~ 80 ，请重新输入','注意');
        % 设置显示字体大小和粗细
        hb = findobj(ha, 'Type', 'text');
        set(hb, 'FontSize', 16, 'FontUnit', 'normal','FontWeight','Bold');
        % 设置字体居中
        th = findall(0, 'Tag','MessageBox' );
        boxPosition = get(ha,'position');
        textPosition = get(th, 'position'); 
        set(th, 'position', [boxPosition(3).*1 textPosition(2) textPosition(3)]);
        set(th, 'HorizontalAlignment', 'center');
        set(ha,'position',[400 400 300 50]);% 使用这个语句可以修改msgbox的位置和大小
        return;
    end
    fs1 = fs1 * 1000;
    fsu = fsu * 1000;
    fpl = fpl * 1000;
    fpu = fpu * 1000;
    Fs = Fs * 1000;
    if (As > 0 && As <= 21) %通过As来判断使用合适的窗函数
        if get(handles.radiobutton1,'value')    %矩形窗设计低通滤波器
            if fs1 < fpu  %异常处理
                fs1 = 2500;fpu = 1500;  %默认低通滤波阻带起始频率和通带截止频率
            end 
            ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;
            Bt = ws1 - wpu; %计算过渡带
            M0 = ceil(1.8*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = (wpu+ws1)/2/pi; %计算理想低通滤波器通带截止频率(关于pi归一化) 
            hn = fir1(M0-1,wc,boxcar(M0)); %求矩形窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','矩形窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);                          % 画出声音的时域波形图
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton2,'value')    %矩形窗设计高通滤波器
            if fsu > fpl  %异常处理
                fpl = 2500; fsu = 1500;
            end   
            wp1=2*pi*fpl/Fs;
            wsu=2*pi*fsu/Fs;
            Bt=wp1-wsu; %计算过渡带
            M0 = ceil(1.8*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc=(wp1+wsu)/2/pi;   %计算高通滤波器通带截止频率归一化
            wn = boxcar(M0);
            hn=fir1(M0-1,wc,'high',wn);  %求矩形窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','矩形窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);                          % 画出声音的时域波形图
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton3,'value')    %矩形窗设计带通滤波器
            if (fpl < fs1) || (fsu < fpu)
                fs1 = 800;fpl = 1400;fpu = 2600;fsu = 3200;
            end    
            wp1 = 2*pi*fpl/Fs;ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;wsu=2*pi*fsu/Fs;
            Bt = wp1 - ws1; %计算过渡带
            M0 = ceil(1.8*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = [(wp1 + ws1)/2/pi,(wpu + wsu)/2/pi];  
            %计算理想带通滤波器通带截止频率(关于pi归一化)
            hn = fir1(M0-1,wc,boxcar(M0)); %求矩形窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','矩形窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);  
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton4,'value')    %矩形窗设计带阻滤波器
            %矩形窗设计带阻滤波器
            if (fpl > fs1) || (fsu > fpu)
                fpl = 800;fs1 = 1400;fsu = 2600;fpu = 3200;
            end 
            wp1 = 2*pi*fpl/Fs;ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;wsu=2*pi*fsu/Fs;
            Bt = ws1 - wp1; %计算过渡带
            M0 = ceil(1.8*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = [(wp1 + ws1)/2/pi,(wpu + wsu)/2/pi];  
            %计算理想带阻滤波器通带截止频率(关于pi归一化)
            wn = boxcar(M0);
            hn=fir1(M0-1,wc,'STOP',wn);  %求矩形窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','矩形窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x); 
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        end
    end
    if (As > 21 && As <= 25) %通过As来判断使用合适的窗函数
        if get(handles.radiobutton1,'value')    %矩形窗设计低通滤波器
            if fs1 < fpu  %异常处理
                fs1 = 2500;fpu = 1500;  %默认低通滤波阻带起始频率和通带截止频率
            end   
            ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;
            Bt = ws1 - wpu; %计算过渡带
            M0 = ceil(6.1*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = (wpu+ws1)/2/pi; %计算理想低通滤波器通带截止频率(关于pi归一化) 
            hn = fir1(M0-1,wc,bartlett(M0)); %求三角窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','三角形窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);                          % 画出声音的时域波形图
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton2,'value')    %矩形窗设计高通滤波器
            if fsu > fpl  %异常处理
                fpl=2500;fsu=1500;
            end   
            wp1=2*pi*fpl/Fs;
            wsu=2*pi*fsu/Fs;
            Bt=wp1-wsu; %计算过渡带
            M0 = ceil(6.1*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc=(wp1+wsu)/2/pi;   %计算高通滤波器通带截止频率归一化
            wn = bartlett(M0);
            hn=fir1(M0-1,wc,'high',wn);  %求三角窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','三角形窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voicefiltered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);                          % 画出声音的时域波形图
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton3,'value')    %矩形窗设计带通滤波器
            if (fpl < fs1) || (fsu < fpu)
                fs1 = 800;fpl = 1400;fpu = 2600;fsu = 3200;
            end  
            wp1 = 2*pi*fpl/Fs;ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;wsu=2*pi*fsu/Fs;
            Bt = wp1 - ws1; %计算过渡带
            M0 = ceil(6.1*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = [(wp1 + ws1)/2/pi,(wpu + wsu)/2/pi];  
            %计算理想带通滤波器通带截止频率(关于pi归一化)
            hn = fir1(M0-1,wc,bartlett(M0)); %求三角窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','三角形窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);  
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton4,'value')    %矩形窗设计带阻滤波器
            if (fpl > fs1) || (fsu > fpu)
                    fpl = 800;fs1 = 1400;fsu = 2600;fpu = 3200;
            end
            wp1 = 2*pi*fpl/Fs;ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;wsu=2*pi*fsu/Fs;
            Bt = ws1 - wp1; %计算过渡带
            M0 = ceil(6.1*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = [(wp1 + ws1)/2/pi,(wpu + wsu)/2/pi];  
            %计算理想带阻滤波器通带截止频率(关于pi归一化)
            wn = bartlett(M0);
            hn=fir1(M0-1,wc,'STOP',wn);  %求三角窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','三角形窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);  
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        end
    end
    if (As > 25 && As <= 44) %通过As来判断使用合适的窗函数
        if get(handles.radiobutton1,'value')    %矩形窗设计低通滤波器
            if fs1 < fpu  %异常处理
                fs1 = 2500;fpu = 1500;  %默认低通滤波阻带起始频率和通带截止频率
            end 
            ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;
            Bt = ws1 - wpu; %计算过渡带
            M0 = ceil(6.2*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = (wpu+ws1)/2/pi; %计算理想低通滤波器通带截止频率(关于pi归一化) 
            hn = fir1(M0-1,wc,hanning(M0)); %求汉宁窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','汉宁窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);                          % 画出声音的时域波形图
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton2,'value')    %矩形窗设计高通滤波器
            if fsu > fpl  %异常处理
                fpl = 2500; fsu = 1500;
            end   
            wp1=2*pi*fpl/Fs;
            wsu=2*pi*fsu/Fs;
            Bt=wp1-wsu; %计算过渡带
            M0 = ceil(6.2*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc=(wp1+wsu)/2/pi;   %计算高通滤波器通带截止频率归一化
            wn = hanning(M0);
            hn=fir1(M0-1,wc,'high',wn);  %求矩形窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','汉宁窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);                          % 画出声音的时域波形图
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton3,'value')    %矩形窗设计带通滤波器
            if (fpl < fs1) || (fsu < fpu)
                fs1 = 800;fpl = 1400;fpu = 2600;fsu = 3200;
            end  
            wp1 = 2*pi*fpl/Fs;ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;wsu=2*pi*fsu/Fs;
            Bt = wp1 - ws1; %计算过渡带
            M0 = ceil(6.2*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = [(wp1 + ws1)/2/pi,(wpu + wsu)/2/pi];  
            %计算理想带通滤波器通带截止频率(关于pi归一化)
            hn = fir1(M0-1,wc,hanning(M0)); %求三角窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','汉宁窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);  
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton4,'value')    %矩形窗设计带阻滤波器
            %矩形窗设计带阻滤波器
            if (fpl > fs1) || (fsu > fpu)
                fpl = 800;fs1 = 1400;fsu = 2600;fpu = 3200;
            end 
            wp1 = 2*pi*fpl/Fs;ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;wsu=2*pi*fsu/Fs;
            Bt = ws1 - wp1; %计算过渡带
            M0 = ceil(6.2*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = [(wp1 + ws1)/2/pi,(wpu + wsu)/2/pi];  
            %计算理想带阻滤波器通带截止频率(关于pi归一化)
            wn = hanning(M0);
            hn=fir1(M0-1,wc,'STOP',wn);  %求矩形窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','汉宁窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x); 
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        end
    end
    if (As > 44 && As <= 53) %通过As来判断使用合适的窗函数
        if get(handles.radiobutton1,'value')    %矩形窗设计低通滤波器
            if fs1 < fpu  %异常处理
                fs1 = 2500;fpu = 1500;  %默认低通滤波阻带起始频率和通带截止频率
            end 
            ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;
            Bt = ws1 - wpu; %计算过渡带
            M0 = ceil(6.6*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = (wpu+ws1)/2/pi; %计算理想低通滤波器通带截止频率(关于pi归一化) 
            hn = fir1(M0-1,wc,hamming(M0)); %求矩形窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','海明窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);                          % 画出声音的时域波形图
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton2,'value')    %矩形窗设计高通滤波器
            if fsu > fpl  %异常处理
                fpl = 2500; fsu = 1500;
            end   
            wp1=2*pi*fpl/Fs;
            wsu=2*pi*fsu/Fs;
            Bt=wp1-wsu; %计算过渡带
            M0 = ceil(6.6*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc=(wp1+wsu)/2/pi;   %计算高通滤波器通带截止频率归一化
            wn = hamming(M0);
            hn=fir1(M0-1,wc,'high',wn);  %求矩形窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','海明窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);                          % 画出声音的时域波形图
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton3,'value')    %矩形窗设计带通滤波器
            if (fpl < fs1) || (fsu < fpu)
                fs1 = 800;fpl = 1400;fpu = 2600;fsu = 3200;
            end    
            wp1 = 2*pi*fpl/Fs;ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;wsu=2*pi*fsu/Fs;
            Bt = wp1 - ws1; %计算过渡带
            M0 = ceil(6.6*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = [(wp1 + ws1)/2/pi,(wpu + wsu)/2/pi];  
            %计算理想带通滤波器通带截止频率(关于pi归一化)
            hn = fir1(M0-1,wc,hamming(M0)); %求矩形窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','海明窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);  
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton4,'value')    %矩形窗设计带阻滤波器
            %矩形窗设计带阻滤波器
            if (fpl > fs1) || (fsu > fpu)
                fpl = 800;fs1 = 1400;fsu = 2600;fpu = 3200;
            end 
            wp1 = 2*pi*fpl/Fs;ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;wsu=2*pi*fsu/Fs;
            Bt = ws1 - wp1; %计算过渡带
            M0 = ceil(6.6*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = [(wp1 + ws1)/2/pi,(wpu + wsu)/2/pi];  
            %计算理想带阻滤波器通带截止频率(关于pi归一化)
            wn = hamming(M0);
            hn=fir1(M0-1,wc,'STOP',wn);  %求矩形窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','海明窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);  
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        end
    end
    if (As > 53 && As <= 74) %通过As来判断使用合适的窗函数
        if get(handles.radiobutton1,'value')    %矩形窗设计低通滤波器
            if fs1 < fpu  %异常处理
                fs1 = 2500;fpu = 1500;  %默认低通滤波阻带起始频率和通带截止频率
            end 
            ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;
            Bt = ws1 - wpu; %计算过渡带
            M0 = ceil(11*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = (wpu+ws1)/2/pi; %计算理想低通滤波器通带截止频率(关于pi归一化) 
            hn = fir1(M0-1,wc,blackman(M0)); %求矩形窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','布莱克曼窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);                          % 画出声音的时域波形图
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton2,'value')    %矩形窗设计高通滤波器
            if fsu > fpl  %异常处理
                fpl = 2500; fsu = 1500;
            end   
            wp1=2*pi*fpl/Fs;
            wsu=2*pi*fsu/Fs;
            Bt=wp1-wsu; %计算过渡带
            M0 = ceil(11*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc=(wp1+wsu)/2/pi;   %计算高通滤波器通带截止频率归一化
            wn = blackman(M0);
            hn=fir1(M0-1,wc,'high',wn);  %求矩形窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','布莱克曼窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);                          % 画出声音的时域波形图
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton3,'value')    %矩形窗设计带通滤波器
            if (fpl < fs1) || (fsu < fpu)
                fs1 = 800;fpl = 1400;fpu = 2600;fsu = 3200;
            end    
            wp1 = 2*pi*fpl/Fs;ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;wsu=2*pi*fsu/Fs;
            Bt = wp1 - ws1; %计算过渡带
            M0 = ceil(11*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = [(wp1 + ws1)/2/pi,(wpu + wsu)/2/pi];  
            %计算理想带通滤波器通带截止频率(关于pi归一化)
            hn = fir1(M0-1,wc,blackman(M0)); %求矩形窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','布莱克曼窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);  
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton4,'value')    %矩形窗设计带阻滤波器
            %矩形窗设计带阻滤波器
            if (fpl > fs1) || (fsu > fpu)
                fpl = 800;fs1 = 1400;fsu = 2600;fpu = 3200;
            end 
            wp1 = 2*pi*fpl/Fs;ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;wsu=2*pi*fsu/Fs;
            Bt = ws1 - wp1; %计算过渡带
            M0 = ceil(11*pi/Bt); %求阶数M
            M0 = M0 + mod(M0 + 1,2);
            wc = [(wp1 + ws1)/2/pi,(wpu + wsu)/2/pi];  
            %计算理想带阻滤波器通带截止频率(关于pi归一化)
            wn = blackman(M0);
            hn=fir1(M0-1,wc,'STOP',wn);  %求矩形窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','布莱克曼窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);  
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        end
    end
    if (As > 74 && As <= 80) %通过As来判断使用合适的窗函数
        if get(handles.radiobutton1,'value')    %矩形窗设计低通滤波器
            if fs1 < fpu  %异常处理
                fs1 = 2500;fpu = 1500;  %默认低通滤波阻带起始频率和通带截止频率
            end 
            ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;
            Bt = ws1 - wpu; %计算过渡带
            if As > 50
                alph = 0.112*(As-8.7);
            elseif (21<=As)&&(As<=50)
                alph = 0.5842*(As-21)^0.4+0.07886*(As-21);
            elseif As<21
                alph = 0;
            end
            M0 = ceil((As-8)/2.285/Bt); %求阶数M
            wc = (wpu+ws1)/2/pi; %计算理想低通滤波器通带截止频率(关于pi归一化) 
            hn = fir1(M0,wc,kaiser(M0+1,alph)); %求kaiser窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','凯泽窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);                          % 画出声音的时域波形图
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton2,'value')    %矩形窗设计高通滤波器
            if fsu > fpl  %异常处理
                fpl = 2500; fsu = 1500;
            end   
            wp1=2*pi*fpl/Fs;
            wsu=2*pi*fsu/Fs;
            Bt=wp1-wsu; %计算过渡带
            if As > 50
                alph = 0.112*(As-8.7);
            elseif (21<=As)&&(As<=50)
                alph = 0.5842*(As-21)^0.4+0.07886*(As-21);
            elseif As<21
                alph = 0;
            end
            M1 = ceil((As-8)/2.285/Bt);  %求阶数M
            M = mod(M1,2);
            if (M == 0)
                M0 = M1 + 1;
            else
                M0 = M1;
            end
            wc = (wp1+wsu)/2/pi;   %计算高通滤波器通带截止频率归一化
            wn = kaiser(M0,alph);
            hn=fir1(M0-1,wc,'high',wn);  %求kaiser窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','凯泽窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);                          % 画出声音的时域波形图
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton3,'value')    %矩形窗设计带通滤波器
            if (fpl < fs1) || (fsu < fpu)
                fs1 = 800;fpl = 1400;fpu = 2600;fsu = 3200;
            end    
            wp1 = 2*pi*fpl/Fs;ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;wsu=2*pi*fsu/Fs;
            Bt = wp1 - ws1; %计算过渡带
            if As > 50
                alph = 0.112*(As-8.7);
            elseif (21<=As)&&(As<=50)
                alph = 0.5842*(As-21)^0.4+0.07886*(As-21);
            elseif As<21
                alph = 0;
            end
            M0 = ceil((As-8)/2.285/Bt); %求阶数M
            wc = [(wp1 + ws1)/2/pi,(wpu + wsu)/2/pi];  
            %计算理想带通滤波器通带截止频率(关于pi归一化)
            hn = fir1(M0,wc,kaiser(M0+1,alph)); %求kaiser窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','凯泽窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);  
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        elseif get(handles.radiobutton4,'value')    %矩形窗设计带阻滤波器
            %矩形窗设计带阻滤波器
            if (fpl > fs1) || (fsu > fpu)
                fpl = 800;fs1 = 1400;fsu = 2600;fpu = 3200;
            end 
            wp1 = 2*pi*fpl/Fs;ws1=2*pi*fs1/Fs;
            wpu = 2*pi*fpu/Fs;wsu=2*pi*fsu/Fs;
            Bt = ws1 - wp1; %计算过渡带
            if As > 50
                alph = 0.112*(As-8.7);
            elseif (21<=As)&&(As<=50)
                alph = 0.5842*(As-21)^0.4+0.07886*(As-21);
            elseif As<21
                alph = 0;
            end
            M1 = ceil((As-8)/2.285/Bt);  %求阶数M
            M = mod(M1,2);
            if (M == 0)
                M0 = M1 + 1;
            else
                M0 = M1;
            end
            wc = [(wp1 + ws1)/2/pi,(wpu + wsu)/2/pi];  
            %计算理想带阻滤波器通带截止频率(关于pi归一化)
            wn = kaiser(M0,alph);
            hn=fir1(M0-1,wc,'STOP',wn);  %求kaiser窗
            [Hw,w] = freqz(hn);
            w = w/pi;
            plot(handles.axes3,w,20*log10(abs(Hw)));
            xlabel(handles.axes3,'ω/π');
            ylabel(handles.axes3,'20log|H(e^j^\omega)|(dB)');
            set(handles.edit7,'string','凯泽窗');
            set(handles.edit8,'string',M0);
            final=fftfilt(hn,y,1024);
            ynfft=fftshift(fft(final));
            plot(handles.axes6,w1,abs(ynfft));
            xlabel(handles.axes6,'频率/Hz');
            ylabel(handles.axes6,'幅度');
            audiowrite('filtered_voice.wav',final,fs);
            x=audioread('filtered_voice.wav');
            plot(handles.axes5,t,x);  
            xlabel(handles.axes5,'时间/s');                   % x轴标题
            ylabel(handles.axes5,'相对信号强度');                     % y轴标题
        end
    end
handles.hn = hn;
guidata(hObject,handles);
    
% 重新设计
function pushbutton4_Callback(hObject, eventdata, handles)
    set(handles.pushbutton4,'BackgroundColor',[0.545,0.753,0.988]);
    set(handles.pushbutton2,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton3,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton1,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton5,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton6,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton7,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton8,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.radiobutton1,'value',0);
    set(handles.radiobutton2,'value',0);
    set(handles.radiobutton3,'value',0);
    set(handles.radiobutton4,'value',0);
    set(handles.edit1,'String','');
    set(handles.edit2,'String','');
    set(handles.edit3,'String','');
    set(handles.edit4,'String','');
    set(handles.edit5,'String','');
    set(handles.edit6,'String','');
    set(handles.edit7,'String','');
    set(handles.edit8,'String','');
    cla(handles.axes1,'reset');
    cla(handles.axes2,'reset');
    cla(handles.axes3,'reset');
    cla(handles.axes4,'reset');
    cla(handles.axes5,'reset');
    cla(handles.axes6,'reset');

% 语音回放
function pushbutton5_Callback(hObject, eventdata, handles)
    set(handles.pushbutton5,'BackgroundColor',[0.545,0.753,0.988]);
    set(handles.pushbutton2,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton3,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton4,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton1,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton6,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton7,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton8,'BackgroundColor',[0.651,0.651,0.651]);
    y=audioread('C:\Users\32076\Desktop\数字信号实训\Gxust\滤波后.wav');
    clear sound
    sound(y);

% 加噪处理
function pushbutton6_Callback(hObject, eventdata, handles)
    set(handles.pushbutton6,'BackgroundColor',[0.545,0.753,0.988]);
    set(handles.pushbutton2,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton3,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton4,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton5,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton1,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton7,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton8,'BackgroundColor',[0.651,0.651,0.651]);
    fs = 8000;           % 采样频率
    y = audioread('recording.wav');
    L = length(y);
    ws = 2* pi* fs;
    w1 = (-ws/2 + (0:L-1) * ws/L)/(2 * pi);
    %添加高斯白噪声
    snr = 10; %设定信噪比，单位db
    noise = randn(size(y));              % 用randn函数产生高斯白噪声
    Nx = length(y);                      % 求出信号x长
    signal_power = 1/Nx*sum(y.*y);     % 求出信号的平均能量
    noise_power = 1/Nx*sum(noise.*noise);% 求出噪声的能量
    noise_variance = signal_power / ( 10^(snr/10) );    % 计算出噪声设定的方差值
    noise = sqrt(noise_variance/noise_power)*noise;       % 按噪声的平均能量构成相应的白噪声
    z = y + noise;                         % 合成带噪语音
    audiowrite('add_noise.wav',z,fs); % 存储录音文件
    X = fft(z,L);
    B = fftshift(X);
    B=abs(B);
    plot(handles.axes4,w1,abs(B));
    xlabel(handles.axes4,'频率/Hz');
    ylabel(handles.axes4,'幅度');
    clear sound
    sound(z);
    
% 滤噪处理
function pushbutton7_Callback(hObject, eventdata, handles)
    set(handles.pushbutton7,'BackgroundColor',[0.545,0.753,0.988]);
    set(handles.pushbutton2,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton3,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton4,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton5,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton6,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton1,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton8,'BackgroundColor',[0.651,0.651,0.651]);
    z = audioread('add_noise.wav');  %带噪语言
    hn = handles.hn;
    %% 凯塞窗滤波
    FS = 8000;
    x1 = fftfilt(hn,z);
    sf1 = x1;    %滤波后的信号
    clear sound
    sound(sf1,FS);
    
% 退出系统
function pushbutton8_Callback(hObject, eventdata, handles)
    set(handles.pushbutton8,'BackgroundColor',[0.545,0.753,0.988]);
    set(handles.pushbutton2,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton3,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton4,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton5,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton6,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton7,'BackgroundColor',[0.651,0.651,0.651]);
    set(handles.pushbutton1,'BackgroundColor',[0.651,0.651,0.651]);
    pause(2);
    close

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
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% 低通滤波器
function radiobutton1_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'value',1);
set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',0);
set(handles.radiobutton4,'value',0);

% 高通滤波器
function radiobutton2_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'value',0);
set(handles.radiobutton2,'value',1);
set(handles.radiobutton3,'value',0);
set(handles.radiobutton4,'value',0);

% 带通滤波器
function radiobutton3_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'value',0);
set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',1);
set(handles.radiobutton4,'value',0);

% 带阻滤波器
function radiobutton4_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'value',0);
set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',0);
set(handles.radiobutton4,'value',1);
