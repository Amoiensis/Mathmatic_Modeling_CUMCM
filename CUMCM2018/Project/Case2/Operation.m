%2018_Mathmatic_Modling_Problem-B
%%
%模拟8h，仿真；
%Author:YXP
%Email:yxp189@foxmal.com
%Please feel free to contact us for any questions,thank you!
%%
%DATA
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

%%
%Defined 
%GROUP
Group = 1;  %目前组数；

%TIMER
Global_Timer = 0;  %全局计时器；从0s开始，持续8h(3600*8s);最短时间间隔1s
Gap = 1;    %离散化；时间间隔1s;
End_Time = 3600*8;  %结束时间8h(3600*8s);

%CNC加工台
CNC_State = zeros(1,8);     %CNC加工机床状态；空闲(0)/加工倒计时(remain);
All_free = zeros(1,8);
All_busy = ones(1,8);
CNC_Artifacts = zeros(1,8); %CNC上是否有工件；0-无/1-有；
CNC_Process = ones(1,8);    %CNC加工工序；1-Case1///2-工序1；3-工序2；

%RGV小车
%%%%%%%%%%%%%%%%%%
%RGV STATE TABLE%
% Order   0     1    2     3         4           5            6
% State	空闲	移动1	移动2	移动3	上下料1/3/5/7	上下料2/4/6/8	清洗
%%%%%%%%%%%%%%%%%%
RGV_State = zeros(1,2); %RGV小车目前所处状态；(STATE,REMAIN)/(状态,剩余时间)
RGV_position = 1;       %RGV小车所在位置；(1-4)
RGV_destination = 1;    %RGV小车目的地；(1-4)

%CONVEYER传送带
Conveyer_State = ones(1,8); %Conveyer状态(0-无货；1-有货)
%%
clear;clc
%%
%Operation
Start_Position = 1;
Node = [1,2,3,4,5,6,7,8];
Node_num = 8;
Free = [1,2,3,4,5,6,7,8];
Time_Limit = 2000;
Group = 1;
CNC_Artifacts = [0,0,0,0,0,0,0,0];
CNC_Process =   [1,1,1,1,1,1,1,1];
plan = [];
duration = [];

while Global_Timer <= End_Time
    if isequal(All_busy,CNC_State)
        Time_Limit = 1500;
    else
        if isequal(All_free,CNC_State)
            Time_Limit = 1500;
            Free = Node;
        else
            Time_Limit = min(CNC_State(find(CNC_State)));
            Free = Node(find(~CNC_State));
            [plan,duration] = Decsion(Start_Position,Free,Time_Limit,Group,CNC_Artifacts,CNC_Process);
        end 
    end
    
    Size_free = size(Free);
    Start =  zeros(1,8);
    if  ~isempty(plan)  %有安排则计算开始时间
        for i=1:Size_free(2)
            Start(plan(i)) = duration(i);
            if CNC_Artifacts(plan(i)) == 1
                Start(plan(i)) = Start(plan(i)) - Clean_Duration(Group);
            end
        end
    end
    
    if ~isequal(Start,All_free)
        for i=1:Node
            
            
    
    
    for i=1:Node_num        
         if CNC_State(i)~= 0
            CNC_State(i) = CNC_State(i) - 1;
         end
    end
    
    Global_Timer = Global_Timer + 1;
end



