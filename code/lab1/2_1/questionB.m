% 参数设定
N = 100; % 样本数，取足够多的样本以显示信号的周期性
n = 0:N-1; % 离散时间索引

% 绘制信号 x[n] = 1.5sin(2pi*0.1n)
x_n = 1.5 * sin(2 * pi * 0.1 * n);
figure;
stem(n, x_n);
title('离散时间正弦信号 x[n] = 1.5sin(2\pi \times 0.1n)');
xlabel('n');
ylabel('x[n]');

% 信号的数字频率和周期
f = 0.1; % 数字频率s
T = 1 / f; % 周期，样本数
disp(['信号的数字频率为: ', num2str(f)]);
disp(['信号的周期为: ', num2str(T), ' 个样本']);

% 产生并绘制数字频率为 0.9 的正弦序列
f2 = 0.9; % 新的数字频率
x_n2 = sin(2 * pi * f2 * n);
figure;
stem(n, x_n2);
title('数字频率为 0.9 的正弦序列');
xlabel('n');
ylabel('x[n]');

% 计算并显示新序列的周期
T2 = 1 / f2; % 周期，样本数
disp(['数字频率为 0.9 的正弦序列的周期为: ', num2str(T2), ' 个样本']);
