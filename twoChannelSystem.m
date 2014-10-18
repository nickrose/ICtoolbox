function [X,Y] = twoChannelSystem(M,n,m,q1,q2,q3,xSigL,ySigL,xySigL,sigType,field)
% twoChannelSystem.m - simulate correlated vector channels.
%
% USAGE:
%  [X,Y] = twoChannelSystem(M,n,m,q1,q2,q3,xSigL,ySigL,xySigL)
%  [X,Y] = twoChannelSystem(M,n,m,q1,q2,q3,xSigL,ySigL,xySigL,sigType,field)
%
% Follows similar structure to Wax-Kailath information criterion technique,
% but includes the estimation of the number of cross terms between the two
% channels. This model is according to:
%
% x = Bx*Scross + Ax*Sx + noise
% y = By*Scross + Ay*Sy + noise
%
% Variance of terms is inputted, whilst the noise power is generating below 
% as alwyas equal to 1. 
%
% M                   num observations
% n                   x meas dim
% m                   y meas dim 
% q1, q2, q3          dimension of x, y (indep from) correlated components
% xSigL,ySigL,xySigL  var or signal intensity of various terms (dep on
%                     'sigType')
% sigType             can be either the signal 'var', or signal 'sinr'
% field               'real' or 'complexproper' - dictates data generation,
%                    but also must be accounted for later in the likelihood
%
% (originally (in Winter 2013) titled: twoChannelSystem_waxlike)
% 
% ICtoolbox  Copyright (C) 2014 Nicholas Roseveare
%     This program comes with ABSOLUTELY NO WARRANTY; for details see the LICENSE file
%     This is free software, and you are welcome to redistribute it
%     under certain conditions; see LICENSE file for conditions
%

switch field
    case 'real'
        randMatX = randn(n,max(M,n));
        randMatY = randn(m,max(M,m));
    case 'complexproper'
        randMatX = randn(n,M)+1i*randn(n,M);
        randMatY = randn(m,M)+1i*randn(m,M);
    otherwise
        error('twoChannelSystem:fieldInput','Please provide either ''real'' or ''complexproper'' as the type of field for the data to be generated')
end
randMatX = randMatX*randMatX'/max(M,n);
[Ux,D] = eig(randMatX);
randMatY = randMatY*randMatY'/max(M,n);
[Uy,D] = eig(randMatY);

Ax = Ux(:,1:q1);
Bx = Ux(:,q1+1:(q1+q3));

Ay = Uy(:,1:q2);
By = Uy(:,q2+1:(q2+q3));

switch sigType
    case 'var'
        xVar  = xSigL;
        yVar  = ySigL;
        xyVarX = xySigL;
        xyVarY = xySigL;
        
        if (q1+q3 > n) || (q2+q3 > m)
            error('ModelDimError:Overfull','Model auto- and cross-term dimensions exceed total dimension, need r1+r3 <= n, r2+r3 <= m')
        end
        dimXsrc = size(xVar,1);
        dimYsrc = size(yVar,1);
        dimXYsrc = size(xyVarX,1);
        if ~(q1==dimXsrc || dimXsrc==1) ||~(q2==dimYsrc || dimYsrc==1) ||~(q3==dimXYsrc || dimXYsrc==1)
            error('InputSizeMismatch:SourcePower','xVar, yVar, and xyVar can be col vectors, but these must match the respective qi size')
        end
    case 'sinr'
        xVar  = 10^(xSigL/10)/trace(Ax'*Ax);
        yVar  = 10^(ySigL/10)/trace(Ay'*Ay);
        xyVarX = 10^(xySigL/10)*trace(Ax'*Ax)/trace(Bx'*Bx);
        xyVarY = 10^(xySigL/10)*trace(Ay'*Ay)/trace(By'*By);
    otherwise
        error('ModelDimError:SigStrengthType','The inputted signal strength type is invalid, use ''var'' or ''sinr''')
end

X = zeros(n,M);
Y = zeros(m,M);

switch field
    case 'real'
        for k = 1:M
            commonSignal = randn(q3,1);
            X(:,k) = Bx*(sqrt(xyVarX).*commonSignal) + Ax*(sqrt(xVar).*randn(q1,1)) + randn(n,1);
            Y(:,k) = By*(sqrt(xyVarY).*commonSignal) + Ay*(sqrt(yVar).*randn(q2,1)) + randn(m,1);
        end
        
    case 'complexproper'
        for k = 1:M
            commonSignal = randn(q3,1)+1i*randn(q3,1);
            X(:,k) = Bx*(sqrt(xyVarX/2).*commonSignal) + Ax*(sqrt(xVar/2).*(randn(q1,1)+1i*randn(q1,1))) + 1/sqrt(2)*(randn(n,1)+1i*randn(n,1));
            Y(:,k) = By*(sqrt(xyVarY/2).*commonSignal) + Ay*(sqrt(yVar/2).*(randn(q2,1)+1i*randn(q2,1))) + 1/sqrt(2)*(randn(m,1)+1i*randn(m,1));
        end
end