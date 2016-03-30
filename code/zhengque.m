function [first,second,third,four] = zhengque( outputs,targets )
%UNTITLED2 Summary of this functtion goes here
%   Detailed explanation goes here
%============================================================================

%求出输入的样本的数目
inputNums = size(outputs,2);
%设置4个矩阵，每列分别是：[0 0 ]，[0 1]，[1 0] [1 1] ,共inputNums个列。该四个矩阵用于求后面的欧式距离；
zerozero = zeros(2,inputNums);
zeroone = repmat([0;1],1,inputNums);
onezero = repmat([1;0],1,inputNums);
oneone = ones(2,inputNums);
%求输出结果分别于点（0 0），（0 1），（1 0），（1 1）的欧式距离的平方。
result1 = (outputs -zerozero) .^ 2;
result1 = sum(result1);
result2 = (outputs -zeroone) .^ 2;
result2 = sum(result2);
result3 = (outputs - onezero) .^ 2;
result3 = sum(result3);
result4 = (outputs - oneone).^2;
result4 = sum(result4);
%求出最小的欧式距离，并标记他们属于哪一类，返回一个行向量；
result = [result1;result2;result3;result4];
[~,minrow] = min(result);
%初始化一个2 * inputNums的零矩阵；
transoutputs = zeros(2,inputNums);
%写入
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
%计算第一种目标的正确率；
num = 0;
for i = 1:1:inputNums / 4
    if transoutputs(:,i) == targets(:,i)
        num = num +1;
    end
end
first = num /(inputNums /4);
%=================================================================================
%计算第二种目标的正确率；
num = 0;
for i = inputNums / 4 + 1:1:inputNums / 2
    if transoutputs(:,i) == targets(:,i)
        num = num +1;
    end
end
second = num /(inputNums /4);
%=================================================================================
%计算第三种目标的正确率；
num = 0;
for i = inputNums / 2 + 1:1:inputNums * 0.75
    if transoutputs(:,i) == targets(:,i)
        num = num +1;
    end
end
third = num /(inputNums /4);
%=================================================================================
%计算第四种目标的正确率；
num = 0;
for i = inputNums * 0.75 + 1:1:inputNums
    if transoutputs(:,i) == targets(:,i)
        num = num +1;
    end
end
four = num /(inputNums /4);
end
