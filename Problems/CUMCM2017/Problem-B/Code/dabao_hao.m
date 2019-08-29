initialize;
flag=zeros(522,1);
k=0;
for i=1:522
    if flag(i,1) == 0
        pacnum=1;
        wei(1)=latitude_yes(i,1);
        jing(1)=longtitude_yes(i,1);
        qian(1)=price_yes(i,1);
    for j=(i+1):522
       if sqrt((latitude_yes(i,1)-latitude_yes(j,1))^2+(longtitude_yes(i,1)-longtitude_yes(j,1))^2) <0.1 && pacnum<3
          pacnum=pacnum+1;
          flag(j,1)=1;
          wei(pacnum)=latitude_yes(j,1);
          jing(pacnum)=longtitude_yes(j,1);
          qian(pacnum)=price_yes(j,1);
       end
    end
    k=k+1;
    if pacnum == 1
        new_wei(k)=latitude_yes(i,1);
        new_jing(k)=longtitude_yes(i,1);
        new_qian(k)=price_yes(i,1);
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
counttask=zeros(201,1);
countlabor=zeros(201,1);
a=new_jing;
b=new_wei;
for i=1:201
    for j=1:201
        if a(j,1)-0.05<=a(i,1) && a(i,1)<a(j,1)+0.05 && b(j,1)-0.05<=b(i,1) && b(i,1)<b(j,1)+0.05
            counttask(i,1)=counttask(i,1)+1;
        end
    end
end

for i=1:201
    for j=1:1877
        if vip_longtitude(j,1)-0.05<=a(i,1) && a(i,1)<vip_longtitude(j,1)+0.05 && vip_latitude(j,1)-0.05<=b(i,1) && b(i,1)<vip_latitude(j,1)+0.05
            countlabor(i,1)=countlabor(i,1)+capacity(j,1);
        end
    end
end
  
y=new_qian;
x1=counttask;
x2=countlabor;
Y=y;
X=[ones(length(y'),1),x1,x2];
b=regress(Y,X)

