
function prediction = predict(algoTrader)

% Parameters
order = algoTrader.Order;
method = algoTrader.Method;
k = algoTrader.K;
serie = algoTrader.DataSerie.Serie;

N = length(serie);

prediction = NaN(1,N+k);
for i = 2*order:k:N
    prediction(i+1:i+k) = forecast(serie(1:i), order, method, k);
end
prediction(N+1:N+k) = forecast(serie(1:N), order, method, k);

% Cut to fit the size
prediction = prediction(k+1:end);

end


function yf = forecast(y,order,method,k)
% YF = FORECAST(DATA,ORDER,METHOD,K)
%
% Builds AR model of ORDER by METHOD and forecasts (double) time series Y 
% K steps into the future. Returns forecasted (double) time series YF of 
% length K. 
%
% METHOD can be: 
% 1) 'burg' (Burg's lattice-based method solving the lattice filter 
% equations using the harmonic mean of forward and backward squared 
% prediction errors),
% 2) 'fb' (Forward-backward approach minimizing the sum of a least-squares 
% criterion for a forward model, and the analogous criterion for a time-
% reversed model), 
% 3) 'gl' (Geometric lattice approach similar to Burg's method but uses the 
% geometric mean instead of the harmonic mean during minimization), 
% 4) 'ls' (Least-squares approach minimizing the standard sum of squared 
% forward-prediction errors),
% 5) 'yw' (Yule-Walker approach solving the Yule-Walker equations, formed 
% from sample covariances) 

% Process input data
y = iddata(y');
[N, ny, nu] = size(y);
zer = iddata(zeros(k,ny),zeros(k,nu),y.Ts);
yz = [y; zer];

% Build model
mb = ar(y,order,method);

% Perform prediction
yft = predict(mb,yz,k,'estimate');

% Keep only predicted time series
yff = yft(N+1:N+k);
yf = yff.OutputData';

end
