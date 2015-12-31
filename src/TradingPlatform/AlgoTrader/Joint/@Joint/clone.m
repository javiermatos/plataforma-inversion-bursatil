
function newObj = clone(this)

% Create an empty instance of the class
newObj = feval(class(this), this.DataSerie);

% Non-dependent properties
metaClass = metaclass(this);

metaClassProperties = findobj([metaClass.Properties{:}],'Dependent',false);

N = length(metaClassProperties);
nonDependentProperties = cell(N, 1);
for i = 1:N
    nonDependentProperties{i} = metaClassProperties(i).Name;
end

% Excluded properties
classProperties = properties(class(this));
objectProperties = properties(this);
excludedProperties = objectProperties(~ismember(objectProperties, classProperties));
excludedProperties = [excludedProperties' 'DataSerie' 'InnerAlgoTrader' 'DynamicProperties']';

% Allowed properties
includedProperties = nonDependentProperties(~ismember(nonDependentProperties, excludedProperties));

% Copy allowed properties
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

% Add to new object's set
newObj.add(this.InnerAlgoTrader{:});

end
