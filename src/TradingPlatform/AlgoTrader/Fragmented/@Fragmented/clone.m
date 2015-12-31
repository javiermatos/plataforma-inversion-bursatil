
function newObj = clone(this)

% Create an empty instance of the class
newObj = feval(class(this), this.InnerAlgoTrader);

% Non-dependent properties
metaClass = metaclass(this);

metaClassProperties = findobj([metaClass.Properties{:}],'Dependent',false);

N = length(metaClassProperties);
nonDependentProperties = cell(N, 1);
for i = 1:N
    nonDependentProperties{i} = metaClassProperties(i).Name;
end

% Excluded properties
excludedProperties = {'DataSerie' 'InnerAlgoTrader' 'Fragment'};

% Included properties
includedProperties = nonDependentProperties(~ismember(nonDependentProperties, excludedProperties));

% Copy included properties
for i = 1:length(includedProperties)
    
    subsasgn( ...
        newObj, ...
        struct( ...
            'type','.', ...
            'subs',includedProperties{i} ...
            ), ...
        subsref( ...
            this, ...
            struct( ...
                'type','.', ...
                'subs',includedProperties{i} ...
                ) ...
            ) ...
        );
    
end

% Copy fragments
N = length(this.Fragment);
newObj.Fragment = newObj.InnerAlgoTrader.empty(0, N);
for i = 1:N
    
    newObj.Fragment(i) = this.Fragment(i).clone();
    
end

end
