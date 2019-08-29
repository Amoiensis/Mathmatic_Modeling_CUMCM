initialize;
a=longtitude;
b=latitude;
counttask=zeros(835,1);
countlabor=zeros(835,1);
countxy=zeros(835,1);
for i=1:835
    for j=1:835
        if a(j,1)-0.05<=a(i,1) && a(i,1)<a(j,1)+0.05 && b(j,1)-0.05<=b(i,1) && b(i,1)<b(j,1)+0.05
            counttask(i,1)=counttask(i,1)+1;
        end
    end
end

for i=1:835
    for j=1:1877
        if vip_longtitude(j,1)-0.05<=a(i,1) && a(i,1)<vip_longtitude(j,1)+0.05 && vip_latitude(j,1)-0.05<=b(i,1) && b(i,1)<vip_latitude(j,1)+0.05
            countlabor(i,1)=countlabor(i,1)+capacity(j,1);
        end
    end
end
  
for i=1:835
    for j=1:1877
        if vip_longtitude(j,1)-0.05<=a(i,1) && a(i,1)<vip_longtitude(j,1)+0.05 && vip_latitude(j,1)-0.05<=b(i,1) && b(i,1)<vip_latitude(j,1)+0.05
            countxy(i,1)=countxy(i,1)+xinyu(j,1);
        end
    end
end
y=price;
x1=counttask;
x2=countlabor;
x3=countxy;
Y=y;
X=[ones(length(y'),1),x1,x2,x3];
b=regress(Y,X)
