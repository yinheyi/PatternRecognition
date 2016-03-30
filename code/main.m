%建立一个用于模式识别的神经网络，作用是用来进行分类。

%时间：2016年3月
%作者：殷和义

%########################下面是程序的正式开始：######################################
%打开GPU并行处理
%matlabpool open;

%导入训练数据：train_200.mat是一个256*200的矩阵，每个列向量为一个训练样本，共200个。
%             target_train.mat是一个4*200的矩阵，每一列向量为其对应的目标值，共200个。
load ../data/train_200.mat;
load ../data/target_train1.mat;

inputs = train_200;
targets = target_train1;

%建立一个用于分类的神经网络，这里直接采用patternnet函数建立神经网络。
hiddenLayerSize = 18;
net = patternnet(hiddenLayerSize);

%{
1,此时，如果想修改对输入输出的的数据的处理函数可以修改以下选项：
net.inputs{1}.processFcns = ' ';
net.inputs{1}.processParams =   ;
2,神经网络默认的网络初始化函数是netlay,层的初始化函数是netnw;
%}

%配置神经网络，由configure函数来完成,包括了权值的初始化，输入输出的大小，以及输入输出数据的处理；
net = configure(net,inputs,targets);

%设置神经网络的转移函数（默认的隐含层与输出层的转移函数都是"tansig"函数）;
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';

%设置网络的连接情况；
net.biasConnect = [1;1];
net.inputConnect = [1;0];
net.layerConnect = [0 0;1 0];
net.outputConnect = [0,1];

%对网络权值与偏置进行初始化；
net.initFcn = 'initlay';
net.layers{1}.initFcn = 'initnw';
net.layers{2}.initFcn = 'initnw';
net = init(net);

%设置权值和偏置的学习函数,以及学习步长；
net.inputWeights{1,1}.learnFcn = 'learngdm';
net.inputWeights{1,1}.learnParam.lr = 0.01;
net.layerWeights{2,1}.learnFcn = 'learngdm';
net.layerWeights{2,1}.learnParam.lr = 0.01;
net.biases{1}.learnFcn = 'learngdm';
net.biases{1}.learnParam.lr = 0.01;
net.biases{2}.learnFcn = 'learngdm';
net.biases{2}.learnParam.lr = 0.01;

%设置样本的分割函数，以及分别设置子样本中的训练样本、验证样本、测试本样所占的百分比；
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 1;
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0;

%设置网络的训练函数,迭代次数，目标；
net.trainFcn = 'traincgb';
net.trainParam.goal = 0.001;
net.trainParam.epochs = 5000;
net.trainParam.showWindow = 1;
%训练神经网络；
[net,tr] = train(net,inputs,targets,'useParallel','yes');

%测试神经网络；
load ../data/test_1200.mat;
load ../data/target_test1.mat;

inputs = test_1200;
targets = target_test1;
outputs = net(inputs,'useParallel','yes');
[a,b,c,d] = zhengque(outputs,targets);
testResult = [a,b,c d]

%关闭CPU并行处理
%matlabpool close;






