rate=zeros(10,24);
for i=1:1:10
    g=['cabin (' num2str(i) ').csv'];
    data1 = readtable(g);
    data = table2cell(data1);    %½«table×ª»»³Écell'
    data(:,8)=[];
    %b=str2num(char(data))
    % a=find(data(:,2)<'2011/04/18 01:00:00'); 
    scale=size(data);
    n=scale(1);   
    state=data(:,5);
    state=cell2mat(state);
    date = datevec(data(:,2));
    count=zeros(24,1);
    load=zeros(24,1);
    for j=1:n
        count(date(j,4)+1)=count(date(j,4)+1)+1;
        if state(j,1)==1
            load(date(j,4)+1)=load(date(j,4)+1)+1;
        end
    end
    a=load./count;
    rate(i-50,:)=a';
end

