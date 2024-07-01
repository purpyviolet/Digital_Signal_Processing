function fc = rife_function(spec,fs)
%Rife算法matlab实现
%   spec:信号频谱列向量或以列向量叠加的矩阵
%   fs:信号采样率
%   输出fc为Rife算法估计出的频率
[length,SignalNum] = size(spec);
[valueMax,posMax] = max(spec(length/2+1:length,:));
disp(posMax)
T = length/fs;
for k = 1:SignalNum
    r= 2*((spec(posMax(k)+length/2,k) > spec(posMax(k)+length/2-2,k))-0.5);
    rat =spec(posMax(k)+length/2+r-1,k) /(valueMax(k)+spec(posMax(k)+length/2+r-1,k));
    % rat = valueMax(k)/(valueMax(k)+spec(posMax(k)+length/2+r-1,k));
    fc(k) = 1/T*(posMax(k)+r*rat-2);
end
end
