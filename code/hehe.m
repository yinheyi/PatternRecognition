%=============================================================================
%为了测试简单而建
%下面建立了一个结构体用于存放需要用的到变量；

%打开GPU并行处理
matlabpool open;
options = struct('trainfcn',{'trainb','traincgb','traincgf','traincgp',...
                              'traingd','traingda','traingdm','traingdx','trainoss',...
                              'trainrp','trains','trainc','trainlm','trainr','trainbr','trainbfg'});

%构建一个元胞数组，把上面的结构体组放进元胞数组中，方便用于变量的循环；
cell = {options(1),options(2),options(3),options(4),options(5),...
        options(6),options(7),options(8),options(9),options(10),...
        options(11),options(12),options(13),options(14),options(15),...
        options(16)};
string1 = '本次测试所用的训练函数为：';
string2 = '以下测试的隐含层的神经元的数目是：';
for i = 1:1:16
    result = {0};
    sheet = 1;
    num = 1;
    trainfcn = cell{i}.trainfcn;
    result{1,1} = strcat(string1,trainfcn);
    result{1,6} = '迭代次数';
    result{1,7} = '最小误差';
    result{1,8} = '最小梯度';
    result{1,9} = '迭代停止的触发项';
    
    %设置一个用于存储平均值的开始地址（元胞的第几行）,后面会用到；
        start = 10;
        result{start,13} = '神经元个数';
        result{start,14} = '第一类平均值';
        result{start,15} = '第二类平均值';
        result{start,16} = '第三类平均值';
        result{start,17} = '第四类平均值';
    for j = 15:1:30
        num = num +3;
        result{num,1} = strcat(string2,num2str(j));
         %设置4个变量，用于存储五次的计算和，最后用于求平均值；
            result1 = 0;
            result2 = 0;
            result3 = 0;
            result4 = 0;
            
        for k = 1:1:5
           [tr,testResult] = testNnet(j,cell{i}); 
           num = num +1;
           %把计算结果放入元胞之中；
           result{num,1} = testResult(1,1);
           result{num,2} = testResult(1,2);
           result{num,3} = testResult(1,3);
           result{num,4} = testResult(1,4);
           %把训练的相关信息存储起来；
           result{num,6} = tr.num_epochs;
           result{num,7} = tr.best_perf;
           if isfield(tr,'gradient')
           result{num,8} = tr.gradient(1,tr.num_epochs);
           end
           result{num,9} = tr.stop;
           %把计算结果累加起来；
           result1 = result1 + testResult(1,1);
           result2 = result2 + testResult(1,2);
           result3 = result3 + testResult(1,3);
           result4 = result4 + testResult(1,4);
        end
        average1 = result1 / k;
        average2 = result2 / k;
        average3 = result3 / k;
        average4 = result3 / k;
        start = start +1;
        result{start,13} = j;
        result{start,14} = average1;
        result{start,15} = average2;
        result{start,16} = average3;
        result{start,17} = average4;
        
    end
    xlswrite('result',result,i);
end

%关闭CPU并行处理
matlabpool close;
