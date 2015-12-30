
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

% Allowed properties
allowedProperties = nonDependentProperties;

% Copy allowed properties
for i = 1:length(allowedProperties)
    
    subsasgn(newObj, struct('type','.','subs',allowedProperties{i}), subsref(this, struct('type','.','subs',allowedProperties{i})));
    
end

end
