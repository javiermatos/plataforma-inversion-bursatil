
function panPostCorrector(object, event)

hMode = getuimode(object,'Exploration.Pan');
fig = hMode.FigureHandle;

currentAxes = locFindAxes(fig,event);

switch(hMode.ModeStateData.style)
    
    case 'x',
        set(currentAxes, 'YLimMode', 'auto');
        
    case 'y',
        set(currentAxes, 'XLimMode', 'auto');
        
end

end

%-----------------------------------------------%
function [ax] = locFindAxes(fig,evd)
% Return the axes that the mouse is currently over
% Return empty if no axes found (i.e. axes has hidden handle)

if ~ishghandle(fig)
    return;
end

% Return all axes under the current mouse point
allHit = localHittest(fig,evd,'axes');
if ~isempty(allHit)
    allAxes = allHit(1);
else
    allAxes = [];
end
ax = [];

for i=1:length(allAxes),
    candidate_ax=allAxes(i);
    if strcmpi(get(candidate_ax,'HandleVisibility'),'off')
        % ignore this axes
        continue;
    end
    b = hggetbehavior(candidate_ax,'Pan','-peek');
    if ~isempty(b) &&  ishandle(b) && ~get(b,'Enable')
        % ignore this axes

        % 'NonDataObject' is a legacy flag defined in
        % datachildren function.
    elseif ~isappdata(candidate_ax,'NonDataObject')
        ax = candidate_ax;
        break;
    end
end

ax = localVectorizeAxes(ax);

end

%-----------------------------------------------%
function obj = localHittest(hFig,evd,varargin)
if feature('HGUsingMATLABClasses')
    obj = plotedit([{'hittestHGUsingMATLABClasses',hFig,evd},varargin(:)]);
else
    obj = double(hittest(hFig,varargin{:}));
    % Ignore objects whose 'hittest' property is 'off'
    obj = obj(arrayfun(@(x)(strcmpi(get(x,'HitTest'),'on')),obj));
end

end

%-----------------------------------------------%
function axList = localVectorizeAxes(hAx)
% Given an axes, return a vector representing any plotyy-dependent axes.
% Note: This code is implementation-specific and meant as a place-holder
% against the time when we have multiple data-spaces in one axes.

axList = hAx;
if ~isempty(axList)
    if isappdata(hAx,'graphicsPlotyyPeer')
        newAx = getappdata(hAx,'graphicsPlotyyPeer');
        if ishghandle(newAx)
            axList = [axList;newAx];
        end
    end
end

end
