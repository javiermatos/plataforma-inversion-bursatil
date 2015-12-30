
function index = firstFrom(dataSerie, dateTime)

index = find(datenum(dateTime) <= dataSerie.DateTime, 1, 'first');

end
