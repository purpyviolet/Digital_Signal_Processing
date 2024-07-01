clear all;
clc
close all
T = 2;    
fs = 1/T;      
wp = [0.45*pi,0.65*pi];
ws = [0.3*pi,0.8*pi];
Wp = (2/T)*tan(wp/2); 
Ws = (2/T)*tan(ws/2);
Ap = 1; 
As = 40;

[N ,Wc] = buttord(Wp,Ws,Ap,As,'s');
[B ,A] = butter(N,Wc,'stop','s');
W = linspace(0,pi,400*pi);
Hs = freqs(B,A,W);
[Bz,Az] = bilinear(B,A,fs);
Hz = freqz(Bz,Az,W);
 
figure;
subplot(1,2,1);
plot(W/pi,abs(Hs)); 
xlabel('频率/Hz');ylabel('幅值');title('巴特沃斯模拟滤波器');grid on;
subplot(1,2,2);
plot(W/pi,abs(Hz));  
xlabel('频率/Hz');ylabel('幅值');title('巴特沃斯数字滤波器');grid on;
