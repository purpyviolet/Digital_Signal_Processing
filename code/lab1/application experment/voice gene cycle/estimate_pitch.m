% 基音周期估计函数
function pitch_periods = estimate_pitch(signal, fs)
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
        
        % 计算自相关函数
        autocorr = xcorr(frame);
        autocorr = autocorr(frame_length:end);  % 取正向自相关函数部分

        % 找到第一个局部极大值，即为基音周期
        [~, locs] = findpeaks(autocorr, 'MinPeakHeight', max(autocorr) * 0.2);  % 设置阈值
        if isempty(locs)
            pitch_periods(i) = NaN;  % 找不到局部极大值，设为NaN
        else
            pitch_periods(i) = locs(1);  % 取第一个局部极大值位置作为周期
        end
    end
end