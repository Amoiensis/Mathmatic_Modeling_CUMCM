function [Plan,Duration] = plan_route(Position,Free,Limit_Time,Group,CNC_Artifacts,CNC_Process)
%Plan_Route 找到指定点中，最优的安排。
% 给出车辆所在位置，空闲的CNC，决策时间限制；
%2018_Mathmatic_Modling_Problem-B
%%
%Author:YXP
%Email:yxp189@foxmal.com
%Please feel free to contact us for any questions,thank you!
%%
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

%Decision
Size_free = size(Free);
num = 1;
Choice = Free;

for i=1:Size_free(2)
    if  (CNC_Artifacts(i)==1)%&&(CNC_Process(i)==2)
        Choice(Size_free(2)+num) = Free(i);
        num = num+1;
    end
end

Test = perms(Free);
Size_Test = size(Test);
Duration = zeros(factorial(Size_free(2)),Size_free(2));
Result = zeros(factorial(Size_free(2)),Size_free(2));
% Temp_Duration = 0;
% Temp_Result = 0;
% Skip = 0;

%这里的选择，我认为总是选择最近的
i = 1;

%for i=1:Size_Test(1)
while i <= Size_Test(1)
    [Duration(i,:),Result(i,:),Skip] = caculate_time(Position,Test(i,:),Limit_Time,Group,CNC_Artifacts,CNC_Process);
    %用于减少调用
    if Skip~=0
        Temp_Duration = Duration(i,:);
        Temp_Result = Result(i,:);
        TT = i+factorial(Skip)-1;
        for j=i+1:TT
            Duration(j,:)= Temp_Duration;
            Result(j,:) = Temp_Result;
            i = i+1;
        end
    end
    i = i+1;
end

Plan = Result;

end

