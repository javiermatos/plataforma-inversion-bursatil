
function yf = garchforecast(y,k)

[coeff,errors,LLF,innovations,sigmas] = garchfit(y);

yf = garchpred(coeff,y,k);

end
