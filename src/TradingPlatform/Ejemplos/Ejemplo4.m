%% Ejemplo 4 - Dise�ando una m�quina de trading compuesta
%
% Trata sobre la creaci�n de una m�quina de trading compuesta de varios
% niveles. Este es un ejemplo ilustrativo para resaltar la flexibilidad de
% las m�quinas compuestas. Se advierte que las m�quinas compuestas de
% varios niveles son construcciones demasiado artificiosas que carecen de
% sentido pr�ctico.
%


%% Crea un objeto de la clase DataSerie con la informaci�n burs�til
%
% Identificador:            GE (General Electric Co.)
% Compresi�n en los datos:  Datos diarios
% Inicio del intervalo:     1 de enero de 2006
% Fin del intervalo:        1 de enero de 2010
%
ds = YahooDataSerie('ge','days',1,'2006-01-01','2010-01-01');

% Muestra el gr�fico con la informaci�n almacenada en el objeto
ds.plot();


%% Cruce del �ndice de fuerza relativa
%
% Periodos del estoc�stico:     15
% Periodos de %K:               2
% N�mero de %D:                 5
%
stcc = StochasticCrossing(ds);
stcc.Samples = 15;
stcc.KSamples = 2;
stcc.DSamples = 5;
stcc.plot();


%% Cruce de tres medias m�viles
%
% Periodos de la media m�vil r�pida:    5
% Periodos de la media m�vil media:     9
% Periodos de la media m�vil lenta:     13
%
tma = ThreeMovingAverages(ds,'e',5,9,13);
tma.plot();


%% Proporci�n relativa de las �ltimas n variaciones del precio
%
% Periodos:                     12
% Proporci�n m�nima de subidas: 0.7
% Proporci�n m�nima de bajadas: 0.7
%
lnr = LastNRatio(ds,15,1.05,1.05);
lnr.plot();


%% M�quina de intersecci�n
i = Intersection(ds,stcc,tma,lnr);
i.plot();


% Dibuja las posiciones de todas las m�quinas y la intersecci�n
%
% Dibuja una tras otra todas las posiciones que adopta la m�quina. Las tres
% primeras corresponden a las estrategias del conjunto y la cuarta a la
% intersecci�n.
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


%% M�quina de intersecci�n
ei = ElitistIntersection(ds,stcc,tma,lnr);

% Deshabilita la primera estrategia del conjunto, la relativa al cruce del
% estoc�stico
ei.Selection(1) = 0;

ei.plot();


% Dibuja las posiciones de todas las m�quinas y la intersecci�n elitista
%
% Dibuja una tras otra todas las posiciones que adopta la m�quina. Las tres
% primeras corresponden a las estrategias del conjunto y la cuarta a la
% intersecci�n elitista.
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


%% M�quina de votaci�n
v = Voting(ds,stcc,tma,lnr);
v.plot();


% Dibuja las posiciones de todas las m�quinas y la votaci�n
%
% Dibuja una tras otra todas las posiciones que adopta la m�quina. Las tres
% primeras corresponden a las estrategias del conjunto y la cuarta a la
% votaci�n: se requieren un m�nimo de dos votos como para adoptar una
% posici�n.
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


%% Cruce de las medias m�viles
%
% Modo:                                 Exponencial
% Periodos de la media m�vil r�pida:    5
% Periodos de la media m�vil lenta:     10
%
mac = MovingAveragesCrossing(ds,'e',5,10);
mac.plot();


%% M�quina fragmentada
%
% Tama�o conjunto entrenamiento:    30
% Tama�o conjunto test:             15
%
f = Fragmented(mac,30,15);

% Asigna valores aleatorios de los par�metros 'Lead' y 'Lag' a cada uno de
% los fragmentos
for j = 1:length(f.Fragment)
    
    f.Fragment(j).Lead = randi(9)+1;
    f.Fragment(j).Lag = randi(10)+10;
    
end

f.plot();


% Dibuja las posiciones de la m�quina basada en el cruce de medias m�viles
% (recuadro superior) y su versi�n fragmentada (recuadro inferior)
figure;

ah = subplot(2,1,1);
plotWrapper(mac,@drawPosition, ah, 3);

ah = subplot(2,1,2);
plotWrapper(f,@drawPosition, ah, 3);
