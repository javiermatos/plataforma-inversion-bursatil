%% Ejemplo 3 - Utilizando las máquinas de trading
%
% En el tercer ejemplo se trabaja con un grupo de máquinas de trading para
% resaltar y evidenciar algunas de sus características. Se trata la
% cuestión de la modificación de parámetros para observar la forma en que
% afecta al comportamiento de las máquinas.
%


%% Crea un objeto de la clase DataSerie con la información bursátil
%
% Identificador:            SAN.MC (Banco Santander SA)
% Compresión en los datos:  Datos diarios
% Inicio del intervalo:     1 de enero de 2009
% Fin del intervalo:        1 de enero de 2011
%
ds = YahooDataSerie('san.mc','days',1,'2009-01-01','2011-01-01');

% Muestra el gráfico con la información almacenada en el objeto
ds.plot();


%% Máquina de trading basada en la media móvil
%
% No es necesario pasar más parámetros a la máquina que el objeto del tipo
% DataSerie. La clase MovingAverage utiliza los parámetros 'Mode' y
% 'Samples' para el cálculo de la señal de posición. En caso de omisión
% estos valores toman aquellos definidos en el archivo Default.m.
%
ma = MovingAverage(ds);

% Muestra las propiedades de la máquina en la consola
ma

% Muestra los valores que toman las propiedades 'Mode' y 'Samples'
ma.Mode

ma.Samples

% Muestra los valores predefinidos de las propiedades 'Mode' y 'Samples'
Default.MovingAverage.Mode

Default.MovingAverage.Samples

% Muestra la evolución del precio de la acción, las posiciones que adopta
% la máquina y la curva de beneficio/pérdida asociada en el intervalo de
% test
ma.plot(1);

% Calcula el beneficio/pérdida para la máquina en los periodos de
% entrenamiento y test
ma.ProfitLossTrainingSet
ma.ProfitLossTestSet

% Copia la máquina y cambia el valor de sus parámetros
ma2 = ma.clone();
ma2.Mode = 's';
ma2.Samples = 28;

% Muestra la evolución del precio de la acción, las posiciones que adopta
% la máquina y la curva de beneficio/pérdida asociada en el intervalo de
% test
ma2.plot(1);

% Calcula el beneficio/pérdida para la nueva máquina en los periodos de
% entrenamiento y test
ma2.ProfitLossTrainingSet
ma2.ProfitLossTestSet

%% Calcula la curva diferencia entre ambas
%
% Se aprecia que la primera estrategia rinde mejor que la segunda, pues la
% diferencia entre la evolución del beneficio/pérdida es negativa
%
figure; ah = axes();

plot(ah,ma.DataSerie.DateTime,ma.profitLossSerie(3)-ma2.profitLossSerie(3));
title(ah,'Diferencia entre la evolución del beneficio/pérdida');
xlim(ah,[ma.DataSerie.DateTime(1) ma.DataSerie.DateTime(end)]);
datetick(ah, 'x', 'yyyy.mm.dd', 'keepticks', 'keeplimits');
