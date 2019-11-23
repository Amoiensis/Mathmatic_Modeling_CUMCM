
route_size = size(Result);
i = 1;
while i<= 2000
    ori = readtable(strcat(strcat("taxi(",num2str(Result(i,4))),").csv"));
%     Size_ori = size(ori);
    Position = table2array(ori(:,3:4)); %获得经纬度
    j = 0;
    for j=1:result(Result(i,4))
%         figure();
        hold on
        if Result(i+j-1,3) == 1
%             geoplot (Position(Result(i+j-1,1):Result(i+j-1,2),2),Position(Result(i+j-1,1):Result(i+j-1,2),1),'r*');
            plot (Position(Result(i+j-1,1):Result(i+j-1,2),1),Position(Result(i+j-1,1):Result(i+j-1,2),2),'r.');
        else
%             geoplot (Position(Result(i+j-1,1):Result(i+j-1,2),2),Position(Result(i+j-1,1):Result(i+j-1,2),1),'g。');
            plot (Position(Result(i+j-1,1):Result(i+j-1,2),1),Position(Result(i+j-1,1):Result(i+j-1,2),2),'g.');
        end
%     disp(i+j-1);
    end
    i = i+result(Result(i,4));
    disp(i);
end
