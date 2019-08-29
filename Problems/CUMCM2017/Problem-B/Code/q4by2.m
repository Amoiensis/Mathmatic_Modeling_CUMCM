initialize;
q4ini;
counttask=zeros(2066,1);
countlabor=zeros(2066,1);
a=q4jing;
b=q4wei;
for i=1:2066
    for j=1:2066
        if a(j,1)-0.02<=a(i,1) && a(i,1)<a(j,1)+0.02 && b(j,1)-0.02<=b(i,1) && b(i,1)<b(j,1)+0.02
            counttask(i,1)=counttask(i,1)+1;
        end
    end
end

for i=1:2066
    for j=1:1877
        if vip_longtitude(j,1)-0.02<=a(i,1) && a(i,1)<vip_longtitude(j,1)+0.02 && vip_latitude(j,1)-0.02<=b(i,1) && b(i,1)<vip_latitude(j,1)+0.02
            countlabor(i,1)=countlabor(i,1)+capacity(j,1);
        end
    end
end
x1=counttask;
x2=countlabor;
y=73.3072-0.1429*x1-0.0048*x2;