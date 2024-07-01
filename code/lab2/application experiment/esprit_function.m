function fc = esprit_function(signal, fs)
    % ESPRIT算法的MATLAB实现
    %   signal: 信号矩阵，每一列代表一个信号
    %   fs: 信号采样率
    %   输出fc为ESPRIT算法估计出的频率

    % 假定信号是已经通过FFT处理过的
    n = size(signal, 1); % 信号长度
    d = size(signal, 2); % 信号数量

    % 初始化频率数组
    fc = zeros(d, 1);

    % 对每个信号执行ESPRIT算法
    for k = 1:d
        % 构造数据矩阵
        X1 = signal(1:end-1, k);
        X2 = signal(2:end, k);

        % SVD分解
        [U, ~, ~] = svd([X1, X2], 'econ');

        % 选择信号子空间
        Us = U(:,1);

        % 解相位
        phi = angle(Us(end) / Us(1));

        % 转换为频率
        fc(k) = fs * phi / (2 * pi);
    end

    % 确保所有频率为正值
    fc = abs(fc);
end
