%% Ejemplo 2 - Trabajando con series de datos
%
% En este caso, se comparan las series de datos obtenidas desde dos
% proveedores de informaci�n burs�til respecto a la misma acci�n de la
% bolsa: el objetivo es resaltar las diferencias entre los proveedores.
%

%% Crea un objeto de la clase YahooDataSerie con la informaci�n burs�til
%
% Identificador:            KO (The Coca-Cola Company)
% Compresi�n en los datos:  Datos diarios
% Inicio del intervalo:     1 de enero de 2005
% Fin del intervalo:        1 de enero de 2009
%
dsY = YahooDataSerie('ko','days',1,'2005-01-01','2009-01-01');

% Muestra las propiedades del objeto en la consola
dsY

% Muestra el gr�fico con la informaci�n almacenada en el objeto
dsY.plot();


%% Crea un objeto de la clase GoogleDataSerie con la informaci�n burs�til
%
% Identificador:            KO (The Coca-Cola Company)
% Compresi�n en los datos:  Datos diarios
% Inicio del intervalo:     1 de enero de 2005
% Fin del intervalo:        1 de enero de 2009
%
dsG = GoogleDataSerie('ko','days',1,'2005-01-01','2009-01-01');

% Muestra las propiedades del objeto en la consola
dsG

% Muestra el gr�fico con la informaci�n almacenada en el objeto
dsG.plot();


%% Comparaci�n de las series de datos
%
% El n�mero de elementos en cada objeto es diferente. El proveedor de
% Google ha dado dos valores m�s.
%
dsY.Length

dsG.Length

% Los valores que hay de m�s en un objeto respecto al otro se detectan
% calculando el conjunto diferencia entre los vectores de instantes de
% tiempo
[items, indexes]=setdiff(dsG.DateTime,dsY.DateTime);

% Fechas para las cuales se tiene informaci�n en el objeto dsG y no en el
% objeto dsY
datestr(items)

% �ndices del objeto dsG que no est�n presentes en el objeto dsY
indexes


%% Comparaci�n de los vectores de datos que contienen
%
% Una vez excluidos los valores de una serie de datos que no est�n
% presentes en la otra se calcula la diferencia entre los valores
% almacenados en cada objeto. Se observa que adem�s de longitud diferente
% la informaci�n contenida en los vectores tambi�n var�a. Esto se debe a
% que cada proveedor ofrece informaci�n diferente incluso para una misma
% acci�n del mercado.
%
selection = 1:dsG.Length;
selection(indexes)=[];

figure;

ah = subplot(2,2,1);
plot(ah,dsY.DateTime,dsY.Open-dsG.Open(selection),'m');
title(ah,'Diferencia en el precio de apertura');
xlim(ah,[dsY.DateTime(1) dsY.DateTime(end)]);
datetick(ah, 'x', 'yyyy.mm.dd', 'keepticks', 'keeplimits');

ah = subplot(2,2,2);
plot(ah,dsY.DateTime,dsY.High-dsG.High(selection),'r');
title(ah,'Diferencia en el precio m�s alto');
xlim(ah,[dsY.DateTime(1) dsY.DateTime(end)]);
datetick(ah, 'x', 'yyyy.mm.dd', 'keepticks', 'keeplimits');

ah = subplot(2,2,3);
plot(ah,dsY.DateTime,dsY.Low-dsG.Low(selection),'c');
title(ah,'Diferencia en el precio m�s bajo');
xlim(ah,[dsY.DateTime(1) dsY.DateTime(end)]);
datetick(ah, 'x', 'yyyy.mm.dd', 'keepticks', 'keeplimits');

ah = subplot(2,2,4);
plot(ah,dsY.DateTime,dsY.Close-dsG.Close(selection),'b');
title(ah,'Diferencia en el precio de cierre');
xlim(ah,[dsY.DateTime(1) dsY.DateTime(end)]);
datetick(ah, 'x', 'yyyy.mm.dd', 'keepticks', 'keeplimits');
