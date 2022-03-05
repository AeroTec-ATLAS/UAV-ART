function [curve, W] = lat_curve_fitting(xdata, y, beta0, t) 

figure()
plot(t, y, 'ro');

%Complete model
F = @(beta, xdata)beta(1)*xdata(:,1)+ beta(2)*xdata(:,2) + beta(3)*xdata(:,3) + beta(4)*xdata(:,4) + beta(5)*xdata(:,5) + beta(6)*xdata(:,6);

%Simplified model
%F = @(beta, xdata)beta(1)*xdata(:,1)+ beta(2)*xdata(:,2) + beta(3)*xdata(:,3);

curve = lsqcurvefit(F,beta0, xdata, y);

%Complete model
y_fitted = curve(1)*xdata(:,1) + curve(2)*xdata(:,2)+ curve(3)*xdata(:,3)+ curve(4)*xdata(:,4) + curve(5)*xdata(:,5) + curve(6)*xdata(:,6) ;


%Simplified model
%y_fitted = curve(1)*xdata(:,1) + curve(2)*xdata(:,2)+ curve(3)*xdata(:,3);

plot (t, y, 'o', t, y_fitted);
legend('Data','Fitted curve')
title('Data and Fitted Curve')

mean = (y + y_fitted)/2;
variance = ((y-mean).^2 + (y_fitted-mean).^2)/2;
w_i = 1./variance;
W = diag(w_i);
