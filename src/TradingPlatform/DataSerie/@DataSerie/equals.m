
function boolean = equals(lhs, rhs)

boolean = true;

% Class
boolean = boolean & strcmp(class(lhs),class(rhs));
% Compression Type
boolean = boolean & strcmp(lhs.CompressionType,rhs.CompressionType);
% Compression Units
boolean = boolean & lhs.CompressionUnits == rhs.CompressionUnits;

% Length
if length(lhs.DateTime) == length(rhs.DateTime)
    
    boolean = boolean & all(lhs.DateTime == rhs.DateTime);
    boolean = boolean & all(lhs.Open == rhs.Open);
    boolean = boolean & all(lhs.High == rhs.High);
    boolean = boolean & all(lhs.Low == rhs.Low);
    boolean = boolean & all(lhs.Close == rhs.Close);
    boolean = boolean & all(lhs.Volume == rhs.Volume);
    
else
    boolean = false;
end

end
