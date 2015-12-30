
function zoomPostCorrector(object, event)

hMode = getuimode(object,'Exploration.Zoom');
currentAxes = hMode.ModeStateData.CurrentAxes;

switch(hMode.ModeStateData.Constraint)
    
    case 'horizontal',
        set(currentAxes, 'YLimMode', 'auto');
        
    case 'vertical',
        set(currentAxes, 'XLimMode', 'auto');
        
end

end
