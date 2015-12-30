
function indexArray = random(fitnessFunction, domainSize)

indexArray = ones(1, length(domainSize))+round(rand(1,length(domainSize)).*(domainSize-1));

end
