clc;
clear all;

wp1 = 0.45 * pi;
wp2 = 0.65 * pi;
ws1 = 0.3 * pi;
ws2 = 0.75 * pi;
As = 40;
tr_width = min((wp1 - ws1), (ws2 - wp2));
M = ceil(7 * pi / tr_width) + 1;
n = [0:1:M-1];
wc1 = (ws1 + wp1) / 2;
wc2 = (wp2 + ws2) / 2;
hd = ideal_lp(wc2, M) - ideal_lp(wc1, M);
w_bla = (blackman(M))'; 
h = hd .* w_bla;
[db, mag, pha, grd, w] = freqz_m(h, [1]); 

subplot(2,2,1);
stem(n, hd);
axis([0 M-1 -0.4 0.5]); 
title('理想冲激响应');
xlabel('n'); 
ylabel('hd(n)'); 

subplot(2,2,2);
stem(n, w_bla);
axis([0 M-1 0 1.1]);
title('Blackman 窗口');
xlabel('n');
ylabel('w(n)');

subplot(2,2,3);
stem(n, h);
axis([0 M-1 -0.4 0.5]);
title('实际冲激响应');
xlabel('n');
ylabel('h(n)');

subplot(2,2,4);
plot(w/pi, db);
axis([0 1 -150 10]); 
grid; 
title('幅度响应（单位：dB）');
xlabel('频率（单位：pi）');
ylabel('分贝');
