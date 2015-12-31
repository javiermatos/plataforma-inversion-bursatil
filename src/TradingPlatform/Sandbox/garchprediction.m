
% Step
k = 50;

% DataSerie
ds = YahooDataSerie('nok','days',1,'2010-01-01');

y = ds.Serie;
y = y(1:400);

diffy = diff(y);

diffygarch1 = [diffy(1:300) garchforecast(diffy(1:300),99)]



figure;
hold on;

plot(diffy,'b');

plot(diffygarch1,'r');

hold off;
