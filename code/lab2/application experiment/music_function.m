function fc = music_function(spec, fs)
    % MUSIC算法的MATLAB实现
    %   spec: 信号频谱列向量或以列向量叠加的矩阵
    %   fs: 信号采样率
    %   输出fc为MUSIC算法估计出的频率

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
        
        % MUSIC算法实现
        [eigenvectors, ~] = eig(R);
        noise_subspace = eigenvectors(:, 1:end-1);
        
        % 搜索所有可能的频率以找到谱峰
        music_spectrum = zeros(nfft, 1);
        for f_idx = 1:nfft
            a = exp(-1j * 2 * pi * (0:(nfft/2)) * (f_idx - 1) / nfft).';
            music_spectrum(f_idx) = 1 / (a' * (noise_subspace * noise_subspace') * a);
        end
        
        % 找到谱峰
        [pkheights, pklocs] = findpeaks(abs(music_spectrum));
        
        % 如果存在多个峰值，则选择最大的峰值
        if ~isempty(pklocs)
            [~, idx] = max(pkheights);
            peak_freq = pklocs(idx);
            fc(k) = (peak_freq-1) * fs / nfft;
        else
            fc(k) = NaN; % 如果没有找到峰值，返回NaN
        end
    end
end
