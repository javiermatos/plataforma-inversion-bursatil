%% Ejemplo 3 - Utilizando las m�quinas de trading
%
% En el tercer ejemplo se trabaja con un grupo de m�quinas de trading para
% resaltar y evidenciar algunas de sus caracter�sticas. Se trata la
% cuesti�n de la modificaci�n de par�metros para observar la forma en que
% afecta al comportamiento de las m�quinas.
%


%% Crea un objeto de la clase DataSerie con la informaci�n burs�til
%
% Identificador:            SAN.MC (Banco Santander SA)
% Compresi�n en los datos:  Datos diarios
% Inicio del intervalo:     1 de enero de 2009
% Fin del intervalo:        1 de enero de 2011
%
ds = YahooDataSerie('san.mc','days',1,'2009-01-01','2011-01-01');

% Muestra el gr�fico con la informaci�n almacenada en el objeto
ds.plot();


%% M�quina de trading basada en la media m�vil
%
% No es necesario pasar m�s par�metros a la m�quina que el objeto del tipo
% DataSerie. La clase MovingAverage utiliza los par�metros 'Mode' y
% 'Samples' para el c�lculo de la se�al de posici�n. En caso de omisi�n
% estos valores toman aquellos definidos en el archivo Default.m.
%
ma = MovingAverage(ds);

% Muestra las propiedades de la m�quina en la consola
ma

% Muestra los valores que toman las propiedades 'Mode' y 'Samples'
ma.Mode

ma.Samples

% Muestra los valores predefinidos de las propiedades 'Mode' y 'Samples'
Default.MovingAverage.Mode

Default.MovingAverage.Samples

% Muestra la evoluci�n del precio de la acci�n, las posiciones que adopta
% la m�quina y la curva de beneficio/p�rdida asociada en el intervalo de
% test
ma.plot(1);

% Calcula el beneficio/p�rdida para la m�quina en los periodos de
% entrenamiento y test
ma.ProfitLossTrainingSet
ma.ProfitLossTestSet

% Copia la m�quina y cambia el valor de sus par�metros
ma2 = ma.clone();
ma2.Mode = 's';
ma2.Samples = 28;

% Muestra la evoluci�n del precio de la acci�n, las posiciones que adopta
% la m�quina y la curva de beneficio/p�rdida asociada en el intervalo de
% test
ma2.plot(1);

% Calcula el beneficio/p�rdida para la nueva m�quina en los periodos de
% entrenamiento y test
ma2.ProfitLossTrainingSet
ma2.ProfitLossTestSet

%% Calcula la curva diferencia entre ambas
%
% Se aprecia que la primera estrategia rinde mejor que la segunda, pues la
% diferencia entre la evoluci�n del beneficio/p�rdida es negativa
%
figure; ah = axes();

plot(ah,ma.DataSerie.DateTime,ma.profitLossSerie(3)-ma2.profitLossSerie(3));
title(ah,'Diferencia entre la evoluci�n del beneficio/p�rdida');
xlim(ah,[ma.DataSerie.DateTime(1) ma.DataSerie.DateTime(end)]);
datetick(ah, 'x', 'yyyy.mm.dd', 'keepticks', 'keeplimits');
