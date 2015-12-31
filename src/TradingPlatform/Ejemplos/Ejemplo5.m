%% Ejemplo 5 - Optimizando el desempe�o de las m�quinas
%
% Aqu� se hace uso intensivo del mecanismo de optimizaci�n para sacar todo
% el provecho posible a las m�quinas de trading. Se prueban diferentes
% funciones de evaluaci�n y selecci�n, y se comparan los m�todos de
% optimizaci�n implementados. Tambi�n se comprueba el tiempo de ejecuci�n
% en virtud del n�mero de procesadores utilizados.
%


%% Crea un objeto de la clase DataSerie con la informaci�n burs�til
%
% Identificador:            DAI.F (DAIMLER N)
% Compresi�n en los datos:  Datos diarios
% Inicio del intervalo:     1 de enero de 2009
% Fin del intervalo:        1 de enero de 2011
%
ds = YahooDataSerie('dai.f','days',1,'2009-01-01','2011-01-01');

% Muestra el gr�fico con la informaci�n almacenada en el objeto
ds.plot();


%% Cruce de medias m�viles
%
% Aqu� poco importan los par�metros con que se inicialice el objeto. El
% objetivo que se persigue es el de calcular el resultado �ptimo para esta
% estrategia seg�n diferentes criterios y algoritmos.
%
mac = MovingAveragesCrossing(ds);

% Intervalo de entrenamiento comprendido entre las fechas
datestr(mac.DataSerie.DateTime(mac.TrainingSet))

% Intervalo de test comprendido entre las fechas
datestr(mac.DataSerie.DateTime(mac.TestSet))

% Valores de los par�metros 'Lead' y 'Lag' antes de la optimizaci�n
mac.Lead
mac.Lag

% Beneficio/p�rdida de la m�quina antes de la optimizaci�n
mac.ProfitLossTrainingSet
mac.ProfitLossTestSet


%% Optimizaci�n 1. Opciones predeterminadas
%
% Las opciones predeterminadas hacen que la optimizaci�n busque aquellos
% valores de los par�metros que mayor beneficio producen en el intervalo de
% entrenamiento.
%    Como sucede en este caso, un mejor resultado en el intervalo de
% entrenamiento no significa forzosamente un mejor resultado en el
% intervalo de test.
%
leadSet = 1:14;
lagSet = 7:28;

mac.optimize('Lead',leadSet,'Lag',lagSet);

% Valores de los par�metros 'Lead' y 'Lag' tras la optimizaci�n 1
mac.Lead
mac.Lag

% Beneficio/p�rdida de la m�quina tras la optimizaci�n
mac.ProfitLossTrainingSet
mac.ProfitLossTestSet


%% Optimizaci�n 2. M�nimo beneficio/p�rdida esperado
%
% Aplica la funci�n de evaluaci�n del m�nimo beneficio/p�rdida esperado
%
leadSet = 1:14;
lagSet = 7:28;

mac.optimize(@minProfitLossExpected,'Lead',leadSet,'Lag',lagSet);

% Valores de los par�metros 'Lead' y 'Lag' tras la optimizaci�n 1
mac.Lead
mac.Lag

% Beneficio/p�rdida de la m�quina tras la optimizaci�n
mac.ProfitLossTrainingSet
mac.ProfitLossTestSet


%% Optimizaci�n 3. Minimizar la p�rdida
%
% Aplica la funci�n de evaluaci�n de la p�rdida con la funci�n de selecci�n
% para minimizar
%
leadSet = 1:14;
lagSet = 7:28;

mac.optimize(@loss,@min,'Lead',leadSet,'Lag',lagSet);

% Valores de los par�metros 'Lead' y 'Lag' tras la optimizaci�n 1
mac.Lead
mac.Lag

% Beneficio/p�rdida de la m�quina tras la optimizaci�n
mac.ProfitLossTrainingSet
mac.ProfitLossTestSet


%% Optimizaci�n 4. M�nimo beneficio/p�rdida esperado y algoritmo gen�tico
%
% En este caso se utiliza una m�quina basada en el cruce de las tres medias
% m�viles para tener un espacio de b�squeda m�s grande sobre el que aplicar
% el algoritmo evolutivo.
%
fastSet = 1:15;
middleSet = 5:25;
slowSet = 15:40;

n = length(fastSet)*length(middleSet)*length(slowSet)

tma = ThreeMovingAverages(ds);

% Calcula el �ptimo con el algoritmo gen�tico y mide el tiempo
tic;
tma.optimize(@minProfitLossExpected,@max,@geneticAlgorithm, ...
    'Fast',fastSet,'Middle',middleSet,'Slow',slowSet);
toc

[ tma.Fast tma.Middle tma.Slow ]

% Calcula el �ptimo con el algoritmo exhaustivo y mide el tiempo
tic;
tma.optimize(@minProfitLossExpected,@max,@exhaustive, ...
    'Fast',fastSet,'Middle',middleSet,'Slow',slowSet);
toc

[ tma.Fast tma.Middle tma.Slow ]


%% Optimizaci�n 5. M�nimo beneficio/p�rdida esperado y algoritmo gen�tico (versi�n paralela)
%
% Se repite el experimento anterior pero utilizando dos procesadores.
%    El algoritmo de b�squeda exhaustiva es identico en su versi�n
% secuencial y su versi�n paralela ya que el paralelismo est� impl�cito al
% utilizar instrucciones especiales en MATLAB.
%
matlabpool open 2

fastSet = 1:15;
middleSet = 5:25;
slowSet = 15:40;

n = length(fastSet)*length(middleSet)*length(slowSet)

tma = ThreeMovingAverages(ds);

% Calcula el �ptimo con el algoritmo gen�tico y mide el tiempo
tic;
tma.optimize(@minProfitLossExpected,@max,{@geneticAlgorithm,2}, ...
    'Fast',fastSet,'Middle',middleSet,'Slow',slowSet);
toc

[ tma.Fast tma.Middle tma.Slow ]

% Calcula el �ptimo con el algoritmo exhaustivo y mide el tiempo
tic;
tma.optimize(@minProfitLossExpected,@max,@exhaustive, ...
    'Fast',fastSet,'Middle',middleSet,'Slow',slowSet);
toc

[ tma.Fast tma.Middle tma.Slow ]

matlabpool close
