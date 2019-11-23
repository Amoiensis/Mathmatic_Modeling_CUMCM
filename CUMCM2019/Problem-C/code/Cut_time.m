%按照时间 将数据分割开来

START = datenum( '18-Apr-2011 00:00:00');
LEN = datenum( '26-Apr-2011 00:00:00') - datenum( '18-Apr-2011 00:00:00');
GAP = datenum( '18-Apr-2011 04:00:00') - datenum( '18-Apr-2011 00:00:00');
result_size = size(Result);

Arr_NUM = ceil(LEN/GAP);
Result_CUT = [];
NUM_STORE = ones(1,ceil(Arr_NUM));

for i=1:result_size(1)
    TEMP = ceil((Result(i,5) - START)/GAP);
    
    if TEMP <1
        TEMP =1;
    else
        if TEMP > Arr_NUM
            TEMP = Arr_NUM;
        end
    end
    Result_CUT(NUM_STORE(TEMP),:,TEMP) = Result(i,:);
    NUM_STORE(TEMP) = NUM_STORE(TEMP)+1;
end
