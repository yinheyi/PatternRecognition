function [first,second,third,four] = zhengque( outputs,targets )
%UNTITLED2 Summary of this functtion goes here
%   Detailed explanation goes here
%============================================================================

%����������������Ŀ
inputNums = size(outputs,2);
%����4������ÿ�зֱ��ǣ�[0 0 ]��[0 1]��[1 0] [1 1] ,��inputNums���С����ĸ���������������ŷʽ���룻
zerozero = zeros(2,inputNums);
zeroone = repmat([0;1],1,inputNums);
onezero = repmat([1;0],1,inputNums);
oneone = ones(2,inputNums);
%���������ֱ��ڵ㣨0 0������0 1������1 0������1 1����ŷʽ�����ƽ����
result1 = (outputs -zerozero) .^ 2;
result1 = sum(result1);
result2 = (outputs -zeroone) .^ 2;
result2 = sum(result2);
result3 = (outputs - onezero) .^ 2;
result3 = sum(result3);
result4 = (outputs - oneone).^2;
result4 = sum(result4);
%�����С��ŷʽ���룬���������������һ�࣬����һ����������
result = [result1;result2;result3;result4];
[~,minrow] = min(result);
%��ʼ��һ��2 * inputNums�������
transoutputs = zeros(2,inputNums);
%д��
for i = 1:1:inputNums
    if 1 == minrow(i)
        transoutputs(:,i) = [0 0];
    elseif 2 == minrow(i)
        transoutputs(:,i) = [0 1];
    elseif 3 == minrow(i)
        transoutputs(:,i) = [1 0];
    else 
        transoutputs(:,i) = [1 1];
    end
end
%==================================================================================
%�����һ��Ŀ�����ȷ�ʣ�
num = 0;
for i = 1:1:inputNums / 4
    if transoutputs(:,i) == targets(:,i)
        num = num +1;
    end
end
first = num /(inputNums /4);
%=================================================================================
%����ڶ���Ŀ�����ȷ�ʣ�
num = 0;
for i = inputNums / 4 + 1:1:inputNums / 2
    if transoutputs(:,i) == targets(:,i)
        num = num +1;
    end
end
second = num /(inputNums /4);
%=================================================================================
%���������Ŀ�����ȷ�ʣ�
num = 0;
for i = inputNums / 2 + 1:1:inputNums * 0.75
    if transoutputs(:,i) == targets(:,i)
        num = num +1;
    end
end
third = num /(inputNums /4);
%=================================================================================
%���������Ŀ�����ȷ�ʣ�
num = 0;
for i = inputNums * 0.75 + 1:1:inputNums
    if transoutputs(:,i) == targets(:,i)
        num = num +1;
    end
end
four = num /(inputNums /4);
end
