% 参数设定
N = 100; % 样本数，可以根据需要修改
n = 0:N-1; % 离散时间索引

% 生成方波信号
square_wave = square(2 * pi * 0.05 * n);

% 生成锯齿波信号
sawtooth_wave = sawtooth(2 * pi * 0.05 * n);

% 生成sinc函数信号
sinc_wave = sinc(n - N/2);

% 绘制方波信号
figure;
subplot(3, 1, 1);
stem(n, square_wave);
title('离散时间方波信号');
xlabel('n');
ylabel('Amplitude');

% 绘制锯齿波信号
subplot(3, 1, 2);
stem(n, sawtooth_wave);
title('离散时间锯齿波信号');
xlabel('n');
ylabel('Amplitude');

% 绘制sinc函数信号
subplot(3, 1, 3);
stem(n - N/2, sinc_wave);
title('离散时间sinc函数信号');
xlabel('n');
ylabel('Amplitude');

% 显示所有图形
figure;
