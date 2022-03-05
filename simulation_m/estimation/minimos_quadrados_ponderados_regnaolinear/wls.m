function [b_w] = wls(X, Y, W, k) 
    
%     H = X*inv(X'*X+k)*X';
%     
%     Y_hat = H*Y; 
%     
%     %residualss
%     e_hat = Y-Y_hat; 
%     
%     %residual sum of squares
%     rss = e_hat'*e_hat;
%     
%     %square of residual
%     e_hat_sqr = e_hat.^2;
    
    %weights
    %w_i = 1./(e_hat_sqr); 

    %diagonal weight matrix
    %W = diag(w_i);

    b_w = inv(X'*W*X+k)*(X'*W*Y);
     
end