%% Ejemplo 1 - Toma de contacto
%
% Consiste en una toma de contacto para familiarizarse con la plataforma de
% inversión. Se realizan algunas operaciones básicas sobre las series de
% datos y las máquinas de trading. Para cada objeto creado se muestran sus 
% propiedades y se utilizan los métodos de generación de gráficos para
% mostrar su representación.
%


%% Crea un objeto de la clase DataSerie con la información bursátil
%
% Identificador:            TEF.MC (Telefónica SA)
% Compresión en los datos:  Datos diarios
% Inicio del intervalo:     1 de enero de 2008
% Fin del intervalo:        1 de enero de 2010
%
ds = YahooDataSerie('tef.mc','days',1,'2008-01-01','2010-01-01');

% Muestra las propiedades del objeto en la consola
ds

% Muestra el gráfico con la información almacenada en el objeto
ds.plot();

% Muestra el precio de cierre de la acción
ds.plotClose();

% Muestra el volumen de transacciones
ds.plotVolume();


%% Crea una máquina de trading basada en la estrategia de la media móvil
%
% Modo:                   Exponencial
% Número de periodos:     30
%
ma = MovingAverage(ds,'e',30);

% Muestra las propiedades de la máquina en la consola
ma

% Muestra la evolución del precio de la acción, las posiciones que adopta
% la máquina y la curva de beneficio/pérdida asociada
%
% Intervalo de la representación:   1 (Intervalo de test)
%
ma.plot(1);


%% Crea una segunda máquina de trading basada en el estocástico
%
% Número de periodos:   10
% Umbral de subida:     70
% Umbral de descenso:   30
%
stc = Stochastic(ds,21,70,30);

% Muestra las propiedades de la máquina en la consola
stc

% Muestra la evolución del precio de la acción, las posiciones que adopta
% la máquina y la curva de beneficio/pérdida asociada
%
% Intervalo de la representación:   1 (Intervalo de test)
%
stc.plot(1);
