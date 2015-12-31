
%
inputSize = 10;
outputSize = 5;
samples = 47;

% DataSerie
ds = YahooDataSerie('nok','days',1,'2010-01-01');

y = ds.Serie;
y = y(1:400);

%ypred = zeros(1:401);

input = zeros(inputSize, samples);
output = zeros(outputSize, samples);
for i = 1:samples
    input(:,i) = y(outputSize*(i-1)+1:outputSize*(i-1)+inputSize);
    output(:,i) = y(outputSize*i+1:outputSize*i+outputSize);
end

maxIndex = outputSize*samples+outputSize;

net = feedforwardnet(10);
%net.trainParam.showWindow=0; %default is 1

net = train(net, input, output);

prediction = net(y(maxIndex+1:maxIndex+inputSize)')';

error = y(maxIndex+inputSize+1:maxIndex+inputSize+outputSize)-prediction;

figure;
hold on;

plot(y(maxIndex+inputSize+1:maxIndex+inputSize+outputSize),'k');
plot(prediction,'r');

hold off;

    
    
%     net = feedforwardnet(10);
%     
%     net = train(net, y(i-k+1:i)', y(i+1:i+k)');
%     
%     ypred(i+2:i+k+1) = net(y(i-k+2:i+1)');


% figure;
% hold on;
% 
% plot(y(k+2:101),'b');
% 
% plot(ypred(k+2:101),'r');
% 
% hold off;
