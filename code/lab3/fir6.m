function varargout = fir6()
h = [-2 1 -3 4 -4 3 -2];
M = length(h);
L = (M-1)/2;
f = [h(L+1) 2*h(L:-1:1)];
n = 0:1:L;
w = [0:1:500]'*2*pi/500;
Hr = cos(w*n)*f';
p = angle(Hr);


subplot(2,2,1);
stem(0:L,f); 
xlabel('n');
ylabel('f(n)');
title('f(n)系数')
grid on
subplot(2,2,2);
zplane(h,1);
grid on
subplot(2,2,3); 
plot(w/pi,Hr);
xlabel('w/pi');ylabel('Hr');
title('幅频特性')
grid on
subplot(2,2,4);
plot(w/pi,p); 
xlabel('w/pi');
title('相频特性')
grid on