%% Ejemplo 6 - Analizando los resultados
%
% El an�lisis de resultados es parte vital de una herramienta destinada al
% uso en investigaci�n. El ejemplo consiste en el an�lisis de los
% resultados provistos por algunas m�quinas de trading: se observan las
% relaciones entre los valores de los par�metros que mejores resultados
% proporcionan, se calculan los estad�sticos para resumir con ellos el
% comportamiento de la m�quina, se muestran en un histograma las
% configuraciones de la m�quina de trading agrupadas de acuerdo a su
% desempe�o...
%


%% Crea un objeto de la clase DataSerie con la informaci�n burs�til
%
% Identificador:            TEF.MC (Telef�nica SA)
% Compresi�n en los datos:  Datos diarios
% Inicio del intervalo:     1 de enero de 2010
% Fin del intervalo:        1 de enero de 2011
%
ds = YahooDataSerie('tef.mc','days',1,'2010-01-01','2011-01-01');

% Muestra el gr�fico con la informaci�n almacenada en el objeto
ds.plot();


%% Cruce de las medias m�viles
%
% Modo:                   Exponencial
% N�mero de periodos:     30
%
mac = MovingAveragesCrossing(ds);

leadSet = 1:21;
lagSet = 7:35;


%% Espacio de b�squeda 1. Funci�n de evaluaci�n profitLoss
%
% Muestra el espacio de b�squeda asociado
%
mac.plotSearchSpace123(@profitLoss,'Lead',leadSet,'Lag',lagSet);


%% Espacio de b�squeda 2. Funci�n de evaluaci�n minProfitLossExpected
%
% Muestra el espacio de b�squeda asociado
%
mac.plotSearchSpace123(@minProfitLossExpected,'Lead',leadSet,'Lag',lagSet);


%% Espacio de b�squeda 3. Funci�n de evaluaci�n loss
%
% Muestra el espacio de b�squeda asociado
%
mac.plotSearchSpace123(@loss,'Lead',leadSet,'Lag',lagSet);


%% Histograma 1. Funci�n de evaluaci�n profitLoss
%
% Muestra el histograma asociado.
%    En este caso y por tratarse de la funci�n de evaluaci�n del
% beneficio/p�rdida se aprecia que la mayor�a de m�quinas rinde por debajo
% de la unidad, lo cual es un signo de que casi con seguridad utilizar esta
% m�quina har� que se pierda dinero en la inversi�n.
%
[minimo, maximo, media, desviacion] ...
    = mac.fitnessStatistics(@profitLoss,'Lead',leadSet,'Lag',lagSet);


%% Histograma 2. Funci�n de evaluaci�n minProfitLossExpected
%
% Muestra el histograma asociado.
%
[minimo, maximo, media, desviacion] ...
    = mac.fitnessStatistics(@minProfitLossExpected,'Lead',leadSet,'Lag',lagSet);


%% Histograma 3. Funci�n de evaluaci�n loss
%
% Muestra el histograma asociado.
%
[minimo, maximo, media, desviacion] ...
    = mac.fitnessStatistics(@loss,'Lead',leadSet,'Lag',lagSet);
