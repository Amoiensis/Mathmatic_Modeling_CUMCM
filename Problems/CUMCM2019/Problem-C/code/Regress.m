%模型分析和对比

X = [Ave_Airuse',AVE_fee',Ave_Leave',Ave_Wait'];

EP = 1 - (((Ave_Wait + Ave_Airuse)*30*44.5)./...
    ((Ave_Leave- Ave_Airuse + 30.0).*Ave_Airuse.*AVE_fee + ((Ave_Wait + Ave_Airuse)*30*44.5)));

DETA = (EP - WL)./WL*100;

size_X = size(X);
X1= [ones(size_X(1),1),X];

[b,bint,r,rint,stats] = regress(WL',X1)



Y = X1*b;

DETAre = (Y' - WL)./WL*100;

figure();
area(DETA);
title('所建立模型与实际决策的差值百分比','Fontname','黑体','Fontsize',12);
xlabel('天数(d)');
ylabel('差值百分比(%)');

figure();
area(DETAre);
title('线性模型与实际决策的差值百分比','Fontname','黑体','Fontsize',12);
xlabel('天数(d)');
ylabel('差值百分比(%)');