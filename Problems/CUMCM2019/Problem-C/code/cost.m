%计算花费

Size_Result = size(Result);
Result(:,12) = (Result(:,6) - Result(:,5))*24*60;
ERROE_NUM = 0;
num = 1;

for i=1:Size_Result(1)
    if Result(i,3) == 1
        if Result(i,7) <= 2
            Result(i,13) = 10;
        else
            if Result(i,7) <= 25
                Result(i,13) = 10 + (Result(i,7) -2)*2.4;
            else
                Result(i,13) = 10 + (Result(i,7) -2)*2.4*1.3;
            end
        end
        %%%%%计算载到客的收费
        FEE(num) = Result(i,13);
        num = num +1;
        %%%%%
    else
        Result(i,13) = 0;
    end
    if Result(i,13) >= 500
        Result(i,13) = 0;
        ERROE_NUM = ERROE_NUM + 1;
    end
%         TEST(i) = Result(i,13);
end

 D = sum (Result(:,3));
 E = sum (Result(:,13));
 AVE = E / D