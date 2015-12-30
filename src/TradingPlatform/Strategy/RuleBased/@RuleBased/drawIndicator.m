
function drawIndicator(algoTrader, axesHandle, initIndex, endIndex, applySplit, varargin)

% Way to call to drawSeriePosition parent function
algoTrader.drawSeriePosition(axesHandle, initIndex, endIndex, applySplit);

command = [regexprep(algoTrader.Command, '&', 'algoTrader.DataSerie.') ';'];

eval(command);

% Color
color = { 'b' 'y' 'm' 'c' };
colorPicker = @(int) color{mod(int-1,length(color))+1};

hold on;
for i = 1:length(varargin)
    
    serie = eval(varargin{i});
    
    plot(axesHandle, ...
        algoTrader.DataSerie.DateTime(initIndex:endIndex), ...
        serie(initIndex:endIndex), ...
        colorPicker(i) ...
        );
    
end
hold off;

end
