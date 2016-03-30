%=============================================================================
%Ϊ�˲��Լ򵥶���
%���潨����һ���ṹ�����ڴ����Ҫ�õĵ�������

%��GPU���д���
matlabpool open;
options = struct('trainfcn',{'trainb','traincgb','traincgf','traincgp',...
                              'traingd','traingda','traingdm','traingdx','trainoss',...
                              'trainrp','trains','trainc','trainlm','trainr','trainbr','trainbfg'});

%����һ��Ԫ�����飬������Ľṹ����Ž�Ԫ�������У��������ڱ�����ѭ����
cell = {options(1),options(2),options(3),options(4),options(5),...
        options(6),options(7),options(8),options(9),options(10),...
        options(11),options(12),options(13),options(14),options(15),...
        options(16)};
string1 = '���β������õ�ѵ������Ϊ��';
string2 = '���²��Ե����������Ԫ����Ŀ�ǣ�';
for i = 1:1:16
    result = {0};
    sheet = 1;
    num = 1;
    trainfcn = cell{i}.trainfcn;
    result{1,1} = strcat(string1,trainfcn);
    result{1,6} = '��������';
    result{1,7} = '��С���';
    result{1,8} = '��С�ݶ�';
    result{1,9} = '����ֹͣ�Ĵ�����';
    
    %����һ�����ڴ洢ƽ��ֵ�Ŀ�ʼ��ַ��Ԫ���ĵڼ��У�,������õ���
        start = 10;
        result{start,13} = '��Ԫ����';
        result{start,14} = '��һ��ƽ��ֵ';
        result{start,15} = '�ڶ���ƽ��ֵ';
        result{start,16} = '������ƽ��ֵ';
        result{start,17} = '������ƽ��ֵ';
    for j = 15:1:30
        num = num +3;
        result{num,1} = strcat(string2,num2str(j));
         %����4�����������ڴ洢��εļ���ͣ����������ƽ��ֵ��
            result1 = 0;
            result2 = 0;
            result3 = 0;
            result4 = 0;
            
        for k = 1:1:5
           [tr,testResult] = testNnet(j,cell{i}); 
           num = num +1;
           %�Ѽ���������Ԫ��֮�У�
           result{num,1} = testResult(1,1);
           result{num,2} = testResult(1,2);
           result{num,3} = testResult(1,3);
           result{num,4} = testResult(1,4);
           %��ѵ���������Ϣ�洢������
           result{num,6} = tr.num_epochs;
           result{num,7} = tr.best_perf;
           if isfield(tr,'gradient')
           result{num,8} = tr.gradient(1,tr.num_epochs);
           end
           result{num,9} = tr.stop;
           %�Ѽ������ۼ�������
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

%�ر�CPU���д���
matlabpool close;
