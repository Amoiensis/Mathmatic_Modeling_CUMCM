%%
%Clean
clear;clc;
%%
%Data
Start_Position = 2;
Free = [1,2,3,4,5,6];
Time_Limit = 1000;
Group = 1;
CNC_Artifacts = [0,0,1,0,1,0,0,0];
CNC_Process = [1,1,1,1,1,1,1,1];
%%
%Operation Function
[Plan,Duration] = plan_route(Start_Position,Free,Time_Limit,Group,CNC_Artifacts);
%%
%Various Index
%%%%%%%%%%
[T_M,T_I] = min(Duration);%总时间计算;运用总时间判断
%%%%%%%%%%
BW_matrix = (sum((~~Plan)')');
AVE = Duration./BW_matrix;%平均时间计算；
[A_M,A_I] = min(AVE);
%%%%%%%%%
%全部运行完成的最大值
Size_Route = size(Duration);
Size_Free = size(Free);
num = 1;
Full_Plan = [];
Full_Duration = [];
for i=1:Size_Route(1)
    if BW_matrix(i) == Size_Free(2)
        Full_Plan(num,:) = Plan(i,:);
        Full_Duration(num,:) = Duration(i);
        num = num +1;
    end
end
[F_M,F_I] = min(Full_Duration);
%%
%OUTPUT
%总量判据
disp('Total-Choice');
disp (Plan(T_I,:));
disp(Duration(T_I,:));
%平均判据
disp('AVE-Choice');
disp (Plan(A_I,:));
disp(Duration(A_I,:));
%完成判据/完成度判据
disp('Full-Choice');
if isempty(F_I)
    disp('No Achive Case!');
else
    disp (Full_Plan(F_I,:));
    disp(Full_Duration(F_I,:));
end
