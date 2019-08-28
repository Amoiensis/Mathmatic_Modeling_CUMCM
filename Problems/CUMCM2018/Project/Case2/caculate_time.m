function [Duration,Result,Skip] = caculate_time(Position,Route,Limit_Time,Group,CNC_Artifacts,CNC_Process)
%caculate_time 计算特定路线的时间花费
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

%Caculate
Size_Free = size(Route);%这里的Free是经过了特别安排后的路线

Duration = zeros(1,Size_Free(2));   %设置初值0；
Result = zeros(1,Size_Free(2));
Step_Duration = 0;
Move = 0;
Temp_Position = Position;
Skip = 0;
num = 1;


LoadClean_Time = zeros(1,Size_Free(2));  %不含移动距离的装载+清洗时间
Case1 = ones(1,8);

if isequal(Case1,CNC_Process)%如果是Case1
    for i=1:Size_Free(2)    %不含移动距离的装载+清洗时间
        LoadClean_Time(i) = LoadClean_Time(i) + Load_Duration(2-mod(Route(i),2),Group);    %工序的上下料时间；
        if CNC_Artifacts(Route(i)) == 1
            LoadClean_Time(i) = LoadClean_Time(i) + Clean_Duration(Group);    %清洗时间
        end
    end
    
    for i=1:Size_Free(2)
        Step_Duration = 0;
        Move = abs(Temp_Position - (Route(i)+mod(Route(i),2))/2);
        if Move ~= 0
            Step_Duration = Step_Duration + Move_Duration(Move,Group);
        end
        Step_Duration = Step_Duration + LoadClean_Time(i);
            if i ~= 1
                Gap = Duration(i-1)+Step_Duration;
            else
                Gap = Duration(i);
            end
        if (Gap) <= Limit_Time
            if i==1
                Duration(i) =  Step_Duration;
            else                
                Duration(i) = Duration(i-1) + Step_Duration;
            end
            Temp_Position = (Route(i)+mod(Route(i),2))/2;
            Result(num) = Route(i);
            num = num+1;
        else
            Skip = (Size_Free(2)-num)+1;
%             for j=1:(Size_Free(2)-num)+1
%                 Result(num) = 0;
%                 Duration(num) = 0;
%                 num = num+1;%%%这里也可以作为返回值，表示有一部分不用重复计算了。GET!
%             end
            break;
        end
    end
else
    for i=1:Size_Free(2)    %不含移动距离的装载+清洗时间
        LoadClean_Time(i) = LoadClean_Time(i) + Load_Duration(2-mod(Route(i),2),Group);    %工序的上下料时间；
        if (CNC_Artifacts(Route(i)) == 1)&&(CNC_Artifacts(Route(i)) == 3)
            LoadClean_Time(i) = LoadClean_Time(i) + Clean_Duration(Group);    %清洗时间
        end
    end
    
    Last_CNC = 0;   %上一个CNC状态0-空/1-Case2-1道工序工件/2-Case2-2道工序工件;
    
    %这里连续1工序后必须是2工序！
    for i=1:Size_Free(2)
        
        Move = abs(Temp_Position - (Route(i)+mod(Route(i),2))/2);
        if Move ~= 0
            Step_Duration = Step_Duration + Move_Duration(Move,Group);
        end
        Step_Duration = Step_Duration + LoadClean_Time(i);
        
        if CNC_Artifacts(Route(i))==1   %如果有货
            
            if (CNC_Process(Route(i))==2) && (i~=Size_Free(2))%如果恰好为1工序
                Last_CNC = 1;
                if CNC_Process(Route(i+1))==2   %如果恰好为1工序,如果后一道也为1工序
                    
                    if i==1
                        Duration(i) =  Step_Duration;
                    else                
                    Duration(i) = Duration(i-1) + Step_Duration;
                    end
%                     Duration = Duration + Step_Duration;
                    Temp_Position = (Route(i)+mod(Route(i),2))/2;
                    Result(num) = Route(i);
%                     num = num+1;
                        Skip = (Size_Free(2)-num)+1;
%                         for j=1:(Size_Free(2)-num)+1
%                             Result(num) = 0;
%                             Duration(num) = 0;
%                             num = num+1;
%                         end
                    break;
                else%有货，如果恰好为1工序,如果后一道为2工序或者是最后一道工序
                        if i ~= 1
                            Gap = Duration(i-1)+Step_Duration;
                        else
                            Gap = Duration(i);
                        end
                    if (Gap) <= Limit_Time
%                     if (Duration(i)+Step_Duration) <= Limit_Time
                        if i==1
                            Duration(i) =  Step_Duration;
                        else                
                            Duration(i) = Duration(i-1) + Step_Duration;
                        end
%                         Duration = Duration + Step_Duration;
                        Temp_Position = (Route(i)+mod(Route(i),2))/2;
                        Result(num) = Route(i);
                        num = num+1;
                    else
                        Skip = (Size_Free(2)-num)+1;
%                         for j=1:(Size_Free(2)-num)+1
%                             Result(num) = 0;
%                             Duration(num) = 0;
%                             num = num+1;
%                         end
                        break;
                    end
                end

            else%如果当前为2工序 
                    Last_CNC = 0;
                    if i ~= 1
                        Gap = Duration(i-1)+Step_Duration;
                    else
                        Gap = Duration(i);
                    end
                    if (Gap) <= Limit_Time
%                     if (Duration(i)+Step_Duration) <= Limit_Time
                        if i==1
                            Duration(i) =  Step_Duration;
                        else                
                            Duration(i) = Duration(i-1) + Step_Duration;
                        end
%                         Duration = Duration + Step_Duration;
                        Temp_Position = (Route(i)+mod(Route(i),2))/2;
                        Result(num) = Route(i);
                        num = num+1;
                    else
                        Skip = (Size_Free(2)-num)+1;
%                         for j=1:(Size_Free(2)-num)+1
%                             Result(num) = 0;
%                             Duration(num) = 0;
%                             num = num+1;%%%这里也可以作为返回值，表示有一部分不用重复计算了。GET!
%                         end
                        break;
                    end  
                    
            end
        else  %如果没有货物
            if (CNC_Process(Route(i))==3) && (Last_CNC==0)   %如果为2工序,且之前没有1工序
%                 Duration = inf; %不可行
%                 Result = zeros(1,Size_Free(2)); %全置0；
                Skip = Size_Free(2) - i;
%                 size_result = size(Result);
%                  for j=1:(Size_Free(2)-size_result(2))
%                         Result(size_result(2)+j) = 0;
%                         Duration(size_result(2)+j) = 0;
%                  end
                break;
            else   %当前正好是工序1，或者之前有工序1
                    if (CNC_Process(Route(i))==3)
                        Last_CNC=0;
                    end
                    if i ~= 1
                        Gap = Duration(i-1)+Step_Duration;
                    else
                        Gap = Duration(i);
                    end
                    if (Gap) <= Limit_Time
%                     if (Duration(i)+Step_Duration) <= Limit_Time
                        if i==1
                            Duration(i) =  Step_Duration;
                        else                
                            Duration(i) = Duration(i-1) + Step_Duration;
                        end
%                         Duration = Duration + Step_Duration;
                        Temp_Position = (Route(i)+mod(Route(i),2))/2;
                        Result(num) = Route(i);
                        num = num+1;
                    else
                        Skip = (Size_Free(2)-num)+1;
%                         for j=1:(Size_Free(2)-num)+1
%                             Result(num) = 0;
%                             Duration(num) = 0;
%                             num = num+1;%%%这里也可以作为返回值，表示有一部分不用重复计算了。GET!
%                         end
                        break;
                    end  
            end
        end
%         Last_CNC = 0;
    end
  
end

end

