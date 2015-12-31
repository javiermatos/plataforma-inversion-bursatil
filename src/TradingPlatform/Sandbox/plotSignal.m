
function figureHandle = plotSignal(algoTrader)

figureHandle = figure;
axesHandle = axes();

dataSerie = algoTrader.DataSerie;

plot(axesHandle,dataSerie.DateTime,algoTrader.Signal);

xlim(axesHandle,[dataSerie.DateTime(1) dataSerie.DateTime(end)]);
ylim(axesHandle,[-2 2]);

datetick(axesHandle, 'x', Settings.DateFormat, 'keepticks', 'keeplimits');

title(axesHandle, '\bfSignal');
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfValue');

set(axesHandle, 'Box', Settings.Box);
set(figureHandle,'Color',Settings.BackgroundColor);

set(axesHandle, ...
    'XGrid', Settings.XGrid, ...
    'XColor', Settings.GridColor, ...
    'YGrid', Settings.YGrid, ...
    'YColor', Settings.GridColor ...
    );

end
