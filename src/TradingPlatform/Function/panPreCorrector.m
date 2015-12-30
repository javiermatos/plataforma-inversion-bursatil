
function panPreCorrector(object, event)

hMode = getuimode(object,'Exploration.Pan');
fig = hMode.FigureHandle;

%axesHandle = findobj(fig, 'Tag', 'Axes');
axesHandle = findobj(fig, 'Type', 'axes');

for i = 1:length(axesHandle)
    
    switch(hMode.ModeStateData.style)
    
    case 'x',
        set(axesHandle(i), 'YLimMode', 'auto');
        
    case 'y',
        set(axesHandle(i), 'XLimMode', 'auto');
        
    end
    
end

end
