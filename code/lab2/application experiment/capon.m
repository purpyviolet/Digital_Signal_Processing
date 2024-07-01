clc;clear;close all;

load S;
SNR=[-20,-15,-10,-5,0,5,10];
SNR_n=length(SNR);
N=78;
n=1:N;
fs=8000;
f=352;
signal = zeros(N,SNR_n);

err=zeros(100,SNR_n);
for i=1:100
    for k = 1:SNR_n-1
        signal(:,k+1) = awgn(S,SNR(k));
    end
    signal(:,1) = S;

    rect = rectwin(N);
    signalRectWin = repmat(rect,1,SNR_n).*signal; 
    fft_signal=real(fftshift(fft(signalRectWin)));
    fc=capon_function(fft_signal,fs);
    err(i,:) = fc-f;
end

err_mse=zeros(SNR_n);
for j=1:SNR_n
    err_mse(j)=mse(err(:,j));
end

plot(SNR,abs(err_mse));
grid on;
xlabel('SNR/dB');
ylabel('MSE/%');

