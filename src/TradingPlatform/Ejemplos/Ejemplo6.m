%% Ejemplo 6 - Analizando los resultados
%
% El análisis de resultados es parte vital de una herramienta destinada al
% uso en investigación. El ejemplo consiste en el análisis de los
% resultados provistos por algunas máquinas de trading: se observan las
% relaciones entre los valores de los parámetros que mejores resultados
% proporcionan, se calculan los estadísticos para resumir con ellos el
% comportamiento de la máquina, se muestran en un histograma las
% configuraciones de la máquina de trading agrupadas de acuerdo a su
% desempeño...
%


%% Crea un objeto de la clase DataSerie con la información bursátil
%
% Identificador:            TEF.MC (Telefónica SA)
% Compresión en los datos:  Datos diarios
% Inicio del intervalo:     1 de enero de 2010
% Fin del intervalo:        1 de enero de 2011
%
ds = YahooDataSerie('tef.mc','days',1,'2010-01-01','2011-01-01');

% Muestra el gráfico con la información almacenada en el objeto
ds.plot();


%% Cruce de las medias móviles
%
% Modo:                   Exponencial
% Número de periodos:     30
%
mac = MovingAveragesCrossing(ds);

leadSet = 1:21;
lagSet = 7:35;


%% Espacio de búsqueda 1. Función de evaluación profitLoss
%
% Muestra el espacio de búsqueda asociado
%
mac.plotSearchSpace123(@profitLoss,'Lead',leadSet,'Lag',lagSet);


%% Espacio de búsqueda 2. Función de evaluación minProfitLossExpected
%
% Muestra el espacio de búsqueda asociado
%
mac.plotSearchSpace123(@minProfitLossExpected,'Lead',leadSet,'Lag',lagSet);


%% Espacio de búsqueda 3. Función de evaluación loss
%
% Muestra el espacio de búsqueda asociado
%
mac.plotSearchSpace123(@loss,'Lead',leadSet,'Lag',lagSet);


%% Histograma 1. Función de evaluación profitLoss
%
% Muestra el histograma asociado.
%    En este caso y por tratarse de la función de evaluación del
% beneficio/pérdida se aprecia que la mayoría de máquinas rinde por debajo
% de la unidad, lo cual es un signo de que casi con seguridad utilizar esta
% máquina hará que se pierda dinero en la inversión.
%
[minimo, maximo, media, desviacion] ...
    = mac.fitnessStatistics(@profitLoss,'Lead',leadSet,'Lag',lagSet);


%% Histograma 2. Función de evaluación minProfitLossExpected
%
% Muestra el histograma asociado.
%
[minimo, maximo, media, desviacion] ...
    = mac.fitnessStatistics(@minProfitLossExpected,'Lead',leadSet,'Lag',lagSet);


%% Histograma 3. Función de evaluación loss
%
% Muestra el histograma asociado.
%
[minimo, maximo, media, desviacion] ...
    = mac.fitnessStatistics(@loss,'Lead',leadSet,'Lag',lagSet);
