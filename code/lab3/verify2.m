function varargout = verify2()
num=[1 -0.1 -0.3 -0.3 -0.2]; 
den=[1 0.1 0.2 0.2 0.5];
[z,p,k]=tf2zp(num,den); 
m=abs(p); 
disp('零点');disp(z); 
disp('极点');disp(p); 
disp('增益系数');disp(k); 
sos=zp2sos(z,p,k); 
disp('二阶节');disp(real(sos)); 
zplane(num,den)