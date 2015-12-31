%% Ejemplo 4 - Diseñando una máquina de trading compuesta
%
% Trata sobre la creación de una máquina de trading compuesta de varios
% niveles. Este es un ejemplo ilustrativo para resaltar la flexibilidad de
% las máquinas compuestas. Se advierte que las máquinas compuestas de
% varios niveles son construcciones demasiado artificiosas que carecen de
% sentido práctico.
%


%% Crea un objeto de la clase DataSerie con la información bursátil
%
% Identificador:            GE (General Electric Co.)
% Compresión en los datos:  Datos diarios
% Inicio del intervalo:     1 de enero de 2006
% Fin del intervalo:        1 de enero de 2010
%
ds = YahooDataSerie('ge','days',1,'2006-01-01','2010-01-01');

% Muestra el gráfico con la información almacenada en el objeto
ds.plot();


%% Cruce del índice de fuerza relativa
%
% Periodos del estocástico:     15
% Periodos de %K:               2
% Número de %D:                 5
%
stcc = StochasticCrossing(ds);
stcc.Samples = 15;
stcc.KSamples = 2;
stcc.DSamples = 5;
stcc.plot();


%% Cruce de tres medias móviles
%
% Periodos de la media móvil rápida:    5
% Periodos de la media móvil media:     9
% Periodos de la media móvil lenta:     13
%
tma = ThreeMovingAverages(ds,'e',5,9,13);
tma.plot();


%% Proporción relativa de las últimas n variaciones del precio
%
% Periodos:                     12
% Proporción mínima de subidas: 0.7
% Proporción mínima de bajadas: 0.7
%
lnr = LastNRatio(ds,15,1.05,1.05);
lnr.plot();


%% Máquina de intersección
i = Intersection(ds,stcc,tma,lnr);
i.plot();


% Dibuja las posiciones de todas las máquinas y la intersección
%
% Dibuja una tras otra todas las posiciones que adopta la máquina. Las tres
% primeras corresponden a las estrategias del conjunto y la cuarta a la
% intersección.
%
figure;

ah = subplot(4,1,1);
plotWrapper(stcc,@drawPosition, ah, 3);

ah = subplot(4,1,2);
plotWrapper(tma,@drawPosition, ah, 3);

ah = subplot(4,1,3);
plotWrapper(lnr,@drawPosition, ah, 3);

ah = subplot(4,1,4);
plotWrapper(i,@drawPosition, ah, 3);


%% Máquina de intersección
ei = ElitistIntersection(ds,stcc,tma,lnr);

% Deshabilita la primera estrategia del conjunto, la relativa al cruce del
% estocástico
ei.Selection(1) = 0;

ei.plot();


% Dibuja las posiciones de todas las máquinas y la intersección elitista
%
% Dibuja una tras otra todas las posiciones que adopta la máquina. Las tres
% primeras corresponden a las estrategias del conjunto y la cuarta a la
% intersección elitista.
%
figure;

ah = subplot(4,1,1);
plotWrapper(stcc,@drawPosition, ah, 3);

ah = subplot(4,1,2);
plotWrapper(tma,@drawPosition, ah, 3);

ah = subplot(4,1,3);
plotWrapper(lnr,@drawPosition, ah, 3);

ah = subplot(4,1,4);
plotWrapper(ei,@drawPosition, ah, 3);


%% Máquina de votación
v = Voting(ds,stcc,tma,lnr);
v.plot();


% Dibuja las posiciones de todas las máquinas y la votación
%
% Dibuja una tras otra todas las posiciones que adopta la máquina. Las tres
% primeras corresponden a las estrategias del conjunto y la cuarta a la
% votación: se requieren un mínimo de dos votos como para adoptar una
% posición.
%
figure;

ah = subplot(4,1,1);
plotWrapper(stcc,@drawPosition, ah, 3);

ah = subplot(4,1,2);
plotWrapper(tma,@drawPosition, ah, 3);

ah = subplot(4,1,3);
plotWrapper(lnr,@drawPosition, ah, 3);

ah = subplot(4,1,4);
plotWrapper(v,@drawPosition, ah, 3);


%% Cruce de las medias móviles
%
% Modo:                                 Exponencial
% Periodos de la media móvil rápida:    5
% Periodos de la media móvil lenta:     10
%
mac = MovingAveragesCrossing(ds,'e',5,10);
mac.plot();


%% Máquina fragmentada
%
% Tamaño conjunto entrenamiento:    30
% Tamaño conjunto test:             15
%
f = Fragmented(mac,30,15);

% Asigna valores aleatorios de los parámetros 'Lead' y 'Lag' a cada uno de
% los fragmentos
for j = 1:length(f.Fragment)
    
    f.Fragment(j).Lead = randi(9)+1;
    f.Fragment(j).Lag = randi(10)+10;
    
end

f.plot();


% Dibuja las posiciones de la máquina basada en el cruce de medias móviles
% (recuadro superior) y su versión fragmentada (recuadro inferior)
figure;

ah = subplot(2,1,1);
plotWrapper(mac,@drawPosition, ah, 3);

ah = subplot(2,1,2);
plotWrapper(f,@drawPosition, ah, 3);
