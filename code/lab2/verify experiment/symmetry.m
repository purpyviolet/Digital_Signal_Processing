function varargout=symmetry()
x=[1+1j*4, -1+1j*3, 4-1j*2, -5-1j*6];
N=length(x);
n=0:N-1;
x_re=real(x);
x_im=imag(x);
x_conj=conj(x);
xr=x(mod(-n,N)+1);
x_cc=conj(xr);
% x_cc=[1-1j*4, -5+1j*6, 4+1j*2, -2-1j*3];
% x_cs=[1, -3.5+1j*4.5, 4, -3.5-1j*4.5];
% x_ca=[1j*4, 1.5-1j*1.5,-1j*2,-1.5-1j*1.5];
x_cs=0.5*(x+x_cc);
x_ca=0.5*(x-x_cc);

k=0:N-1;
Xk=fft(x);
Xkr=Xk(mod(-k,N)+1);
Xk_cc=conj(Xkr);
Xk_conj=conj(Xk);
Xk_re=real(Xk);
Xk_im=imag(Xk);
Xk_cs=0.5*(Xk+Xk_cc);
Xk_ca=0.5*(Xk-Xk_cc);

X1=fft(x_conj);
X2=fft(x_cc);
X3=fft(x_re);
X4=fft(1j.*x_im);
X5=fft(x_cs);
X6=fft(x_ca);

figure
subplot(2,2,1)
stem(k,real(X1))
title('real part of DFT[x*[n]]')
subplot(2,2,2)
stem(k,imag(X1))
title('imag part of DFT[x*[n]]')
subplot(2,2,3)
stem(k,real(Xk_cc))
title('real part of X*[<-k>N]')
subplot(2,2,4)
stem(k,imag(Xk_cc))
title('imag part of X*[<-k>N]')

figure
subplot(2,2,1)
stem(k,real(X2))
title('real part of DFT[x*[<-n>N]]')
subplot(2,2,2)
stem(k,imag(X2))
title('imag part of DFT[x*[<-n>N]]')
subplot(2,2,3)
stem(k,real(Xk_conj))
title('real part of X*[k]')
subplot(2,2,4)
stem(k,imag(Xk_conj))
title('imag part of X*[k]')

figure
subplot(2,2,1)
stem(k,real(X3))
title('real part of DFT[xre[n]]')
subplot(2,2,2)
stem(k,imag(X3))
title('imag part of DFT[xre[n]]')
subplot(2,2,3)
stem(k,real(Xk_cs))
title('real part of Xcs[k]')
subplot(2,2,4)
stem(k,imag(Xk_cs))
title('imag part of Xcs[k]')

figure
subplot(2,2,1)
stem(k,real(X4))
title('real part of DFT[jxim[n]]')
subplot(2,2,2)
stem(k,imag(X4))
title('imag part of DFT[jxim[n]]')
subplot(2,2,3)
stem(k,real(Xk_ca))
title('real part of Xca[k]')
subplot(2,2,4)
stem(k,imag(Xk_ca))
title('imag part of Xca[k]')

figure
subplot(2,2,1)
stem(k,real(X5))
title('real part of DFT[xcs[n]]')
subplot(2,2,2)
stem(k,imag(X5))
title('imag part of DFT[xcs[n]]')
subplot(2,2,3)
stem(k,real(Xk_re))
title('real part of Xre[k]')
subplot(2,2,4)
stem(k,imag(Xk_re))
title('imag part of Xre[k]')

figure
subplot(2,2,1)
stem(k,real(X6))
title('real part of DFT[xca[n]]')
subplot(2,2,2)
stem(k,imag(X6))
title('imag part of DFT[xca[n]]')
subplot(2,2,3)
stem(k,real(1j*Xk_im))
title('real part of jXim[k]')
subplot(2,2,4)
stem(k,imag(1j*Xk_im))
title('imag part of jXim[k]')