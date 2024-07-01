function varargout = fir2()
h=[-3 2 -1 -2  5 6 5 -2 -1 1 -3];
M=length(h);
L=M/2;
b=2*h(L:-1:1);
n=1:1:L;
n=n-0.5;
w=[0:1:500]'*2*pi/500;
Hr=cos(w*n)*b';
p=angle(Hr);

subplot(2,2,1);
stem(1:L,b); 
xlabel('n');
ylabel('b(n)');
title('b(n)系数')
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
