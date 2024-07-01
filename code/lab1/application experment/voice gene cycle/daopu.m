function pitch_periods = daopu(signal, fs)
    % 参数设置
    frame_length = round(0.02 * fs);  % 20ms一帧
    frame_shift = round(0.01 * fs);   % 帧移10ms

    % 分帧处理
    num_samples = length(signal);
    num_frames = floor((num_samples - frame_length) / frame_shift) + 1;

    % 初始化基音周期数组
    pitch_periods = zeros(num_frames, 1);

    % 对每一帧进行基音周期估计
    for i = 1:num_frames
        start_sample = (i - 1) * frame_shift + 1;
        end_sample = start_sample + frame_length - 1;
        
        if end_sample > num_samples
            break;
        end
        
        frame = signal(start_sample:end_sample);
        
        % 计算倒谱
        cepstrum = ifft(log10(abs(fft(frame))));

        % 找到倒谱中的峰值，即为基音周期
        [~, locs] = findpeaks(cepstrum, 'MinPeakHeight', max(cepstrum) * 0.2);  % 设置阈值
        if isempty(locs)
            pitch_periods(i) = NaN;  % 找不到峰值，设为NaN
        else
            pitch_periods(i) = locs(1);  % 取第一个峰值位置作为周期
        end
    end
end
