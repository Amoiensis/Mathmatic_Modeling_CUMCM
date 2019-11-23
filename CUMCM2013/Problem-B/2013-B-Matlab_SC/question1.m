clear;
clc;
head=zeros(1980,19);
tail=zeros(1980,19);
sequence=zeros(1,19);
y=zeros(1980,1368);
for i=0:9
    text=['00' num2str(i) '.bmp'];
    x=imread(text);
    head(:,i+1)=x(:,1);
    tail(:,i+1)=x(:,72);
end
for i=10:18
    text=['0' num2str(i) '.bmp'];
    x=imread(text);
    head(:,i+1)=x(:,1);
    tail(:,i+1)=x(:,72);
end

for i=1:19
    flag=0;
    for j=1:1980
        if head(j,i)~=255
            flag=1;
        end
    end
    if flag == 0
       sequence(1)=i;
    end
end
            
  for i=1:19
    flag=0;
    for j=1:1980
        if tail(j,i)~=255
            flag=1;
        end
    end
    if flag == 0
        sequence(19)=i;
    end
  end  
  
 pre=sequence(1);
 for i=2:18
     corrvalue=0;
     maxline=1;
     for j=1:19
            matrix=corrcoef(tail(:,pre),head(:,j));
            if matrix(1,2) > corrvalue
                corrvalue = matrix(1,2);
                maxline=j;
            end
     end
     pre = maxline;
     sequence(i) = maxline;
 end
 sequence=sequence-1;
 for i=1:19
     if sequence(i) < 10
        text1=['00' num2str(sequence(i)) '.bmp'];
        x=imread(text1);
        for j=1:72
            y(:,72*(i-1)+j)=x(:,j);
        end
     else 
         text1=['0' num2str(sequence(i)) '.bmp'];
        x=imread(text1);
        for j=1:72
            y(:,72*(i-1)+j)=x(:,j);
        end
     end
 end
 imshow(y)