
function boolean = equals(dataSerie1, dataSerie2)

boolean = true;

% Class
boolean = boolean & strcmp(class(dataSerie1),class(dataSerie2));
% Compression Type
boolean = boolean & strcmp(dataSerie1.CompressionType,dataSerie1.CompressionType);
% Compression Units
boolean = boolean & dataSerie1.CompressionUnits == dataSerie1.CompressionUnits;

% Length
if length(dataSerie1.DateTime) == length(dataSerie2.DateTime)
    
    boolean = boolean & all(dataSerie1.DateTime == dataSerie2.DateTime);
    boolean = boolean & all(dataSerie1.Open == dataSerie2.Open);
    boolean = boolean & all(dataSerie1.High == dataSerie2.High);
    boolean = boolean & all(dataSerie1.Low == dataSerie2.Low);
    boolean = boolean & all(dataSerie1.Close == dataSerie2.Close);
    boolean = boolean & all(dataSerie1.Volume == dataSerie2.Volume);
    
else
    boolean = false;
end

end
