function varargout = fir4()
h=[-3 1 -1 -2  5 6 5 -2 -1 1 -3];
M=length(h);
L=M/2;
d= 2*[h(L:-1:1)];
n=1:1:L;
n=n-0.5;
w=[0:1:500]'*2*pi/500;
Hr=sin(w*n)*d';
p=angle(Hr);

subplot(2,2,1);
stem(1:L,d); 
xlabel('n');
ylabel('d(n)');
title('d(n)系数')
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
