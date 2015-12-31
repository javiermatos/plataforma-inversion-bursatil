
function prediction = predict(algoTrader)

% Parameters
order = [algoTrader.Na algoTrader.Nc];
method = algoTrader.Method;
k = algoTrader.K;
serie = algoTrader.DataSerie.Serie;

N = length(serie);

prediction = NaN(1,N+k);
for i = 3*sum(order):k:N
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
% SearchMethod: The search method used for iterative parameter estimation.
% It can take one of the following values:
% 
% 'gn': The subspace Gauss-Newton direction. Singular values of the
% Jacobian matrix less than GnPinvConst*eps*max(size(J))*norm(J) are
% discarded when computing the search direction, where J is the Jacobian
% matrix. The Hessian matrix is approximated by JTJ. If there is no
% improvement along this direction, the gradient direction is also tried.
% 
% 'gna': An adaptive version of subspace Gauss-Newton approach, suggested
% by Wills and Ninness (IFAC World congress, Prague 2005). Eigenvalues less
% than gamma*max(sv) of the Hessian are neglected , where sv are the
% singular values of the Hessian. The Gauss-Newton direction is computed in
% the remaining subspace. gamma has the initial value InitGnaTol (see
% below) and is increased by the factor LmStep each time the search fails
% to find a lower value of the criterion in less than 5 bisections. It is
% decreased by the factor 2*LmStep each time a search is successful without
% any bisections.
% 
% 'lm': Uses the Levenberg-Marquardt method. This means that the next
% parameter value is -pinv(H+d*I)*grad from the previous one, where H is
% the Hessian, I is the identity matrix, and grad is the gradient. d is a
% number that is increased until a lower value of the criterion is found.
% 
% 'Auto': A choice among the above is made in the algorithm. This is the
% default choice.
% 
% 'lsqnonlin': Uses lsqnonlin optimizer from Optimization Toolbox™
% software. You must have Optimization Toolbox installed to use this
% option. This search method can only handle the Trace criterion.

% Process input data
y = iddata(y');
[N, ny, nu] = size(y);
zer = iddata(zeros(k,ny),zeros(k,nu),y.Ts);
yz = [y; zer];

% Build model
mb = armax(y,order,'SearchMethod',method);

% Perform prediction
yft = predict(mb,yz,k,'estimate');

% Keep only predicted time series
yff = yft(N+1:N+k);
yf = yff.OutputData';

end
