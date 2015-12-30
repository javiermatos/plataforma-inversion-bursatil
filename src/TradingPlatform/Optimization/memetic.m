
function bestIndexArray = memetic(fitnessFunction, domainSize)

% Parameters
nPopulations = max(1, matlabpool('size'));
nAgentsLevels = 4;
descendantsProportion = 0.35;

iterationTrigger = 50;
timeTrigger = Inf;
convergenceTrigger = 10;
migrationTrigger = 5;

% Apply memetic algorithm
population = memeticAlgorithm ...
    ( ...
        nPopulations, nAgentsLevels, descendantsProportion, ...
        iterationTrigger, timeTrigger, convergenceTrigger, migrationTrigger, ...
        @(agent) -fitnessFunction(agent), ...
        @() creationFunction(domainSize), ...
        @(agent1, agent2) crossFunction(agent1, agent2), ...
        @(agent) mutationFunction(agent, domainSize) ...
    );

% Get better agent
bestPopulationIndex = 1;
bestPopulationFitness = Inf;
for p = 1:length(population)
    
    currentPopulationFitness = population{p}.fitness(population{p}.hierarchyTree(1));
    
    if currentPopulationFitness < bestPopulationFitness
        bestPopulationIndex = p;
        bestPopulationFitness = currentPopulationFitness;
    end
    
end

bestIndexArray = population{bestPopulationIndex}.agent{population{bestPopulationIndex}.hierarchyTree(1)};

end

function agent = creationFunction(domainSize)

agent = round(rand(1,length(domainSize)).*domainSize);
agent(agent == 0) = 1;

end

function agent = crossFunction(agent1, agent2)

N = length(agent1);

crossIndex = randi(2,1,N);

agent = zeros(N,1);
agent(crossIndex==1) = agent1(crossIndex==1);
agent(crossIndex==2) = agent2(crossIndex==2);

end

function agent = mutationFunction(agent, domainSize)

nMutations = 1;

mutationIndex = randi(length(agent),1,nMutations);
mutationVector = creationFunction(domainSize);
agent(mutationIndex) = mutationVector(mutationIndex);

end

%% Memetic Algorithm
function population = memeticAlgorithm ...
    ( ...
        nPopulations, nAgentsLevels, descendantsProportion, ...
        iterationTrigger, timeTrigger, convergenceTrigger, migrationTrigger, ...
        fitnessFunction, creationFunction, crossFunction, mutationFunction...
    )

% Time counter
%startTime = tic;

%% Parameters specific to the algorithm
% Number of populations to be created for the process.
%nPopulations = 2;

% Number of levels in the hierarchy structure to store agents. There is a
% ternary tree that holds all the agents sorted by fitness.
%nAgentsLevels = 6;

% The number of agents in each population will be (3^nAgentsLevels-1)/2.
nAgents = (3^nAgentsLevels-1)/2;

% Ratio of descendants to be created in each generational step in
% comparison to the whole population.
%descendantsProportion = 0.75;

% Number of descendants created in each generation.
descendantsPerGeneration = round(descendantsProportion*nAgents);

% Maximum execution iterations before forcing exit. It is measured in
% generational steps.
%iterationTrigger = 100;

% Maximum execution time in seconds before forcing exit. Time will be
% checked before starting each generational step. If we specify a value X
% and computation for generational step N starts at time Y (with Y < X)
% then that generational step will be the last one to be computed. If this
% value is too small no generational step will be computed at all.
%timeTrigger = 1 * 60; % in seconds

% Maximum generational steps without best agent improvement of any
% population before forcing exit.
%convergenceTrigger = 25;

% Maximum generational steps without best agent improvement of any
% population before perform a migration. Migration consist on moving best
% agent of a non-convergent population to the population that is converging
% and does not show improvement of its best agent.
%migrationTrigger = floor(0.5*convergenceTrigger);


%% Parameters specific to the problem
% Fitness function that takes an agent and return the fitness.
%fitnessFunction

% Creation function that returns an agent to initialize the algorithm.
%creationFunction

% Cross function to cross agents.
%crossFunction

% Mutation function to mutate agents.
%mutationFunction


%% Initialize population structure
population = cell(nPopulations, 1);

parfor p = 1:nPopulations
    
    population{p}.agent = cell(nAgents, 1);
    population{p}.fitness = zeros(nAgents, 1);
    
    for a = 1:nAgents
        
        % Agent and agent's fitness
        agent = feval(creationFunction);
        fitness = feval(fitnessFunction,agent);
        
        population{p}.agent{a} = agent;
        population{p}.fitness(a) = fitness;
        
    end
    
    % Sort hierarchy tree based on fitness
    population{p}.hierarchyTree = sortHierarchyTree(randperm(nAgents)', population{p}.fitness);
    
end


%% Iteration loop
timeCounter = tic;
iterationCounter = 1;
convergenceCounter = ones(1,nPopulations);
migrationCounter = ones(1,nPopulations);
bestAgentIndex = zeros(1,nPopulations);

% Finish condition
while ...
    toc(timeCounter) < timeTrigger && ...
    iterationCounter < iterationTrigger && ...
    any(convergenceCounter < convergenceTrigger)

    %% Generational step
    parfor p = 1:nPopulations
    if convergenceCounter(p) < convergenceTrigger
    %for p = find(convergenceCounter < convergenceTrigger)
        
        for g = 1:descendantsPerGeneration
            
            % Choose parents from a node of the hierarchy tree. That node
            % will select an agent and then leader agent of the cluster
            % will be selected to perform cross.
            treeIndex = randi(nAgents-1)+1;
            
            % Perform cross of selected parents.
            descendant = feval(crossFunction, population{p}.agent{round(treeIndex/3)}, population{p}.agent{treeIndex});
            
            % Apply mutation operator to descendant.
            descendant = feval(mutationFunction, descendant);
            
            % Compute descendant's fitness
            descendantFitness = feval(fitnessFunction, descendant);
            
            % Replace worst parent if descendant is better.
            if descendantFitness < population{p}.fitness(population{p}.hierarchyTree(treeIndex))
                population{p}.agent{population{p}.hierarchyTree(treeIndex)} = descendant;
                population{p}.fitness(population{p}.hierarchyTree(treeIndex)) = descendantFitness;
            end
            
        end
        
        % Sort hierarchy tree based on fitness
        population{p}.hierarchyTree = sortHierarchyTree(population{p}.hierarchyTree, population{p}.fitness);
        
    %end %nPopulations
    end
    end % parfor version
    
    %% Migration process to avoid convergence
    % Migration condition:
    % There are 2 or more population that have not converged
    % There is a population that has started migration process
    if ...
        nnz(convergenceCounter < convergenceTrigger) >= 2 && ...   
        any((migrationCounter == migrationTrigger) & (convergenceCounter < convergenceTrigger))
        
        for p = find((migrationCounter == migrationTrigger) & (convergenceCounter < convergenceTrigger))
            
            % Set of populations from which we can get the agent
            sourcePopulationSet = find((convergenceCounter < convergenceTrigger) & [ ones(1,p-1) 0 ones(1,nPopulations-p) ]);
            
            % Index of population from which we will get the agent
            sourcePopulationIndex = sourcePopulationSet(randi(length(sourcePopulationSet)));
            
            % Substitute an agent of the population that will receive the
            % agent. We do not substitute best population agent.
            treeIndex = randi(nAgents-1)+1;
            
            % Source and destination index of agents
            sourceAgentIndex = population{sourcePopulationIndex}.hierarchyTree(1);
            destinationAgentIndex = population{p}.hierarchyTree(treeIndex);
            
            % Copy agent
            population{p}.agent{sourceAgentIndex} = population{sourcePopulationIndex}.agent{destinationAgentIndex};
            
            % Copy fitness
            population{p}.fitness(sourceAgentIndex) = population{sourcePopulationIndex}.fitness(destinationAgentIndex);
            
%             % Message
%             disp(['Migration from population ', num2str(sourcePopulationIndex), ' to population ', num2str(p), '.']);
            
            % Restart migration counter from current population
            migrationCounter(p) = 0;
            
        end
    
    end
    
    % Restart convergence counter if applicable
    for p = find(convergenceCounter < convergenceTrigger)
        
        % Population does not repeat best agent
        if population{p}.hierarchyTree(1) ~= bestAgentIndex(p)
            
            bestAgentIndex(p) = population{p}.hierarchyTree(1);
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
%         
%         disp(['Population ', num2str(p), ' has converged.']);
%         
%     end
    
end % Finish condition

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
% disp(['Execution time ', num2str(toc(startTime)), ' seconds.']);

end

%% sortHierarchyTree
function sortedTree = sortHierarchyTree(tree, fitness)

% Hierarchy tree is sorted from leafs to the root. Fitness will be sorted
% based on index in sortedTree.

sortedTree = tree;

% We repeat sort process if it is not sorted
flag = 1;

while flag == 1
    
    % At first we suppose that hierarchy tree is sorted
    flag = 0;

    for i = length(sortedTree)-1:-3:3

        [ value position ] = min(fitness(sortedTree(i-1:i+1)));
        if value < fitness(sortedTree(i/3))
            position = position - 2;
            sortedTree([i/3 i+position]) = sortedTree([i+position i/3]);
            
            % If we have changed anything maybe there is still things to
            % change so we repeat the loop
            flag = 1;
        end

    end

end

end
