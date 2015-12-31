
% Step
k = 50;

% DataSerie
ds = YahooDataSerie('nok','days',1,'2010-01-01');

y = ds.Serie;
y = y(1:400);

% 
yar1 = arforecast(y(1:100), 5, 'fb', 300);
yar1 = [y(1:100) yar1];

yar2 = arforecast(y(1:200), 5, 'fb', 200);
yar2 = [y(1:200) yar2];

yar3 = arforecast(y(1:300), 5, 'fb', 100);
yar3 = [y(1:300) yar3];

yar4 = zeros(1,400);
yar4(51:100) = arforecast(y(1:50), 5, 'fb', 50);

hold on;
plot(y(1:50),'b');
plot(yar4(51:100),'r');
hold off;
%
% figure;
% hold on;
% 
% plot(y,'k');
% 
% plot(yar1,'r');
% plot(yar2,'b');
% plot(yar3,'g');
% 
% plot(yar4,'b');
% 
% hold off;
