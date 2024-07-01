N = 64; % 序列长度
n = 0:2*N-1; % 时间索引 n

% 定义信号 x(n)
x = cos(2*pi*7*n/N) + 1/2*cos(2*pi*19*n/N);

% 计算信号的快速傅里叶变换（FFT）
X = fft(x, 2*N);

% 计算幅度 |X(k)|
magnitude_X = abs(X);

% 绘制 |X(k)| 的图形
k = 0:2*N-1; % 频率索引 k
stem(k, magnitude_X); % 使用 stem 函数来绘制离散点
xlabel('k');
ylabel('|X(k)|');
title('Magnitude of DFT of x(n)');
grid on;
