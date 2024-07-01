function varargout = allpass(a)
num=[-a 1]; 
den=[1 -a];
[z,p,k]=tf2zp(num,den); 
disp('零点');disp(z); 
disp('极点');disp(p); 
disp('增益系数');disp(k); 
zplane(num,den)

figure
k = 256;
w=0:pi/k:pi;
h=freqz(num,den,w);  
subplot(2,1,1); 
plot(w/pi,abs(h));grid 
title('幅度谱') 
xlabel('\omega/\pi');ylabel('幅值') 
subplot(2,1,2); 
plot(w/pi,angle(h));grid 
title('相位谱') 
xlabel('\omega/\pi');ylabel('弧度')