function fc = capon_function(spec, fs)
    % Capon谐波分解算法的MATLAB实现
    %   spec: 信号频谱列向量或以列向量叠加的矩阵
    %   fs: 信号采样率
    %   输出fc为Capon算法估计出的频率

    % 获取信号的大小信息
    [nfft, signalNum] = size(spec);
    fc = zeros(1, signalNum); % 初始化输出频率数组
    
    % 对每个信号进行处理
    for k = 1:signalNum
        % 获取单列频谱数据
        spectrum = spec(:, k);

        % 计算自相关
        autocorr_values = ifft(abs(spectrum).^2);

        % 生成自相关矩阵
        R = toeplitz(autocorr_values(1:nfft/2+1));

        % 确保自相关矩阵是正定的
        R = R + 1e-6 * eye(size(R));

        % Capon谱估计
        capon_spectrum = zeros(nfft, 1);
        for f_idx = 1:nfft
            a = exp(-1j * 2 * pi * (0:(nfft/2)) * (f_idx - 1) / nfft).';
            capon_spectrum(f_idx) = 1 / (a' * inv(R) * a);
        end
        
        % 找到谱峰
        [valueMax, posMax] = max(capon_spectrum);
        
        % 计算估计的频率
        fc(k) = (posMax-1) * fs / nfft;
    end
end
