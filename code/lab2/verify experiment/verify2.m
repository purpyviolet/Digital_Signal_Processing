N = 64; % 序列的点数
k = 0:N-1; % 点的索引

% 计算序列X(k)在单位圆上的64点
X_k = 1 ./ (1 - 0.8 .* exp(-1j * 2 * pi * k / N));

% 计算x(n)通过使用IFFT
x_n = ifft(X_k);

% 因为原始序列是实数，取实部
x_n = real(x_n);

% 显示序列
disp(x_n);

% 可视化序列
stem(0:N-1, x_n);
xlabel('n');
ylabel('x(n)');
title('Sequence x(n) from IFFT');
