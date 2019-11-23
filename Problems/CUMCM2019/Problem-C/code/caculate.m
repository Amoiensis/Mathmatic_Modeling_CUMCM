
route_size = size(Route);
i = 1;
while i<=route_size(1)
    ori = readtable(strcat(strcat("taxi(",num2str(Route(i,4))),").csv"));
    Size_ori = size(ori);
    Position = table2array(ori(:,3:4)); %获得经纬度
    for j=1:result(Route(i,4))
        Route(i+j-1,5) = datenum(table2array(ori(Route(i+j-1,1),2)));
        Route(i+j-1,6) = datenum(table2array(ori(Route(i+j-1,2),2)));
%         STIME (i+j-1,:) = datestr(Route(i+j-1,5));
%         ETIME (i+j-1,:) = datestr(Route(i+j-1,6));
%         TIME (i+j-1,:) = datestr(Route(i+j-1,6) - Route(i+j-1,5),13);
        Temp_distance = 0;
        

        for k= Route(i+j-1,1):(Route(i+j-1,2)-1)
%             if (Position(k,2)) >0 && Position(k,1)>0 && Position(k+1,1)>0 && Position(k+1,2) > 0
                Gap =  distance(Position(k,2),Position(k,1),Position(k+1,2),Position(k+1,1))/180*pi*6370;
                if Gap <= 1
                    Temp_distance = Temp_distance + Gap;
%                     TEST(i+k) = Gap;
%                 else
%                     TEST(i+k) = 0;
                end
                
%             end
        end
        Route(i+j-1,7) = Temp_distance;
        Route(i+j-1,8) = Position(Route(i+j-1,1),2); Route(i+j-1,9) = Position(Route(i+j-1,1),1);
        Route(i+j-1,10) = Position(Route(i+j-1,2),2);Route(i+j-1,11) = Position(Route(i+j-1,2),1);
%         figure();
% hold on
%         if Route(i+j-1,3) == 1
% %             geoplot (Position(Route(i+j-1,1):Route(i+j-1,2),2),Position(Route(i+j-1,1):Route(i+j-1,2),1),'r*');
%             plot (Position(Route(i+j-1,1):Route(i+j-1,2),1),Position(Route(i+j-1,1):Route(i+j-1,2),2),'r*');
%         else
% %             geoplot (Position(Route(i+j-1,1):Route(i+j-1,2),2),Position(Route(i+j-1,1):Route(i+j-1,2),1),'g*');
%             plot (Position(Route(i+j-1,1):Route(i+j-1,2),1),Position(Route(i+j-1,1):Route(i+j-1,2),2),'g*');
%         end
%     disp(i+j-1);
    end
    i = i+result(Route(i,4));
    disp(i);
end
