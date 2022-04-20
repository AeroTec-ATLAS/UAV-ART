function [b] = mlr(X, Y, k) 
    b = inv(transpose(X)*X + k)*transpose(X)*Y;
end