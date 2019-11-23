
clear;clc;
head = 1;
for i=1:(size(Route))(1)
    [~,Temp,route_num] = Ataxi(i);
    result(i) = route_num;
    Route(head:head+route_num-1,1:3) = Temp;
    Route(head:head+route_num-1,4) = i;
    head = head + route_num;
end

