%Caculate
%%
%图片大小 180x72
%拼出来图片 11x19
clear;clc;

S_r = 180;
S_c = 72;
Row = 11;
Column = 19;
NUM = Row*Column;

for i=1:NUM
   TU(:,:,i) = imread(strcat('t (',strcat(strcat(num2str(i),')'),'.bmp')));
   tu(:,:,i) = im2double(TU(:,:,i));
end

tuu(:,:,:) = tu(:,:,:);

for i=1:NUM
    for j=1:S_r
        for k=1:S_c
            if tu(j,k,i) < 0.1
                tu(j,k,i) = 0;
            else
                if tu(j,k,i) >0.8
                   tu(j,k,i) =1;
                end
            end
        end
    end
end

for i=1:NUM
   A(:,i) = tu(:,1,i);  %左
   B(:,i) = tu(:,72,i); %右
   C(:,i) = tu(1,:,i);  %上
   D(:,i) = tu(180,:,i);  %下
end

Strat_u = zeros(1,S_c) +1;  %上侧全白
Strat_l = zeros(1,S_r) +1;  %左侧全白

start_L = []; num_L = 1;
start_U = []; num_U = 1;
end_R = []; num_R = 1;

for i=1:NUM
    if A(:,i) == Strat_l
        start_L(num_L) = i;
        num_L = num_L+1;
    end
    
    if B(:,i) == Strat_l
        end_R(num_R) = i;
        num_R = num_R+1;
    end
    
    if C(:,i) == Strat_u
        start_U(num_U) = i;
        num_U = num_U+1;
    end
end

%%
%开头
piexl = 12;
Strat_pl = zeros(S_r,piexl) +1;  %左侧全白
NAN_num = 0;

for i=1:(num_L-1)
%     Temp = TU(:,1:piexl,start_L(i));
%     temp = im2double(Temp);
    if   ~isequal(tu(:,1:piexl,start_L(i)),Strat_pl)
        start_L(i) = inf;
        NAN_num = NAN_num +1;
    end
end

head_L = [];
num = 1;

for i=1:(num_L-1)
    if start_L(i) ~= inf
        head_L(num) = start_L(i);
        num = num +1;
    end
end


%%
%结尾
piexl = 6;
End_pl = zeros(S_r,piexl) +1;  %右侧全白
NAN2_num = 0;

for i=1:(num_R-1)
%     Temp = TU(:,1:piexl,start_L(i));
%     temp = im2double(Temp);
    if   ~isequal(tu(:,1:piexl,end_R(i)),End_pl)
        End_pl(i) = inf;
        NAN2_num = NAN2_num +1;
    end
end

tail_R = [];
num = 1;

for i=1:(num_R-1)
    if start_L(i) ~= inf
        tail_R(num) = end_R(i);
        num = num +1;
    end
end

%%
for i=1:NUM
    for j=1:NUM
        Result (i,j) = sum(abs(A(:,i) - B(:,j)));
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('position.mat');
Copy_Result(:,:) = Result(:,:);
Size_test = size(test);

for i=1:Row
%    Result(tail_R(i),:) = inf(NUM,1);
    Result(head_L(i),:) = inf(NUM,1);
end

%test=[62 7 20 21 37 53 64 68 70 73 79 80 97 100 117 132 163 164 178];

for i=1:NUM
    flag = 0;
    for j=1:Size_test(2)
        if test(j) == i
            flag = 1;
        end
    end 
    if flag == 0
        Result(i,:) = inf(NUM,1); 
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


num = 2;
Head = head_L(2);
picture_I = [Head];
while num <= Column
    [temp,Head_I] = min(Result(:,Head));
    picture_I(num) = Head_I;
    Result(Head_I,:) = inf(NUM,1);
    Head = Head_I;
    num = num +1;
%     if Head == 14
%        picture_I(num) = 183;
%              Result(Head,:) = inf(NUM,1);
%         Head = 183;
%         num = num +1
%     end
%     if Head == 84
%        picture_I(num) = 133;
%              Result(Head,:) = inf(NUM,1);
%         Head = 133;
%         num = num +1
%     end
end

Result_tail = [];
for i=1:Row
        Result_tail (1,i) = sum(abs(A(:,picture_I(num-1)) - B(:,1)));
end


gap = 71;
head = 1;
for i=1:Column
    Picture(:,head:head+gap) =  TU(:,:,picture_I(i));
    head = head + gap;
end

figure( );
imshow(Picture);
