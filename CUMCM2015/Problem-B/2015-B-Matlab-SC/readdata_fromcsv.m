data1=zeros(2000,2);
for i=1:2000
    g=['cabin (' num2str(i) ').csv'];
    data1(i,:) = xlsread(g,1,'C2:D2');
    i
end
