
function prediction = predict(algoTrader)

% Parameters
k = algoTrader.K;
serie = algoTrader.DataSerie.Serie;
diffSerie = [0 diff(serie)];

N = length(serie);

diffPrediction = NaN(1,N+k);
for i = k:k:N
    %diffPrediction(i+1:i+k) = forecast(serie(1:i), k);
    diffPrediction(i+1:i+k) = forecast(diffSerie(1:i), k);
end
%diffPrediction(N+1:N+k) = forecast(serie(1:N), k);
diffPrediction(N+1:N+k) = forecast(diffSerie(1:N), k);

% Cut to fit the size
%diffPrediction = diffPrediction(k+1:end);
%prediction = serie+diffPrediction;

prediction = serie+diffPrediction(k+1:end);

[serie' prediction']

end


function yf = forecast(y,k)

[coeff,errors,LLF,innovations,sigmas] = garchfit(y);

yf = garchpred(coeff,y,k);

end
