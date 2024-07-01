function varargout = fir1()
h=[-4 3 -5 -2  5 7 5 -2 -1 8 -3];
M=length(h);
L=(M-1)/2;
a=[h(L+1) 2*h(L:-1:1)];
n1=0:1:L;
w=[0:1:500]'*2*pi/500;
Hr=cos(w*n1)*a';
p=angle(Hr);

subplot(2,2,1);
stem(0:L,a); 
xlabel('n');
ylabel('a(n)');
title('a(n)系数')
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
