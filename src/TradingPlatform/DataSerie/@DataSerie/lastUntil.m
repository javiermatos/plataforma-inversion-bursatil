
function index = lastUntil(dataSerie, dateTime)

index = find(datenum(dateTime) >= dataSerie.DateTime, 1, 'last');

end
