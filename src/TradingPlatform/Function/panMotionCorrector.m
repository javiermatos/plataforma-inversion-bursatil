
%-----------------------------------------------%
function panMotionCorrector(obj,evd,hMode) %#ok
% This gets called every time we move the mouse in pan mode,
% regardless of whether any buttons are pressed.
fig = hMode.FigureHandle;
ax = hMode.ModeStateData.axes;

% Get current point in pixels
curr_units = hgconvertunits(fig,[0 0 evd.CurrentPoint],...
    'pixels',get(fig,'Units'),fig);
curr_units = curr_units(3:4);

if strcmp(hMode.ModeStateData.mouse,'off')
    set(evd.Source,'CurrentPoint',curr_units);
    hAx = locFindAxes(evd.Source,evd);
    if ~isempty(hAx) && localInBounds(hAx(1))
        setptr(fig,'hand');
    else
        setptr(fig,'arrow');
    end
    return;
end

if isempty(ax) || ~ishghandle(ax(1))
    return;
end

% Only pan if we have a previous pixel point
ok2pan = ~isempty(hMode.ModeStateData.last_pixel);
%The point in the event data is already in pixels
curr_pixel = evd.CurrentPoint;

if ok2pan
    if strcmp(hMode.ModeStateData.mouse,'down')
        localThrowBeginDragEvent(ax(1));
        hMode.ModeStateData.mouse = 'dragging';
    end

    delta_pixel = curr_pixel - hMode.ModeStateData.last_pixel;
 
    % Check to see if the axes has a constraint
    localBehavior = hggetbehavior(ax(1),'Pan','-peek');
    if ~isempty(localBehavior)
        style = locChooseStyle(localBehavior.Style,hMode.ModeStateData.style);
    else
        style = hMode.ModeStateData.style;
    end
    locDataPan(ax,delta_pixel(1),delta_pixel(2),style,hMode);
end

hMode.ModeStateData.last_pixel = curr_pixel;

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

%-----------------------------------------------%
function targetInBounds = localInBounds(hAxes)
%Check if the user clicked within the bounds of the axes. If not, do
%nothing.
targetInBounds = true;
tol = 3e-16;
cp = get(hAxes,'CurrentPoint');
XLims = get(hAxes,'XLim');
if ((cp(1,1) - min(XLims)) < -tol || (cp(1,1) - max(XLims)) > tol) && ...
        ((cp(2,1) - min(XLims)) < -tol || (cp(2,1) - max(XLims)) > tol)
    targetInBounds = false;
end
YLims = get(hAxes,'YLim');
if ((cp(1,2) - min(YLims)) < -tol || (cp(1,2) - max(YLims)) > tol) && ...
        ((cp(2,2) - min(YLims)) < -tol || (cp(2,2) - max(YLims)) > tol)
    targetInBounds = false;
end
ZLims = get(hAxes,'ZLim');
if ((cp(1,3) - min(ZLims)) < -tol || (cp(1,3) - max(ZLims)) > tol) && ...
        ((cp(2,3) - min(ZLims)) < -tol || (cp(2,3) - max(ZLims)) > tol)
    targetInBounds = false;
end

end

%-------------------------------------------------%
function localThrowBeginDragEvent(hObj)

% Throw BeginDrag event
hb = hggetbehavior(hObj,'Pan','-peek');
if ~isempty(hb) && ishandle(hb)
    sendBeginDragEvent(hb);
end

end

%-----------------------------------------------%
function locDataPan(axVector,delta_pixel1,delta_pixel2,style,hMode)
% This is where the panning computation occurs.

hFig = ancestor(axVector(1),'Figure');
range_pixel = cell(size(axVector));
for i = 1:length(axVector)
    range_pixel{i} = hgconvertunits(hFig,get(axVector(i),'Position'),...
        get(axVector(i),'Units'),'Pixels',hFig);
end

% Assumption - If the first plotyy axes is 2D, then all plotyy axes are 2D.
if hMode.ModeStateData.is2D
    for i = 1:length(axVector)
        ax = axVector(i);
        [abscissa, ordinate] = locGetOrdinate(ax);

        orig_lim1 = get(ax,[abscissa,'lim']);
        orig_lim2 = get(ax,[ordinate,'lim']);      

        curr_lim1 = orig_lim1;
        curr_lim2 = orig_lim2;

        % For log plots, transform to linear scale
        if strcmp(get(ax,[abscissa,'scale']),'log')
            is_abscissa_log = true;
            curr_lim1 = log10(curr_lim1);
        else
            is_abscissa_log = false;
        end
        if strcmp(get(ax,[ordinate,'scale']),'log')
            is_ordinate_log = true;
            curr_lim2 = log10(curr_lim2);
        else
            is_ordinate_log = false;
        end
        
        if ~all(isfinite(curr_lim1)) || ~all(isfinite(curr_lim2)) ...
            || ~all(isreal(curr_lim1)) || ~all(isreal(curr_lim2))

            % The following code has been taken from zoom.m
            % If any of the public limits are inf then we need the actual limits
            % by getting the hidden deprecated RenderLimits.
            oldstate = warning('off','MATLAB:HandleGraphics:NonfunctionalProperty:RenderLimits');
            renderlimits = get(ax,'RenderLimits');
            warning(oldstate);
            curr_lim1 = renderlimits(1:2);
            if is_abscissa_log
                curr_lim1 = log10(curr_lim1);
            end
            curr_lim2 = renderlimits(3:4);
            if is_ordinate_log
                curr_lim2 = log10(curr_lim2);
            end
        end

        range_data1 = abs(diff(curr_lim1));
        range_data2 = abs(diff(curr_lim2));

        pixel_width = range_pixel{i}(3);
        pixel_height = range_pixel{i}(4);

        delta_data1 = delta_pixel1 * range_data1 / pixel_width;
        delta_data2 = delta_pixel2 * range_data2 /  pixel_height;

        % Consider direction of axis: [{'normal'|'reverse'}]
        dir1 = get(ax,sprintf('%sdir',abscissa(1)));
        if strcmp(dir1,'reverse')
            new_lim1 = curr_lim1 + delta_data1;
        else
            new_lim1 = curr_lim1 - delta_data1;
        end

        dir2 = get(ax,sprintf('%sdir',ordinate(1)));
        if strcmp(dir2,'reverse')
            new_lim2 = curr_lim2 + delta_data2;
        else
            new_lim2 = curr_lim2 - delta_data2;
        end

        % For log plots, untransform limits
        if is_abscissa_log
            new_lim1 = 10.^new_lim1;
            curr_lim2 = 10.^curr_lim2; %#ok
        end
        if is_ordinate_log
            curr_lim1 = 10.^curr_lim1; %#ok
            new_lim2 = 10.^new_lim2;
        end

        if hMode.ModeStateData.hasImage % Determine axis limits for image
            lims = hMode.ModeStateData.imageBounds{i};
            x = lims(1:2);
            y = lims(3:4);
            %If we are within the bounds of the image to begin with. This is to
            %prevent odd behavior if we panned outside the bounds of the image
            if x(1) <= orig_lim1(1) && x(2) >= orig_lim1(2) &&...
                    y(1) <= orig_lim2(1) && y(2) >= orig_lim2(2)
                dx = new_lim1(2) - new_lim1(1);
                if new_lim1(1) < x(1)
                    new_lim1(1) = x(1);
                    new_lim1(2) = new_lim1(1) + dx;
                end
                if new_lim1(2) > x(2)
                    new_lim1(2) = x(2);
                    new_lim1(1) = new_lim1(2) - dx;
                end
                dy = new_lim2(2) - new_lim2(1);
                if new_lim2(1) < y(1)
                    new_lim2(1) = y(1);
                    new_lim2(2) = new_lim2(1) + dy;
                end
                if new_lim2(2) > y(2)
                    new_lim2(2) = y(2);
                    new_lim2(1) = new_lim2(2) - dy;
                end
            end
        end

        % Set new limits
        if strcmp(style,'x')
            set(ax,[abscissa,'lim'],new_lim1);
            %set(ax,[ordinate,'lim'],orig_lim2);
            set(ax,'YLimMode','auto');
        elseif strcmp(style,'y')
            %set(ax,[abscissa,'lim'],orig_lim1);
            set(ax,'XLimMode','auto');
            set(ax,[ordinate,'lim'],new_lim2);
        elseif strcmp(style,'xy')
            set(ax,[abscissa,'lim'],new_lim1);
            set(ax,[ordinate,'lim'],new_lim2);
        end
    end

else % 3-D
    % Force ax to be in vis3d to avoid wacky resizing
    axis(axVector,'vis3d');

    % For now, just do the same thing as camera toolbar panning.
    junk = nan;
    for i = 1:length(axVector)
        camdolly(axVector(i),-delta_pixel1,-delta_pixel2, junk, 'movetarget', 'pixels');
    end
end

end

%-----------------------------------------------%
function [abscissa, ordinate] = locGetOrdinate(ax)
% Pre-condition: 2-D plot
% Determines abscissa and ordinate as 'x','y',or 'z'

if ~feature('HGUsingMATLABClasses')
    test1 = (camtarget(ax)-campos(ax))==0;
    test2 = camup(ax)~=0;
    ind = find(test1 & test2);
    
    dim1 = ind(1);
    dim2 = xor(test1,test2);
    
    key = {'x','y','z'};
    
    abscissa = key{dim2};
    ordinate = key{dim1};
else
    abscissa = 'x';
    ordinate = 'y';
end

end
