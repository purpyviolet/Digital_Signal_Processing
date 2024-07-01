% 主程序
% 加载音频文件
[a_signal, a_fs] = audioread('a.m4a');
[e_signal, e_fs] = audioread('e.m4a');
[o_signal, o_fs] = audioread('o.m4a');
[sentence_signal, sentence_fs] = audioread('sentence1.m4a');

% 对每个音频文件进行基音周期估计
a_pitch_periods = estimate_pitch(a_signal, a_fs);
e_pitch_periods = estimate_pitch(e_signal, e_fs);
o_pitch_periods = estimate_pitch(o_signal, o_fs);
sentence_pitch_periods = estimate_pitch(sentence_signal, sentence_fs);

% 绘制基音周期的变化曲线
figure;
subplot(4, 1, 1);
plot(a_pitch_periods);
title('Pitch Periods for "a"');
xlabel('Frame Index');
ylabel('Pitch Period (samples)');

subplot(4, 1, 2);
plot(e_pitch_periods);
title('Pitch Periods for "e"');
xlabel('Frame Index');
ylabel('Pitch Period (samples)');

subplot(4, 1, 3);
plot(o_pitch_periods);
title('Pitch Periods for "o"');
xlabel('Frame Index');
ylabel('Pitch Period (samples)');

subplot(4, 1, 4);
plot(sentence_pitch_periods);
title('Pitch Periods for Sentence');
xlabel('Frame Index');
ylabel('Pitch Period (samples)');