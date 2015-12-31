%% Ejemplo 2 - Trabajando con series de datos
%
% En este caso, se comparan las series de datos obtenidas desde dos
% proveedores de información bursátil respecto a la misma acción de la
% bolsa: el objetivo es resaltar las diferencias entre los proveedores.
%

%% Crea un objeto de la clase YahooDataSerie con la información bursátil
%
% Identificador:            KO (The Coca-Cola Company)
% Compresión en los datos:  Datos diarios
% Inicio del intervalo:     1 de enero de 2005
% Fin del intervalo:        1 de enero de 2009
%
dsY = YahooDataSerie('ko','days',1,'2005-01-01','2009-01-01');

% Muestra las propiedades del objeto en la consola
dsY

% Muestra el gráfico con la información almacenada en el objeto
dsY.plot();


%% Crea un objeto de la clase GoogleDataSerie con la información bursátil
%
% Identificador:            KO (The Coca-Cola Company)
% Compresión en los datos:  Datos diarios
% Inicio del intervalo:     1 de enero de 2005
% Fin del intervalo:        1 de enero de 2009
%
dsG = GoogleDataSerie('ko','days',1,'2005-01-01','2009-01-01');

% Muestra las propiedades del objeto en la consola
dsG

% Muestra el gráfico con la información almacenada en el objeto
dsG.plot();


%% Comparación de las series de datos
%
% El número de elementos en cada objeto es diferente. El proveedor de
% Google ha dado dos valores más.
%
dsY.Length

dsG.Length

% Los valores que hay de más en un objeto respecto al otro se detectan
% calculando el conjunto diferencia entre los vectores de instantes de
% tiempo
[items, indexes]=setdiff(dsG.DateTime,dsY.DateTime);

% Fechas para las cuales se tiene información en el objeto dsG y no en el
% objeto dsY
datestr(items)

% Índices del objeto dsG que no están presentes en el objeto dsY
indexes


%% Comparación de los vectores de datos que contienen
%
% Una vez excluidos los valores de una serie de datos que no están
% presentes en la otra se calcula la diferencia entre los valores
% almacenados en cada objeto. Se observa que además de longitud diferente
% la información contenida en los vectores también varía. Esto se debe a
% que cada proveedor ofrece información diferente incluso para una misma
% acción del mercado.
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
title(ah,'Diferencia en el precio más alto');
xlim(ah,[dsY.DateTime(1) dsY.DateTime(end)]);
datetick(ah, 'x', 'yyyy.mm.dd', 'keepticks', 'keeplimits');

ah = subplot(2,2,3);
plot(ah,dsY.DateTime,dsY.Low-dsG.Low(selection),'c');
title(ah,'Diferencia en el precio más bajo');
xlim(ah,[dsY.DateTime(1) dsY.DateTime(end)]);
datetick(ah, 'x', 'yyyy.mm.dd', 'keepticks', 'keeplimits');

ah = subplot(2,2,4);
plot(ah,dsY.DateTime,dsY.Close-dsG.Close(selection),'b');
title(ah,'Diferencia en el precio de cierre');
xlim(ah,[dsY.DateTime(1) dsY.DateTime(end)]);
datetick(ah, 'x', 'yyyy.mm.dd', 'keepticks', 'keeplimits');
