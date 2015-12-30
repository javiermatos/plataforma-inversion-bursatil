
function newObj = clone(this)

% Create an empty instance of the class
newObj = feval(class(this), this.AlgoTraderBase);

% Non-dependent properties
metaClass = metaclass(this);

metaClassProperties = findobj([metaClass.Properties{:}],'Dependent',false);

N = length(metaClassProperties);
nonDependentProperties = cell(N, 1);
for i = 1:N
    nonDependentProperties{i} = metaClassProperties(i).Name;
end

% Banned properties
bannedProperties = {'DataSerie' 'AlgoTraderBase' 'Fragment'};

% Allowed properties
allowedProperties = nonDependentProperties(~ismember(nonDependentProperties, bannedProperties));

% Copy allowed properties
for i = 1:length(allowedProperties)
    
    subsasgn(newObj, struct('type','.','subs',allowedProperties{i}), subsref(this, struct('type','.','subs',allowedProperties{i})));
    
end

% Copy fragments
N = length(this.Fragment);
newObj.Fragment = newObj.AlgoTraderBase.empty(0, N);
for i = 1:N
    
    newObj.Fragment(i) = this.Fragment(i).clone();
    
end

end
