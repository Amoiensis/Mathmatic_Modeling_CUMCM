initialize;
flag=zeros(835,1);
k=0;
for i=1:835
    if flag(i,1) == 0
        pacnum=1;
        wei(1)=latitude(i,1);
        jing(1)=longtitude(i,1);
        qian(1)=price(i,1);
    for j=(i+1):835
       if sqrt((latitude(i,1)-latitude(j,1))^2+(longtitude(i,1)-longtitude(j,1))^2) <0.1 && pacnum<3
          pacnum=pacnum+1;
          flag(j,1)=1;
          wei(pacnum)=latitude(j,1);
          jing(pacnum)=longtitude(j,1);
          qian(pacnum)=price(j,1);
       end
    end
    k=k+1;
    if pacnum == 1
        new_wei(k)=latitude(i,1);
        new_jing(k)=longtitude(i,1);
        new_qian(k)=price(i,1);
    else if pacnum == 2
            new_wei(k)=(wei(1)+wei(2))/2;
            new_jing(k)=(jing(1)+jing(2))/2;
            new_qian(k)=qian(1)+qian(2);
        else if pacnum == 3
            new_wei(k)=(wei(1)+wei(2)+wei(3))/3;
            new_jing(k)=(jing(1)+jing(2)+jing(3))/3;
            new_qian(k)=qian(1)+qian(2)+qian(3);
            end
        end
    end
    end
end
new_wei=new_wei';
new_jing=new_jing';
new_qian=new_qian';
counttask=zeros(316,1);
countlabor=zeros(316,1);
a=new_jing;
b=new_wei;
for i=1:316
    for j=1:316
        if a(j,1)-0.05<=a(i,1) && a(i,1)<a(j,1)+0.05 && b(j,1)-0.05<=b(i,1) && b(i,1)<b(j,1)+0.05
            counttask(i,1)=counttask(i,1)+1;
        end
    end
end

for i=1:316
    for j=1:1877
        if vip_longtitude(j,1)-0.05<=a(i,1) && a(i,1)<vip_longtitude(j,1)+0.05 && vip_latitude(j,1)-0.05<=b(i,1) && b(i,1)<vip_latitude(j,1)+0.05
            countlabor(i,1)=countlabor(i,1)+capacity(j,1);
        end
    end
end
  
x1=counttask;
x2=countlabor;
y=185.8624+1.8669*x1-0.0061*x2;
