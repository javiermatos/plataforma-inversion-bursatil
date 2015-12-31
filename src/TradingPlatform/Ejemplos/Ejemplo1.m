%% Ejemplo 1 - Toma de contacto
%
% Consiste en una toma de contacto para familiarizarse con la plataforma de
% inversi�n. Se realizan algunas operaciones b�sicas sobre las series de
% datos y las m�quinas de trading. Para cada objeto creado se muestran sus 
% propiedades y se utilizan los m�todos de generaci�n de gr�ficos para
% mostrar su representaci�n.
%


%% Crea un objeto de la clase DataSerie con la informaci�n burs�til
%
% Identificador:            TEF.MC (Telef�nica SA)
% Compresi�n en los datos:  Datos diarios
% Inicio del intervalo:     1 de enero de 2008
% Fin del intervalo:        1 de enero de 2010
%
ds = YahooDataSerie('tef.mc','days',1,'2008-01-01','2010-01-01');

% Muestra las propiedades del objeto en la consola
ds

% Muestra el gr�fico con la informaci�n almacenada en el objeto
ds.plot();

% Muestra el precio de cierre de la acci�n
ds.plotClose();

% Muestra el volumen de transacciones
ds.plotVolume();


%% Crea una m�quina de trading basada en la estrategia de la media m�vil
%
% Modo:                   Exponencial
% N�mero de periodos:     30
%
ma = MovingAverage(ds,'e',30);

% Muestra las propiedades de la m�quina en la consola
ma

% Muestra la evoluci�n del precio de la acci�n, las posiciones que adopta
% la m�quina y la curva de beneficio/p�rdida asociada
%
% Intervalo de la representaci�n:   1 (Intervalo de test)
%
ma.plot(1);


%% Crea una segunda m�quina de trading basada en el estoc�stico
%
% N�mero de periodos:   10
% Umbral de subida:     70
% Umbral de descenso:   30
%
stc = Stochastic(ds,21,70,30);

% Muestra las propiedades de la m�quina en la consola
stc

% Muestra la evoluci�n del precio de la acci�n, las posiciones que adopta
% la m�quina y la curva de beneficio/p�rdida asociada
%
% Intervalo de la representaci�n:   1 (Intervalo de test)
%
stc.plot(1);
