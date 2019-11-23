%计算在机场的相关时间和路线收益参数

for j = 1:Arr_NUM
    Result = Result_CUT(:,:,j);
    % clear;clc;
    % load('Cost.mat');
    route_size = size(Result);
    Wait_num = 1;
    Airuse_num = 1;
    Leave_num = 1;

    for i=1:route_size(1)

        if (Result(i,3)==0) && (Result(i,7)<=0.3)
            if  (Result(i,12) <= 100) &&  (Result(i,12) > 0)
                Waittime(Wait_num,1,j) = Result(i,12);
                Waittime(Wait_num,2,j) = i;
                Wait_num = Wait_num + 1;
            end
        end

        if (Result(i,3)==1) && (Result(i,12) >0) && (Result(i,12) <= 300 )
                Airusetime(Airuse_num,1,j) = Result(i,12);
                Airusetime(Airuse_num,2,j) = i;
                Airuse_num = Airuse_num + 1;
        end

        if (Result(i,3)==0) && (Result(i,7)<=120) && (Result(i,12) <= 200 ) && (Result(i,12) > 0 )
                Leavetime(Leave_num,1,j) = Result(i,12);
                Leavetime(Leave_num,2,j) = i;
                Leave_num = Leave_num + 1;
        end

    end

    Ave_Wait(j) = sum(Waittime(:,1,j))/(Wait_num-1);
    Ave_Airuse(j) = sum(Airusetime(:,1,j))/(Airuse_num-1);
    Ave_Leave(j) = sum(Leavetime(:,1,j))/(Leave_num-1);
% 
%     figure();
%     histogram(Waittime(:,1,j));
%     title('机场内等待时间直方图','Fontname','黑体','Fontsize',12);
%     xlabel('时间(min)');
%     ylabel('频数');
%     figure();
%     histogram(Airusetime(:,1,j));
%     title('机场所接单-用时直方图','Fontname','黑体','Fontsize',12);
%     xlabel('时间(min)');
%     ylabel('频数');
%     figure();
%     Leave_Gap = Leavetime(:,1,j) - Ave_Airuse - Ave_Wait;
%     histogram(Leave_Gap);
%     title('机场外接单-可能时间损失直方图','Fontname','黑体','Fontsize',12);
%     xlabel('时间(min)');
%     ylabel('频数');
    
    AVE_fee(j) =  sum(Result_CUT(:,13,j))/sum(Result_CUT(:,3,j));
    WL(j) = (Airuse_num-1)/(Airuse_num + Leave_num - 2);
    
    flag = ((Ave_Leave(j)-Ave_Airuse(j)+30.0)*Ave_Airuse(j)*AVE_fee(j))/(30.0*44.5) - Ave_Airuse(j);
    if flag <= 0
        flag = mean(Waittime(1:(Wait_num-1),1,j));
    end
    tell = Waittime(1:(Wait_num-1),1,j);
    
    total = sum( tell < flag);
    Rate(j,:) = total/ (Wait_num-1);
end