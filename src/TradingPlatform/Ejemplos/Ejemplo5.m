%% Ejemplo 5 - Optimizando el desempeño de las máquinas
%
% Aquí se hace uso intensivo del mecanismo de optimización para sacar todo
% el provecho posible a las máquinas de trading. Se prueban diferentes
% funciones de evaluación y selección, y se comparan los métodos de
% optimización implementados. También se comprueba el tiempo de ejecución
% en virtud del número de procesadores utilizados.
%


%% Crea un objeto de la clase DataSerie con la información bursátil
%
% Identificador:            DAI.F (DAIMLER N)
% Compresión en los datos:  Datos diarios
% Inicio del intervalo:     1 de enero de 2009
% Fin del intervalo:        1 de enero de 2011
%
ds = YahooDataSerie('dai.f','days',1,'2009-01-01','2011-01-01');

% Muestra el gráfico con la información almacenada en el objeto
ds.plot();


%% Cruce de medias móviles
%
% Aquí poco importan los parámetros con que se inicialice el objeto. El
% objetivo que se persigue es el de calcular el resultado óptimo para esta
% estrategia según diferentes criterios y algoritmos.
%
mac = MovingAveragesCrossing(ds);

% Intervalo de entrenamiento comprendido entre las fechas
datestr(mac.DataSerie.DateTime(mac.TrainingSet))

% Intervalo de test comprendido entre las fechas
datestr(mac.DataSerie.DateTime(mac.TestSet))

% Valores de los parámetros 'Lead' y 'Lag' antes de la optimización
mac.Lead
mac.Lag

% Beneficio/pérdida de la máquina antes de la optimización
mac.ProfitLossTrainingSet
mac.ProfitLossTestSet


%% Optimización 1. Opciones predeterminadas
%
% Las opciones predeterminadas hacen que la optimización busque aquellos
% valores de los parámetros que mayor beneficio producen en el intervalo de
% entrenamiento.
%    Como sucede en este caso, un mejor resultado en el intervalo de
% entrenamiento no significa forzosamente un mejor resultado en el
% intervalo de test.
%
leadSet = 1:14;
lagSet = 7:28;

mac.optimize('Lead',leadSet,'Lag',lagSet);

% Valores de los parámetros 'Lead' y 'Lag' tras la optimización 1
mac.Lead
mac.Lag

% Beneficio/pérdida de la máquina tras la optimización
mac.ProfitLossTrainingSet
mac.ProfitLossTestSet


%% Optimización 2. Mínimo beneficio/pérdida esperado
%
% Aplica la función de evaluación del mínimo beneficio/pérdida esperado
%
leadSet = 1:14;
lagSet = 7:28;

mac.optimize(@minProfitLossExpected,'Lead',leadSet,'Lag',lagSet);

% Valores de los parámetros 'Lead' y 'Lag' tras la optimización 1
mac.Lead
mac.Lag

% Beneficio/pérdida de la máquina tras la optimización
mac.ProfitLossTrainingSet
mac.ProfitLossTestSet


%% Optimización 3. Minimizar la pérdida
%
% Aplica la función de evaluación de la pérdida con la función de selección
% para minimizar
%
leadSet = 1:14;
lagSet = 7:28;

mac.optimize(@loss,@min,'Lead',leadSet,'Lag',lagSet);

% Valores de los parámetros 'Lead' y 'Lag' tras la optimización 1
mac.Lead
mac.Lag

% Beneficio/pérdida de la máquina tras la optimización
mac.ProfitLossTrainingSet
mac.ProfitLossTestSet


%% Optimización 4. Mínimo beneficio/pérdida esperado y algoritmo genético
%
% En este caso se utiliza una máquina basada en el cruce de las tres medias
% móviles para tener un espacio de búsqueda más grande sobre el que aplicar
% el algoritmo evolutivo.
%
fastSet = 1:15;
middleSet = 5:25;
slowSet = 15:40;

n = length(fastSet)*length(middleSet)*length(slowSet)

tma = ThreeMovingAverages(ds);

% Calcula el óptimo con el algoritmo genético y mide el tiempo
tic;
tma.optimize(@minProfitLossExpected,@max,@geneticAlgorithm, ...
    'Fast',fastSet,'Middle',middleSet,'Slow',slowSet);
toc

[ tma.Fast tma.Middle tma.Slow ]

% Calcula el óptimo con el algoritmo exhaustivo y mide el tiempo
tic;
tma.optimize(@minProfitLossExpected,@max,@exhaustive, ...
    'Fast',fastSet,'Middle',middleSet,'Slow',slowSet);
toc

[ tma.Fast tma.Middle tma.Slow ]


%% Optimización 5. Mínimo beneficio/pérdida esperado y algoritmo genético (versión paralela)
%
% Se repite el experimento anterior pero utilizando dos procesadores.
%    El algoritmo de búsqueda exhaustiva es identico en su versión
% secuencial y su versión paralela ya que el paralelismo está implícito al
% utilizar instrucciones especiales en MATLAB.
%
matlabpool open 2

fastSet = 1:15;
middleSet = 5:25;
slowSet = 15:40;

n = length(fastSet)*length(middleSet)*length(slowSet)

tma = ThreeMovingAverages(ds);

% Calcula el óptimo con el algoritmo genético y mide el tiempo
tic;
tma.optimize(@minProfitLossExpected,@max,{@geneticAlgorithm,2}, ...
    'Fast',fastSet,'Middle',middleSet,'Slow',slowSet);
toc

[ tma.Fast tma.Middle tma.Slow ]

% Calcula el óptimo con el algoritmo exhaustivo y mide el tiempo
tic;
tma.optimize(@minProfitLossExpected,@max,@exhaustive, ...
    'Fast',fastSet,'Middle',middleSet,'Slow',slowSet);
toc

[ tma.Fast tma.Middle tma.Slow ]

matlabpool close
