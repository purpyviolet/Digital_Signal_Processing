% 初始化参数
N = 50; % 样本数
n = 0:N-1; % 离散时间索引

% 定义不同的 Z 值
Z_values = [-1/12 + 1j*pi/6, 1/12 + 1j*pi/6, 1/12, 2 + 1j*pi/6, 1j*pi/6];

% 分别计算和绘制每个 Z 值对应的信号
for k = 1:length(Z_values)
    Z = Z_values(k);
    x_n = exp(Z * n); % 生成信号

    % 绘制信号的实部
    figure;
    subplot(2, 1, 1);
    stem(n, real(x_n));
    title(['信号的实部，Z = ', num2str(real(Z)), ' + ', num2str(imag(Z)), 'j']);
    xlabel('n');
    ylabel('Re{x[n]}');

    % 绘制信号的虚部
    subplot(2, 1, 2);
    stem(n, imag(x_n));
    title(['信号的虚部，Z = ', num2str(real(Z)), ' + ', num2str(imag(Z)), 'j']);
    xlabel('n');
    ylabel('Im{x[n]}');
end

% 计算当 Z = j*pi/6 时的周期
Z_periodic = 1j*pi/6;
period = 2*pi / abs(imag(Z_periodic)); % 信号的周期

% 输出周期
disp(['当 Z = ', num2str(imag(Z_periodic)), 'j 时，信号的周期为: ', num2str(period)]);

