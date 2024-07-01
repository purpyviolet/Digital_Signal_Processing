function fc = phd_function(spec, fs)
    %Pisarenko谐波分解算法的MATLAB实现
    %   spec: 信号频谱列向量或以列向量叠加的矩阵
    %   fs: 信号采样率
    %   输出fc为Pisarenko算法估计出的频率

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

        % 特征分解
        [eigenvectors, eigenvalues] = eig(R);
        
        % 找到最小的特征值对应的特征向量
        [min_eigenvalue, min_index] = min(abs(diag(eigenvalues)));
        phd_vector = eigenvectors(:, min_index);
        
        % 计算频率，假设为单频信号
        phd_freq = fs / (2 * pi) * atan2(imag(phd_vector(2)), real(phd_vector(1)));
        
        % 修正频率估计，保证其为正值
        if phd_freq < 0
            phd_freq = phd_freq + fs/2;
        end
        
        % 存储计算的频率
        fc(k) = phd_freq;
    end
end
