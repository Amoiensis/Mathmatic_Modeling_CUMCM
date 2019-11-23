initialize;
counttask=zeros(313,1);
countlabor=zeros(313,1);
a=longtitude_no;
b=latitude_no;
for i=1:313
    for j=1:313
        if a(j,1)-0.05<=a(i,1) && a(i,1)<a(j,1)+0.05 && b(j,1)-0.05<=b(i,1) && b(i,1)<b(j,1)+0.05
            counttask(i,1)=counttask(i,1)+1;
        end
    end
end

for i=1:313
    for j=1:1877
        if vip_longtitude(j,1)-0.05<=a(i,1) && a(i,1)<vip_longtitude(j,1)+0.05 && vip_latitude(j,1)-0.05<=b(i,1) && b(i,1)<vip_latitude(j,1)+0.05
            countlabor(i,1)=countlabor(i,1)+capacity(j,1);
        end
    end
end
x1=counttask;
x2=countlabor;
y=73.3072-0.1429*x1-0.0048*x2;
