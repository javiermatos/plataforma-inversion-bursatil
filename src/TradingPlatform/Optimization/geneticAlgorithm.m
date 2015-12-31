
function bestIndexArray = geneticAlgorithm( ...
    selectionFunction, fitnessFunction, searchSpaceSize, ...
    nPopulations, nIndividuals, descendantsRatio, ...
    timeTrigger, iterationTrigger, convergenceTrigger, migrationTrigger)

% Parameters
if ~exist('nPopulations','var'); nPopulations = 1; end % max(1, matlabpool('size'));
if ~exist('nIndividuals','var'); nIndividuals = 40; end
if ~exist('descendantsRatio','var'); descendantsRatio = 0.5; end

if ~exist('timeTrigger','var'); timeTrigger = 60; end
if ~exist('iterationTrigger','var'); iterationTrigger = Inf; end
if ~exist('convergenceTrigger','var'); convergenceTrigger = 20; end
if ~exist('migrationTrigger','var'); migrationTrigger = 5; end

% Apply selection function
if strcmp(func2str(@max),func2str(selectionFunction))
    fitnessFunctionExtended = @(individual) -fitnessFunction(individual);
else
    fitnessFunctionExtended = @(individual) fitnessFunction(individual);
end    

% Apply memetic algorithm
population = geneticAlgorithm_ ...
    ( ...
        nPopulations, nIndividuals, descendantsRatio, ...
        iterationTrigger, timeTrigger, convergenceTrigger, migrationTrigger, ...
        @(individual) fitnessFunctionExtended(individual), ...
        @() creationFunction(searchSpaceSize), ...
        @(individual1, individual2) crossFunction(individual1, individual2), ...
        @(individual) mutationFunction(individual, searchSpaceSize) ...
    );

% Get better individual
populationStructure = [population{:}];
populationFitness = [populationStructure.fitness];
populationFitness = populationFitness(1,:);

[~, bestPopulationIndex] = min(populationFitness);

bestIndexArray = population{bestPopulationIndex}.individual{1};

% Slower method
% bestPopulationIndex = 1;
% bestPopulationFitness = Inf;
% for p = 1:length(population)
%     
%     currentPopulationFitness = population{p}.fitness(1);
%     
%     if currentPopulationFitness < bestPopulationFitness
%         bestPopulationIndex = p;
%         bestPopulationFitness = currentPopulationFitness;
%     end
%     
% end
% 
% bestIndexArray = population{bestPopulationIndex}.individual{1};

end


function individual = creationFunction(searchSpaceSize)

individual = ceil(rand(1,length(searchSpaceSize)).*searchSpaceSize);

end


function individual = crossFunction(individual1, individual2)

N = length(individual1);

crossIndex = rand(1,N)<0.5;

individual = individual1;
individual(crossIndex) = individual2(crossIndex);

end


function individual = mutationFunction(individual, searchSpaceSize)

% Mutation probability
mutationProbability = 0.1;

mutationIndex = rand(1,length(searchSpaceSize))<mutationProbability;

if any(mutationIndex)
    mutation = creationFunction(searchSpaceSize);
    individual(mutationIndex) = mutation(mutationIndex);
end

end


%% Genetic Algorithm
function population = geneticAlgorithm_ ...
    ( ...
        nPopulations, nIndividuals, descendantsRatio, ...
        iterationTrigger, timeTrigger, convergenceTrigger, migrationTrigger, ...
        fitnessFunction, creationFunction, crossFunction, mutationFunction...
    )

% Time counter
timeCounter = tic;

%% Parameters specific to the algorithm
% Number of populations to be created for the process.
%nPopulations = 2;

% The number of individuals in each population.
%nIndividuals = 30;

% Ratio of descendants to be created in each generational step in
% comparison to the whole population.
%descendantsRatio = 0.75;

% Number of descendants created in each generation.
descendantsPerGeneration = round(descendantsRatio*nIndividuals);

% Maximum execution iterations before forcing exit. It is measured in
% generational steps.
%iterationTrigger = 100;

% Maximum execution time in seconds before forcing exit. Time will be
% checked before starting each generational step. If we specify a value X
% and computation for generational step N starts at time Y (with Y < X)
% then that generational step will be the last one to be computed. If this
% value is too small no generational step will be computed at all.
%timeTrigger = 1 * 60; % in seconds

% Maximum generational steps without best individual improvement of any
% population before forcing exit.
%convergenceTrigger = 25;

% Maximum generational steps without best individual improvement of any
% population before perform a migration. Migration consist on moving best
% individual of a non-convergent population to the population that is
% converging and does not show improvement of its best individual.
%migrationTrigger = floor(0.5*convergenceTrigger);


%% Parameters specific to the problem
% Fitness function that takes an individual and return the fitness.
%fitnessFunction

% Creation function that returns an individual to initialize the algorithm.
%creationFunction

% Cross function to cross individuals.
%crossFunction

% Mutation function to mutate individuals.
%mutationFunction


%% Initialize population structure
population = cell(nPopulations, 1);

parfor p = 1:nPopulations
    
    population{p}.individual = cell(nIndividuals, 1);
    population{p}.fitness = zeros(nIndividuals, 1);
    
    for a = 1:nIndividuals
        
        % Agent and individuals fitness
        individual = feval(creationFunction);
        fitness = feval(fitnessFunction,individual);
        
        population{p}.individual{a} = individual;
        population{p}.fitness(a) = fitness;
        
    end
    
    % Sort population based on fitness
    [~, sortedIndexes] = sort(population{p}.fitness,'ascend');
    population{p}.individual = population{p}.individual(sortedIndexes,:);
    population{p}.fitness = population{p}.fitness(sortedIndexes);
    
end


%% Iteration loop
%timeCounter = tic;
iterationCounter = 1;
convergenceCounter = ones(1,nPopulations);
migrationCounter = ones(1,nPopulations);
bestAgentFitness = Inf*ones(1,nPopulations);

% Finish condition
while ...
    toc(timeCounter) < timeTrigger && ...
    iterationCounter < iterationTrigger && ...
    any(convergenceCounter < convergenceTrigger)

    %% Generational step
    parfor p = 1:nPopulations
    if convergenceCounter(p) < convergenceTrigger
        
        for g = 1:descendantsPerGeneration
            
            % Parents
            parentIndex = randi(nIndividuals,1,2);
            
            % Cross
            descendant = feval(crossFunction, population{p}.individual{parentIndex(1)}, population{p}.individual{parentIndex(2)});
            
            % Mutation
            descendant = feval(mutationFunction, descendant);
            
            % Fitness
            descendantFitness = feval(fitnessFunction, descendant);
            
            % Replace worst parent if descendant is better
            [worstParentFitness, worstParentIndex] = max(population{p}.fitness(parentIndex));
            if descendantFitness < worstParentFitness
                population{p}.individual{parentIndex(worstParentIndex)} = descendant;
                population{p}.fitness(parentIndex(worstParentIndex)) = descendantFitness;
            end
            
        end
        
        % Sort population based on fitness
        [~, sortedIndexes] = sort(population{p}.fitness,'ascend');
        population{p}.individual = population{p}.individual(sortedIndexes,:);
        population{p}.fitness = population{p}.fitness(sortedIndexes);
        
    end
    end % parfor version
    
    %% Migration process to avoid convergence
    % Migration condition:
    % There are more populations than just one and migrationTrigger
    % condition was met.
    migrationLogicalIndex = ( ...
        (migrationCounter == migrationTrigger) & ...
        (convergenceCounter < convergenceTrigger));
    
    if nPopulations > 1 && any(migrationLogicalIndex)
        
        for p = find(migrationLogicalIndex)
            
            % Set of populations from which we can get the individual
            sourcePopulationSet = [1:p-1 p+1:nPopulations];
            
            % Index of population from which we will get the individual
            sourcePopulationIndex = sourcePopulationSet(randi(nPopulations-1,1,1));
            
            % Get the best individual from source population
            sourceAgentIndex = 1;
            
            % Substitute an individual of the population that will receive
            % the individual. We do not substitute best population
            % individual.
            destinationAgentIndex = randi(nIndividuals-1,1,1)+1;
            
            % Copy individual
            population{p}.individual{destinationAgentIndex} = population{sourcePopulationIndex}.individual{sourceAgentIndex};
            
            % Copy fitness
            population{p}.fitness(destinationAgentIndex) = population{sourcePopulationIndex}.fitness(sourceAgentIndex);
            
%             % Message
%             disp(['Migration from population ', num2str(sourcePopulationIndex), ' to population ', num2str(p), '.']);
            
            % Restart migration counter from current population
            migrationCounter(p) = 0;
            
        end
    
    end
    
    % Restart convergence counter if applicable
    for p = find(convergenceCounter < convergenceTrigger)
        
        % Population does not repeat best individual
        if population{p}.fitness(1) ~= bestAgentFitness(p)
            
            bestAgentFitness(p) = population{p}.fitness(1);
            convergenceCounter(p) = 0;
            migrationCounter(p) = 0;
            
        end
        
    end
    
    % Update counters
    iterationCounter = iterationCounter + 1;
    convergenceCounter = convergenceCounter + 1;
    migrationCounter = migrationCounter + 1;
    
%     % Show a message for a population that has converged
%     for p = find(convergenceCounter == convergenceTrigger)
%         disp(['Population ', num2str(p), ' has converged.']);
%     end
    
end % Termination condition

% % Information about termination cause. We use different if conditions
% % because more than a condition could be the cause of the termination.
% if toc(timeCounter) >= timeTrigger
%     disp('Finished because of timeTrigger condition.');
% end
% if iterationCounter >= iterationTrigger
%     disp('Finished because of iterationTrigger condition.');
% end
% if all(convergenceCounter >= convergenceTrigger)
%     disp('Finished because of convergenceTrigger condition.');
% end
% 
% disp(['Execution time was ', num2str(toc(timeCounter)), ' seconds.']);

end
