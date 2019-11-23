function [result,route,Num] = Ataxi(ORDER)
%ORDER = 1;
for i = ORDER:ORDER
    ori = readtable(strcat(strcat("taxi(",num2str(i)),").csv"));
end
Size_ori = size(ori);
Position = table2array(ori(:,3:4)); %获得经纬度
State = table2array(ori(:,5));  %状态

Ap = [];
As = [];
Aorder = [];
num =1;
for i=1:Size_ori(1)
   if  (Position(i,2) >= 22.59)&&(Position(i,2) <= 22.66)
       if  Position(i,1) <= 113.823
             Aorder(num,:) = i;
             Ap(num,:) = [Position(i,1),Position(i,2)];
             As(num,:) = State(i);
             num = num +1;
       end
   end
end

if isempty(Ap)
    disp(ORDER);
    disp('线路不过机场！');
    result = 0;
else
    %figure();
    %geoplot (Ap(:,2),Ap(:,1),"r*");
%     geobubble(Ap(:,2),Ap(:,1),'colordata',categorical(As));
    disp(ORDER);
    disp('线路过机场！');
    result = 1;
end

route = [];
num_route = 1;
Size_Ao = size(Aorder);

for i=1:Size_Ao(1)
    %找到一个端点
        position = Aorder(i);
   if State(position)
       position = Aorder(i);
        position = position-1;
        while (position>= 1) &&(State(position))
            position = position - 1;
        end
        route(num_route,1) = position+1;
        %找到另外一个端点
        position = Aorder(i);
        position = position+1;
        while (position<=Size_ori(1)) &&(State(position))
            position = position + 1;
        end
        route(num_route,2) = position-1;
        route(num_route,3) = 1;
        num_route = num_route+1;
   end 
%     table2timetable(ori(1:5,2:3))

    position = Aorder(i);
   if (~State(position))
        position = position-1;
        while (position>= 1) &&(~State(position))
            position = position - 1;
        end
        route(num_route,1) = position+1;
        %找到另外一个端点
        position = Aorder(i);
        position = position+1;
        while (position<=Size_ori(1)) && (~State(position)) 
            position = position + 1;
        end
        route(num_route,2) = position-1;
        route(num_route,3) = 0;
        num_route = num_route+1;
   end 
end
    route = unique(route,'rows');    
    Size_route = size(route);
    Num = Size_route(1);
end