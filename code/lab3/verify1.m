function a = verify1()
num = [0.0528 0.0797 0.1295 0.1295 0.797 0.0528];
den = [1 -1.8107 2.4947 -1.8801 0.9537 -0.2336];
[z,p] = tf2zp(num,den);
disp('零点');disp(z);
disp('极点');disp(p);

k = 256;
w = 0:pi/k:pi;
h = freqz(num,den,w);
% subplot(2,2,1); 
% plot(w/pi,real(h));grid 
% title('实部') 
% xlabel('\omega/\pi');ylabel('幅度') 
% subplot(2,2,2); 
% plot(w/pi,imag(h));grid 
% title('虚部') 
% xlabel('\omega/\pi');ylabel('Amplitude') 
subplot(2,1,1); 
plot(w/pi,abs(h));grid 
title('幅度谱') 
xlabel('\omega/\pi');ylabel('幅值') 
subplot(2,1,2); 
plot(w/pi,angle(h));grid 
title('相位谱') 
xlabel('\omega/\pi');ylabel('弧度')