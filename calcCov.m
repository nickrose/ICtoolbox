function [Rx,Ry,Rxy] = calcCov(M,x,y)
% calcCov.m - calculate second order statistics for a pair of datasets.
% 
% Usage:
%    [Rx,Ry,Rxy] = calcCov(M,x,y)
%
% Inputs:
%    M          the number of samples
%    x, y       rows index the measurment, samples are the columns.
%
% NOTE: Here we use (1/M) vs. the unbiased (1/(M-1)) because it is assumed
% that the mean is known to be zero. Were the sample mean to be used in the
% calculation of the sample covariance, then we would need to use the
% latter unbiased estimate scaling factor.
%
% Oct 2013, Mod: Sep 2014
% 
% ICtoolbox  Copyright (C) 2014 Nicholas Roseveare
%     This program comes with ABSOLUTELY NO WARRANTY; for details see the LICENSE file
%     This is free software, and you are welcome to redistribute it
%     under certain conditions; see LICENSE file for conditions
%


if any(abs(mean(x,2)) < 1e-10) && any(abs(mean(y,2)) < 1e-10)
    Rx =(x*x'/M);
    Ry =(y*y'/M);
    Rxy=(x*y'/M);
elseif M > 1
    % use the best unbiased estimator of covariance
    ux = mean(x,2);
    uy = mean(y,2);
    for mm = 1:M
        x(:,mm) = x(:,mm) - ux;
        y(:,mm) = y(:,mm) - uy;
    end
    
    Rx =(x*x'/(M-1));
    Ry =(y*y'/(M-1));
    Rxy=(x*y'/(M-1));
else
    Rx =x*x';
    Ry =y*y';
    Rxy=x*y';
end