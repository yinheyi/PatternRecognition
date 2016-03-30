%����һ������ģʽʶ��������磬�������������з��ࡣ

%ʱ�䣺2016��3��
%���ߣ������

%########################�����ǳ������ʽ��ʼ��######################################
%��GPU���д���
%matlabpool open;

%����ѵ�����ݣ�train_200.mat��һ��256*200�ľ���ÿ��������Ϊһ��ѵ����������200����
%             target_train.mat��һ��4*200�ľ���ÿһ������Ϊ���Ӧ��Ŀ��ֵ����200����
load ../data/train_200.mat;
load ../data/target_train1.mat;

inputs = train_200;
targets = target_train1;

%����һ�����ڷ���������磬����ֱ�Ӳ���patternnet�������������硣
hiddenLayerSize = 18;
net = patternnet(hiddenLayerSize);

%{
1,��ʱ��������޸Ķ���������ĵ����ݵĴ����������޸�����ѡ�
net.inputs{1}.processFcns = ' ';
net.inputs{1}.processParams =   ;
2,������Ĭ�ϵ������ʼ��������netlay,��ĳ�ʼ��������netnw;
%}

%���������磬��configure���������,������Ȩֵ�ĳ�ʼ������������Ĵ�С���Լ�����������ݵĴ���
net = configure(net,inputs,targets);

%�����������ת�ƺ�����Ĭ�ϵ���������������ת�ƺ�������"tansig"������;
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';

%������������������
net.biasConnect = [1;1];
net.inputConnect = [1;0];
net.layerConnect = [0 0;1 0];
net.outputConnect = [0,1];

%������Ȩֵ��ƫ�ý��г�ʼ����
net.initFcn = 'initlay';
net.layers{1}.initFcn = 'initnw';
net.layers{2}.initFcn = 'initnw';
net = init(net);

%����Ȩֵ��ƫ�õ�ѧϰ����,�Լ�ѧϰ������
net.inputWeights{1,1}.learnFcn = 'learngdm';
net.inputWeights{1,1}.learnParam.lr = 0.01;
net.layerWeights{2,1}.learnFcn = 'learngdm';
net.layerWeights{2,1}.learnParam.lr = 0.01;
net.biases{1}.learnFcn = 'learngdm';
net.biases{1}.learnParam.lr = 0.01;
net.biases{2}.learnFcn = 'learngdm';
net.biases{2}.learnParam.lr = 0.01;

%���������ķָ�����Լ��ֱ������������е�ѵ����������֤���������Ա�����ռ�İٷֱȣ�
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 1;
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0;

%���������ѵ������,����������Ŀ�ꣻ
net.trainFcn = 'traincgb';
net.trainParam.goal = 0.001;
net.trainParam.epochs = 5000;
net.trainParam.showWindow = 1;
%ѵ�������磻
[net,tr] = train(net,inputs,targets,'useParallel','yes');

%���������磻
load ../data/test_1200.mat;
load ../data/target_test1.mat;

inputs = test_1200;
targets = target_test1;
outputs = net(inputs,'useParallel','yes');
[a,b,c,d] = zhengque(outputs,targets);
testResult = [a,b,c d]

%�ر�CPU���д���
%matlabpool close;






