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


% for i=1:NUM
%     for j=1:S_r
%         for k=1:S_c
%             if tu(j,k,i) < 0.5
%                 tu(j,k,i) = 0;
%             else
%                 if tu(j,k,i) >0.5
%                    tu(j,k,i) =1;
%                 end
%             end
%         end
%     end
% end
position = [];
num_t = 1;

Compression  = [];

for i=1:NUM
    Compression(:,i) = mean(tu(:,:,i)')';
end

for i=1:NUM
   for k=1:S_c
       for j=1:S_r
           if tu(j,k,i) == 0
               temp(num_t) = j;
               num_t = num_t + 1;
               break;
           end
       end
   end
   position(i) = min(temp);
   temp = [];
   num_t = 1;
end
%%
test = [];
num_test = 1;
% for i=1:NUM
%     if (position(i)<100)&&(position(i)>=0)
%         test(num_test) = i;
%         num_test = num_test +1;
%     end
% end
%%
% 1----------(Compression(33:54,i),GAP)
% 3----------(Compression(75:99,i),GAP)
% 4----------(Compression(21:42,i),GAP) (Compression(88:109,i),GAP)
% 5----------(Compression(151:172,i),GAP) (Compression(81:102,i),GAP) (Compression(14:35,i),GAP)
%%
% 1 ------------ (Compression(3:7,i),GAP)
%%
GAP = zeros(6,1) +1;
GAP2 = zeros(20,1) +1;
GAP3 = zeros(20,1) +1;
for i=1:NUM
    if isequal (Compression(3:8,i),GAP)
          if isequal(Compression(50:69,i),GAP2)
              if isequal(Compression(113:132,i),GAP2)
                    test(num_test) = i;
                    num_test = num_test +1;
              end 
          end
    end
end

%%
% SAVE
save position.mat
