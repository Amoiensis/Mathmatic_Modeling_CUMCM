function [Duration,Result,Skip] = caculate_time(Position,Route,Limit_Time,Group,CNC_Artifacts)
%caculate_time 计算特定路线的时间花费
%   计算特定路线的时间花费

%Import data
Move_Duration = ...%移动用时;行-不同距离；列-不同组别
    [20	23	18;...
    33	41	32;...
    46	59	46;];

Process_Duration = ...%加工用时;行-不同工序安排；列-不同组别
    [560 580 545;...
    400	280	455;...
    378	500	182;];

Load_Duration = ...%上下料（装载）用时；第一行-1/3/5/7；第二行-2/4/6/8；
    [28	30 27;...
    31 35 32;];

Clean_Duration = ...%清洗用时；列-不同组别
    [25	30 25];

%Caculate
Duration = 0;   %设置初值0；
Step_Duration = 0;
Move = 0;
Temp_Position = Position;
Skip = 0;
Result = [];
num = 1;

Size_Free = size(Route);%这里的Free是经过了特别安排后的路线
LoadClean_Time = zeros(1,Size_Free(2));  %不含移动距离的装载+清洗时间
for i=1:Size_Free(2)    %不含移动距离的装载+清洗时间
    LoadClean_Time(i) = LoadClean_Time(i) + Load_Duration(2-mod(Route(i),2),Group);    %工序的上下料时间；
    if CNC_Artifacts(Route(i)) == 1
        LoadClean_Time(i) = LoadClean_Time(i) + Clean_Duration(Group);    %清洗时间
    end
end

for i=1:Size_Free(2)
    Move = abs(Temp_Position - (Route(i)+mod(Route(i),2))/2);
    if Move ~= 0
        Step_Duration = Step_Duration + Move_Duration(Move,Group);
    end
    Step_Duration = Step_Duration + LoadClean_Time(i);
    if (Duration+Step_Duration) <= Limit_Time
        Duration = Duration + Step_Duration;
        Temp_Position = (Route(i)+mod(Route(i),2))/2;
        Result(num) = Route(i);
        num = num+1;
    else
        Skip = (Size_Free(2)-num)+1;
        for j=1:(Size_Free(2)-num)+1
            Result(num) = 0;
            num = num+1;%%%这里也可以作为返回值，表示有一部分不用重复计算了。
        end
        break;
    end
end

end

