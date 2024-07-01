% 滤波器系数
p = [1, -0.5]; % 示例滤波器分子系数
d = [1, 0.5];  % 示例滤波器分母系数
N = 10;        % 单位脉冲响应的长度

% 生成单位脉冲响应
h = impz(p, d, N);

% 生成信号 x[n]
x = ones(1, N); % 示例信号，这里我们只是用一个长度为 N 的全1序列来模拟

% 对信号 x[n] 和单位脉冲响应 h[n] 进行卷积
y = conv(x, h);

% 绘制单位脉冲响应
figure;
subplot(2, 1, 1);
stem(h);
title('单位脉冲响应 h[n]');

% 绘制卷积结果
subplot(2, 1, 2);
stem(y);
title('信号 x[n] 和 h[n] 的卷积结果 y[n]');
xlabel('n');
ylabel('Amplitude');
