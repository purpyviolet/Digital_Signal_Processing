num=[1,-1];
den=[1,0.75,0.125];
len1=15;
n=0:len1;
n1=0:2*len1;

xn=[1,zeros(1,15)];
yn=ones(1,16);
hn1=filter(num,den,xn);
sn1=filter(num,den,yn);
subplot(2,3,1);
stem(n,hn1);
title("单位冲激响应(filter)");
xlabel("n");ylabel("hn");
subplot(2,3,4);
stem(n,sn1);
title("阶跃响应(filter)");
xlabel("n");ylabel("sn");

hn2=conv(xn,impz(num,den,n));
sn2=conv(yn,impz(num,den,n));
subplot(2,3,2);
stem(n,hn1);
title("单位冲激响应(conv)");
xlabel("n");ylabel("hn");
subplot(2,3,5);
stem(n,sn1);
title("阶跃响应(conv)");
xlabel("n");ylabel("sn");

hn3=impz(num,den,n);
sn3=conv(yn,hn3);
subplot(2,3,3);
stem(n,hn3);
title("单位冲激响应(impz)");
xlabel("n");ylabel("hn");
subplot(2,3,6);
stem(n1,sn3)
title("阶跃响应(impz)");
xlabel("n");ylabel("sn");
axis([0,len1,-0.8, 1]);