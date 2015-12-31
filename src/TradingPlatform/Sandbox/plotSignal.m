
function figureHandle = plotSignal(algoTrader)

figureHandle = figure;
axesHandle = axes();

dataSerie = algoTrader.DataSerie;

plot(axesHandle,dataSerie.DateTime,algoTrader.Signal);

xlim(axesHandle,[dataSerie.DateTime(1) dataSerie.DateTime(end)]);
ylim(axesHandle,[-2 2]);

datetick(axesHandle, 'x', Default.DateFormat, 'keepticks', 'keeplimits');

title(axesHandle, '\bfSignal');
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfValue');

set(axesHandle, 'Box', Default.Box);
set(figureHandle,'Color',Default.BackgroundColor);

set(axesHandle, ...
    'XGrid', Default.XGrid, ...
    'XColor', Default.GridColor, ...
    'YGrid', Default.YGrid, ...
    'YColor', Default.GridColor ...
    );

end
