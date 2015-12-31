
function prettySize(figureHandle)

% pretty figure size
scrsz = get(0,'ScreenSize');
set(figureHandle,'Position',[scrsz(3)/4 scrsz(4)/4 960 540]);
%set(figureHandle,'Position',[scrsz(3)/4 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);

end
