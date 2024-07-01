function s = hear_test(f0, A)
fs = 8000; 
N = fs*1;
n = 1:N;
s = A*cos(2*pi*f0*n/fs);
% subplot(2,1,1)
% plot(n,s)
sound(s,fs)

