
function plotCorrection(figureHandle)

% Corrections
% Zoom
zoomHandle = zoom(figureHandle);
set(zoomHandle, 'Motion', 'horizontal');
set(zoomHandle, 'ActionPostCallback', @zoomPostCorrector);

% Pan
panHandle = pan(figureHandle);
set(panHandle, 'Motion', 'horizontal');
set(panHandle, 'ActionPreCallback', @panPreCorrector);
set(panHandle, 'ActionPostCallback', @panPostCorrector);
hMode = getuimode(figureHandle,'Exploration.Pan');
set(hMode, 'WindowButtonMotionFcn', {@panMotionCorrector,hMode});

% Protects against edition
set(figureHandle,'HandleVisibility','callback');

end
