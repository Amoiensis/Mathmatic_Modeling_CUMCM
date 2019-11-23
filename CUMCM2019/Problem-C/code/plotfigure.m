lamda=55.54;
x=0:1:50;
a=exp(-(10/lamda)^2);
b=exp(-((2.4*x+5.2)/lamda).^2);
c=exp(-((3.12*x-12.8)/lamda).^2);
y=a.*(x>=0&x<2)+b.*(x>=2&x<25)+c.*(x>=25);
plot(x,y)
grid on