
function updateDynamicProperties(algoTrader, src, event)

removeDynamicProperties(algoTrader);
addDynamicProperties(algoTrader);

end


function removeDynamicProperties(algoTrader)

for i = 1:length(algoTrader.DynamicProperties)
    
    delete(algoTrader.DynamicProperties(i));
    
end

algoTrader.DynamicProperties = [];

end


function addDynamicProperties(algoTrader)

excludedProperties = properties('AlgoTrader');

for i = 1:length(algoTrader.InnerAlgoTrader)
    
    metaClass = metaclass(algoTrader.InnerAlgoTrader{i});
    
    metaClassProperty = findobj([metaClass.Properties{:}]);

    N = length(metaClassProperty);
    propertyName = cell(N, 1);
    for j = 1:N
        propertyName{j} = metaClassProperty(j).Name;
    end
    
    propertyName = propertyName(~ismember(propertyName, excludedProperties));
    
    for k = 1:length(propertyName)
        
        %p = algoTrader.addprop([propertyName{k} '_' num2str(i)]);
        p = algoTrader.addprop([propertyName{k} num2str(i)]);
        
        % Get and set methods for dynamic property
        p.SetMethod = @(obj, val) innerSet(obj, i, propertyName(k), val);
        p.GetMethod = @(obj) innerGet(obj, i, propertyName(k));
        
        % Do not save property when saving object
        p.Transient = true;
        
        algoTrader.DynamicProperties = [ algoTrader.DynamicProperties ; p ];
        
    end
    
end

end


function value = innerGet(algoTrader, index, propertyName)

value = subsref( ...
    algoTrader.InnerAlgoTrader{index}, ...
    struct( ...
        'type','.', ...
        'subs',propertyName ...
        ) ...
    );

end


function innerSet(algoTrader, index, propertyName, value)

subsasgn( ...
    algoTrader.InnerAlgoTrader{index}, ...
    struct( ...
        'type','.', ...
        'subs',propertyName), ...
    value ...
    );

end
