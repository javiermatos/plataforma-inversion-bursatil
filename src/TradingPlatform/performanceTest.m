
ds = YahooDataSerie('tef.mc','days',1,'2009-01-01','2011-01-01');
ma = MovingAverage(ds);
rsi = RelativeStrengthIndex(ds);

i = Intersection(ds,ma,rsi);

tic;
%i.optimize(@profitLoss,@max,@exhaustive,'Samples1',1:15,'Samples2',1:15,'FallThreshold2',10:5:25,'RiseThreshold2',75:5:90);
timeSequential = toc;

% 
N = 50;

time = zeros(1,N);
samples1 = zeros(1,N);
mode1 = cell(1,N);
riseThreshold2 = zeros(1,N);
fallThreshold2 = zeros(1,N);
samples2 = zeros(1,N);
performance = zeros(1,N);

%%

for j = 1:N
    
    j
    
    tic;
    i.optimize(@profitLoss,@max,@geneticAlgorithm,'Samples1',1:15,'Samples2',1:15,'FallThreshold2',10:5:25,'RiseThreshold2',75:5:90);
    time(j) = toc;
    
    samples1(j) = i.Samples1;
    mode1{j} = i.Mode1;
    riseThreshold2(j) = i.RiseThreshold2;
    fallThreshold2(j) = i.FallThreshold2;
    samples2(j) = i.Samples2;
    
    performance(j) = i.ProfitLossTrainingSet;
    
end

%%

for j = 1:N
    
    j
    
    tic;
    
    i.optimize(@profitLoss,@max,{@randomSearch,100},'Samples1',1:15,'Samples2',1:15,'FallThreshold2',10:5:25,'RiseThreshold2',75:5:90);
    
    time(j) = toc;
    
    performance(j) = i.ProfitLossTrainingSet;
    
end

