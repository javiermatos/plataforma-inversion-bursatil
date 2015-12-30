
%function animation = fitnessMatrix2Animation(fitnessMatrix)
function fitnessMatrix2Animation(fitnessMatrix, dim)

width = 640;
height = 520;

% if nargout == 1
%     fig = figure('Name','Fitness animation','NumberTitle','off','visible','off');
% else
%     fig = figure('Name','Fitness animation','NumberTitle','off');
% end

fig = figure('Name','Fitness animation','NumberTitle','off');
ax = axes;
set(fig,'CurrentAxes',ax);
set(fig,'Position',[ 100 100 width height ]);

% Number of frames
N = size(fitnessMatrix,3);

% Normalize fitness matrix
% maxFitnessValue = max(max(max(fitnessMatrix)));
% minFitnessValue = min(min(min(fitnessMatrix)));
% fitnessMatrix(fitnessMatrix>0) = fitnessMatrix(fitnessMatrix>0)./maxFitnessValue;
% fitnessMatrix(fitnessMatrix<0) = fitnessMatrix(fitnessMatrix<0)./abs(minFitnessValue);

% if nargin == 1
%     animation = struct('cdata',zeros([width height 3],'uint8'),'colormap',cell(1,N));
% end

for i = 1:N
    
    if dim == 2
        % Frame creation
        contourf(ax,fitnessMatrix(:,:,i));
        axis(ax,'square');
        
        % %title(['Optimum values for range [', num2str(sIndex), ' ', num2str(eIndex), ']']);
        xlabel(ax,'lagging'); ylabel(ax,'leading');
        
        maxValue = max(max(fitnessMatrix(:,:,i)));
        minValue = min(min(fitnessMatrix(:,:,i)));
        rangeValue = max(maxValue, abs(minValue));
        caxis(ax,[-rangeValue rangeValue]);
        colorbar;
        
    elseif dim == 3
        
        surf(ax,fitnessMatrix(:,:,i));
        shading interp;
        %colormap(copper);
        axis(ax,'square');
        set(ax,'CameraPosition',[-800 1000 20]);
        
        xlabel(ax,'lagging'); ylabel(ax,'leading');
        
    end
    
    w = waitforbuttonpress;
    get(fig,'WindowButtonDown')
    
    drawnow;
    
%     if nargout == 1
%         % Save the frame into the animation
%         animation(i) = getframe(fig);
%     end
    
end

end
