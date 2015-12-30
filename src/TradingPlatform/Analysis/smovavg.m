function avg = smovavg(asset, n, alpha) 
 
if nargin < 3 
  alpha = 0; % Default is simple moving average 
end 

r = length(asset);
 
if lower(alpha) == 'e' 
  % compute exponential moving average 
  % calculate smoothing constant (alpha) 
  alpha = 2/(n+1); 
  % first exponential average is first price 
  avg(1) = asset(1); 
  % preallocate matrices 
  avg = [avg;zeros(r-1,1)]; 
  % average 
  % For large matrices of input data, FOR loops are more efficient 
  % than vectorization. 
  for j = 2:r
    avg(j) = avg(j-1) + alpha*(asset(j) - avg(j-1)); 
  end
else 
  % compute general moving average (ie simple, linear, etc) 
  % build weighting vectors 
  i = 1:n; 
  w(i) = (n - i + 1).^alpha./sum([1:n].^alpha); 
  % build moving average vectors by filtering asset through weights 
  avg = filter(w,1,asset); 
end
