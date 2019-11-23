data;
a=data1(:,1);
b=data1(:,2);
scatter(a,b,'.')

longgang=0;
luohu=0;
futian=0;
nanshan=0;
baoan=0;
longhua=0;
guangming=0;
yantian=0;
pingshan=0;

for i=1:2000;
if a(i,1)>=114.108254 && a(i,1)<=114.216626 && b(i,1)>=22.53873 && b(i,1)<=22.590794
    luohu=luohu+1;
end

if a(i,1)>=114.009656 && a(i,1)<=114.216626 && b(i,1)>=22.517231 && b(i,1)<=22.589726
    futian=futian+1;
end

if a(i,1)>=113.88993 && a(i,1)<=114.009656 && b(i,1)>=22.49052 && b(i,1)<=22.60374
    nanshan=nanshan+1;
end

if a(i,1)>=113.775953 && a(i,1)<=113.927156 && b(i,1)>=22.54821 && b(i,1)<=22.808845
    baoan=baoan+1;
end

if a(i,1)>=113.879438 && a(i,1)<=113.994564 && b(i,1)>=22.725267 && b(i,1)<=22.818839
    guangming=guangming+1;
end

if a(i,1)>=113.973724 && a(i,1)<=114.096756 && b(i,1)>=22.599069 && b(i,1)<=22.766996
    longhua=longhua+1;
end

if a(i,1)>=114.223237 && a(i,1)<=114.340807 && b(i,1)>=22.551948 && b(i,1)<=22.64057
    yantian=yantian+1;
end

if a(i,1)>=114.295102 && a(i,1)<=114.435668 && b(i,1)>=22.632831 && b(i,1)<=22.766196
    pingshan=pingshan+1;
end

if a(i,1)>=114.057661 && a(i,1)<=114.335633 && b(i,1)>=22.599736 && b(i,1)<=22.819505
    longgang=longgang+1;
end

if a(i,1)>=114.334771 && a(i,1)<=114.594201 && b(i,1)>=22.470082 && b(i,1)<=22.670854
    longgang=longgang+1;
end

end