
function compare(engineSet)

fieldName = fieldnames(engineSet);
N = length(fieldName);
tag = cell(1,N);
fitness = zeros(1,N);
plTraining = zeros(1,N);
plTest = zeros(1,N);

for i = 1:N
    
    engine = getfield(engineSet, fieldName{i});
    
    tag{i} = class(engine);
    %tag{i} = fieldName{i};
    
    fitness(i) = engine.Fitness;
    
    plTraining(i) = engine.computeProfitLoss('training');
    
    plTest(i) = engine.computeProfitLoss('test');
    
end

for i = 1:N
    
    fprintf([ ...
        tag{i}, ...
        '\n fitness:   \t', num2str(fitness(i)), ...
        '\n plTraining:\t', num2str(plTraining(i)), ...
        '\n plTest:    \t', num2str(plTest(i)), ...
        '\n\n' ...
        ]);
    
end

end
