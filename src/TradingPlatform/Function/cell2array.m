
function array = cell2array(cell)

if isempty(cell)
    array = [];
    return;
end

% Find first single item (if it exists)
firstSingleIndex = findFirstSingleIndex(cell);

% No single item in cell
if firstSingleIndex == 0
    
    %error('Error in cell2array.');
    
    [~, index] = min(abs(cell{1}-mode(cell2mat(cell(:)))));
    cell{1} = cell{1}(index);
    
    firstSingleIndex = 1;
    
end

array = zeros(1, length(cell));
array(firstSingleIndex) = cell{firstSingleIndex};

for i = firstSingleIndex-1:-1:1
    if length(cell{i}) > 1
        [ ~, index ] = min(abs(cell{i}-array(i+1)));
        array(i) = cell{i}(index);
    else
        array(i) = cell{i};
    end
end

for i = firstSingleIndex+1:length(cell)
    if length(cell{i}) > 1
        [ ~, index ] = min(abs(cell{i}-array(i-1)));
        array(i) = cell{i}(index);
    else
        array(i) = cell{i};
    end
end

% % Plot samples
% figure;
% hold on;
% for i = 1:length(cell)
%     plot(i*ones(1, length(cell{i})), cell{i}, '.b');
% end
% plot(array, '.r');
% hold off;

end

function index = findFirstSingleIndex(cell)

index = 0;
for i = 1:length(cell)
    if length(cell{i}) == 1
        index = i;
        break;
    end
end

end
