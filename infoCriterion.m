function [orderEst, varargout] = infoCriterion(M,field,varargin)
% infoCriterion.m - information criterion based on simple decomposition of 
% the auto- and cross-covariances. The number of terms to retain influences 
% the likelihood of the fit.
%
% This is following a Wax-Kailath-like model order estimator by assuming 
% the "non-signal" modes are replaced with the approximation of noise from 
% the smallest eigenvalues.
%
% Usage:
%     orderEst = infoCriterion(M,field,Rx,Ry,Rxy,ICtype)
%     orderEst = infoCriterion(M,field,Rx,Ry,Rxy)
%     orderEst = infoCriterion(M,field,X,Y,ICtype)
%     orderEst = infoCriterion(M,field,X,Y)
%     orderEst = infoCriterion(M,field,X)
%
%    [orderEst,
%      corrs] = infoCriterion(M,field, "   " )
% 
% Inputs:
%     M             the number of samples
%     field         type of data ('real' or 'complexproper')
%     Rx, Ry, Rxy   if data covariances are calc beforehand
%     ICtype        specify which ICs to apply
%     X,Y           data matrices (rows: measurement dim, cols:samples)
%
% Outputs (optional):
%     orderEst      rows(r1,r2,r3 estimates), cols(AIC_fsFit, BIC_fsFit,
%                                              AIC_jointXFit, BIC_jointXFit, 
%                                              AIC_indv, BIC_indv,  
%                                              AIC_crossOnly, BIC_crossOnly)
%     corrs         vector of canonical correlations
%
% originally titled: pcacca.m, June 2014 
% 
% ICtoolbox  Copyright (C) 2014 Nicholas Roseveare
%     This program comes with ABSOLUTELY NO WARRANTY; for details see the LICENSE file
%     This is free software, and you are welcome to redistribute it
%     under certain conditions; see LICENSE file for conditions
%
 

if nargin == 3
    ICtype = 5:6;
    X = varargin{1};
    [n,M] = size(X);
    Rx = X*X/(M-1);
elseif nargin == 4 || (nargin == 5  && (size(varargin{3},1) == 1 && all(round(varargin{3}) == varargin{3})))
    if nargin == 5;
        ICtype = varargin{3};
    else
        ICtype = 1:8;
    end
    X = varargin{1};
    Y = varargin{2};
    M = size(X,2);
    [Rx,Ry,Rxy] = calcCov(M,X,Y);
    [n,m] = size(Rxy);
elseif nargin == 5 || nargin == 6
    if nargin == 6;
        ICtype = varargin{4};
    else
        ICtype = 1:8;
    end
    Rx = varargin{1};
    Ry = varargin{2};
    Rxy = varargin{3};
    [n,m] = size(Rxy);
end
p = min(n,m);

switch field
    case 'real'
        traceCoeff = .5;
        detPower = .5;
        
        numModelTerms_fSigSR    = @(n,m,r1,r2,r3) .5*r1*(2*n-r1+1)+1 + .5*r2*(2*m-r2+1)+1 + r3*((n+m)-r3);
        numModelTerms_xFitSR    = @(n,m,r1,r2,r3) .5*r1*(2*n-r1+1)+1 + .5*r2*(2*m-r2+1)+1 + r3*((n+m)-r3);
        numModelTerms_waxIndiv  = @(n,m,r1,r2)    .5*r1*(2*n-r1+1)+1 + .5*r2*(2*m-r2+1)+1;
        numModelTerms_crossOnly = @(n,m,r3)                                                     r3*((n+m)-r3);

    case 'complexproper'
        traceCoeff = 1;
        detPower = 1;
        
        numModelTerms_fSigSR    = @(n,m,r1,r2,r3)    r1*(2*n-r1)+1  +     r2*(2*m-r2)+1   +  r3*(2*(n+m)-2*r3);
        numModelTerms_xFitSR    = @(n,m,r1,r2,r3)    r1*(2*n-r1)+1  +     r2*(2*m-r2)+1   +  r3*(2*(n+m)-2*r3);
        numModelTerms_waxIndiv  = @(n,m,r1,r2)       r1*(2*n-r1)+1  +     r2*(2*m-r2)+1;
        numModelTerms_crossOnly = @(n,m,r3)                                                  r3*(2*(n+m)-2*r3);

end
[Ux,Sx,Vx] = svd(Rx);
sx=diag(Sx);
[Uy,Sy,Vy] = svd(Ry);
sy = diag(Sy);

% tic
if M < max(n,m)
    Mhat = min(M,n);
    RxPIsqr = Ux(:,1:Mhat)*diag(sqrt(1./sx(1:Mhat)))*Ux(:,1:Mhat)';
    Mhat = min(M,m);
    RyPIsqr = Uy(:,1:Mhat)*diag(sqrt(1./sy(1:Mhat)))*Uy(:,1:Mhat)';
    [F,K,G] = svd(RxPIsqr*Rxy*RyPIsqr);
else
    [F,K,G] = svd((sqrtm(Rx)\Rxy)/sqrtm(Ry));
end
sxy = diag(K);

currentMin = inf*ones(1,8);
currentMinIndx = zeros(3,8);

if ~any(ICtype <=4) && (any(ICtype >=5) || any(ICtype <= 8))
% =========================================================================
% Run the individual model order estimators 
% =========================================================================

    AIC_waxIndivX = inf*ones(n+1,1);
    BIC_waxIndivX = inf*ones(n+1,1);
   
    currentMin = inf*ones(1,8);
    
    for ix = 1:n+1
        r1Test = ix-1;
        sigmaX2 = sum(sx(ix:end)) / (n-r1Test);
        
        if ix > n
            prodOverSumSmallestX = 1;
        else
            prodOverSumSmallestX = prod(sx(ix:end))...
                / (sigmaX2)^(n-ix-1);
        end
        LIKwaxIndivX = -(M*detPower)*log(prodOverSumSmallestX);
        numModelTerms_wax = numModelTerms_waxIndiv(n,m,r1,r2);
        
        AIC_waxIndivX(ix) = 2*LIKwaxIndivX + 2*numModelTerms_wax;
        BIC_waxIndivX(ix) = LIKwaxIndivX + log(M)/2*numModelTerms_wax;
        
        if AIC_waxIndivX(ix) < currentMin(5)
            currentMinIndx(1,5) = ix-1;
            currentMin(5) = min(currentMin(5), AIC_waxIndivX(ix));
        end
        if BIC_waxIndivX(ix) < currentMin(6)
            currentMinIndx(1,6) = ix-1;
            currentMin(6) = min(currentMin(6), BIC_waxIndivX(ix));
        end
    end
    
    if narargin > 3
        AIC_waxIndivY = inf*ones(m+1,1);
        BIC_waxIndivY = inf*ones(m+1,1);
        currentMin(5:6) = inf*ones(1,2);
        for iy = 1:m+1
            r2Test = iy - 1;
            sigmaY2 = sum(sy(iy:end)) / (m-r2Test);
            
            if iy > m
                prodOverSumSmallestY = 1;
            else
                prodOverSumSmallestY = prod(sy(iy:end))...
                    / (sigmaY2)^(m-iy-1);
            end
            LIKwaxIndivY = -(M*detPower)*log(prodOverSumSmallestY);
            numModelTerms_wax = numModelTerms_waxIndiv(n,m,r1,r2);
            
            AIC_waxIndivY(iy) =  2*LIKwaxIndivY + 2*numModelTerms_wax;
            BIC_waxIndivY(iy) =  LIKwaxIndivY + log(M)/2*numModelTerms_wax;
            
            if AIC_waxIndivY(ix) < currentMin(5)
                currentMinIndx(2,5) = iy-1;
                currentMin(5) = min(currentMin(5), AIC_waxIndivY(iy));
            end
            if BIC_waxIndivY(ix) < currentMin(6)
                currentMinIndx(2,6) = iy-1;
                currentMin(6) = min(currentMin(6), BIC_waxIndivY(iy));
            end
        end
        
        AIC_crossOnly = inf*ones(p+1,1);
        BIC_crossOnly = inf*ones(p+1,1);
        
        for ixy = 1:p
            LIKcrossOnly = (M*detPower)*log(prod(1-sxy(1:ixy-1).^2));
            terms_crossOnly = numModelTerms_crossOnly(n,m,r3);
            
            AIC_crossOnly(ixy) = 2*LIKcrossOnly + 2*terms_crossOnly;
            BIC_crossOnly(ixy) = LIKcrossOnly + log(M)/2*terms_crossOnly;
            
            if AIC_crossOnly(ixy) < currentMin(7)
                currentMinIndx(3,7) = ixy-1;
                currentMin(7) = min(currentMin(7), AIC_crossOnly(ixy));
            end
            if BIC_crossOnly(ixy) < currentMin(8)
                currentMinIndx(3,8) = ixy-1;
                currentMin(8) = min(currentMin(8), BIC_crossOnly(ixy));
            end
        end        
    end
    AIC_waxIndiv = repmat(AIC_waxIndivX,1,m+1) + repmat(AIC_waxIndivY',n+1,1);
    BIC_waxIndiv = repmat(BIC_waxIndivX,1,m+1) + repmat(BIC_waxIndivY',n+1,1);
else
    
% =========================================================================
% Run the joint model order estimators 
% =========================================================================
    AIC_fSigSR = inf*ones(n+1,m+1,p+1);
    BIC_fSigSR = inf*ones(n+1,m+1,p+1);
    AIC_XFitSR = inf*ones(n+1,m+1,p+1);
    BIC_XFitSR = inf*ones(n+1,m+1,p+1);

    AIC_waxIndiv = inf*ones(n+1,m+1);
    BIC_waxIndiv = inf*ones(n+1,m+1);
    AIC_crossOnly = inf*ones(p+1,1);
    BIC_crossOnly = inf*ones(p+1,1);

    for ix = 1:n+1
        r1Test = ix-1;
        sigmaX2 = sum(sx(ix:end)) / (n-r1Test);
        MxSR = Ux*diag([ones(1,r1Test) sx(ix:end)'.^(1/2)/sqrt(sigmaX2)])*Ux';
        
        if ix > n
            prodOverSumSmallestX = 1;
        else
            prodOverSumSmallestX = prod(sx(ix:end))...
                / (sigmaX2)^(n-ix-1);
        end

        for iy = 1:m+1
            r2Test = iy - 1;
            sigmaY2 = sum(sy(iy:end)) / (m-r2Test);
            MySR = Uy*diag([ones(1,r2Test) sy(iy:end)'.^(1/2)/sqrt(sigmaY2)])*Uy';
            
            if iy > m
                prodOverSumSmallestY = 1;
            else
                prodOverSumSmallestY = prod(sy(iy:end))...
                    / (sigmaY2)^(m-iy-1);
            end
            
            % not that much extra work to check all combinations (r1,r2) vs
            % check whether we should only once per 'for' loop
            LIKwaxIndiv = -(M*detPower)*log(prodOverSumSmallestX*prodOverSumSmallestY);
            terms_waxIndiv = numModelTerms_waxIndiv(n,m,ix-1,iy-1);

            AIC_waxIndiv(ix,iy) = 2*LIKwaxIndiv + 2*terms_waxIndiv;
            BIC_waxIndiv(ix,iy) = LIKwaxIndiv + log(M)/2*terms_waxIndiv;
            
            if AIC_waxIndiv(ix,iy) < currentMin(5)
                currentMinIndx(1:2,5) = [ix-1;iy-1];
                currentMin(7) = min(currentMin(7), AIC_waxIndiv(ix,iy));
            end
            if BIC_waxIndiv(ix,iy) < currentMin(6)
                currentMinIndx(1:2,6) = [ix-1;iy-1];
                currentMin(6) = min(currentMin(6), BIC_waxIndiv(ix,iy));
            end

            
            RxPIsqrSR = Ux*diag(sqrt(vPSinv([sx(1:r1Test); repmat(sigmaX2,n-r1Test,1)])))*Ux';
            RyPIsqrSR = Uy*diag(sqrt(vPSinv([sy(1:r2Test); repmat(sigmaY2,m-r2Test,1)])))*Uy';
            
            [FrSR,SxySR,GrSR] = svd(RxPIsqrSR*Rxy*RyPIsqrSR);
            sxySR = diag(SxySR);
            
            gammaXsr = diag(FrSR'*(MxSR*MxSR')*FrSR);gammaXsr = gammaXsr(1:p);
            gammaYsr = diag(GrSR'*(MySR*MySR')*GrSR);gammaYsr = gammaYsr(1:p);
            
            traceTermProd = sxySR.^2./(1-sxySR.^2) .* (gammaYsr + gammaXsr - 2);%(gammaXsr./sxySR.^2 + gammaYsr - 2);
            
            for ixy = 1:min(ix,iy)
                r3Test = ixy - 1;
                
                if ix == 1 && iy == 1 % only need to check the sample CC's, no need to loop over ix, iy
                    LIKcrossOnly = (M*detPower)*log(prod(1-sxy(1:ixy-1).^2));
                    terms_crossOnly = numModelTerms_crossOnly(n,m,r3Test);
                    AIC_crossOnly(ixy) = 2*LIKcrossOnly + 2*terms_crossOnly;
                    BIC_crossOnly(ixy) = LIKcrossOnly + log(M)/2*terms_crossOnly;
                    
                    if AIC_crossOnly(ixy) < currentMin(7)
                        currentMinIndx(3,7) = ixy-1;
                        currentMin(7) = min(currentMin(7), AIC_crossOnly(ixy));
                    end
                    if BIC_crossOnly(ixy) < currentMin(8)
                        currentMinIndx(3,8) = ixy-1;
                        currentMin(8) = min(currentMin(8), BIC_crossOnly(ixy));
                    end
                end
                
                % Likelihood Wax-like joint criterion
                traceTerms_alignCoeff = sum(traceTermProd(1:r3Test));

                if all(sxySR <= 1)
                    % Likelihoods for different criteria...
                    % normally would be, max: -M*log(1/f)-r3 => min: -M*log(f)+r3
                    LIKfSigSR = -(M*detPower)*log(prodOverSumSmallestX*prodOverSumSmallestY/prod(1-sxySR(1:ixy-1).^2))...
                        + traceCoeff*traceTerms_alignCoeff;
                    
                    LIKxFitSR = (M*detPower)*log(prod(1-sxySR(1:ixy-1).^2)) ...
                        + traceCoeff*traceTerms_alignCoeff;
                else
                    % Likelihoods - the likelihoods should not be able to model
                    % CC's with values larger than one
                    LIKfSigSR = inf;
                    LIKxFitSR = inf;
                end
                
                terms_fSigSR = numModelTerms_fSigSR(n,m,r1Test,r2Test,r3Test);
                terms_xFitSR = numModelTerms_xFitSR(n,m,r1Test,r2Test,r3Test);
                
                % Find criteria -> -(Likelihood - Penalty)
                AIC_fSigSR(ix,iy,ixy) = ...IC(1);
                    2*LIKfSigSR + 2*terms_fSigSR;
                BIC_fSigSR(ix,iy,ixy) = ...IC(2);
                    LIKfSigSR + log(M)/2*terms_fSigSR;
                
                % Test corrected AIC
                %             AIC_Corrected_fSig(ix,iy,ixy) = ...  % AICc signal fit
                %                             2*LIKfSigSR + 2*M*(terms_fSigSR+1)/(M-terms_fSigSR-2);
                %             AIC_Corrected_xFit(ix,iy,ixy) = ...  % AICc error fit
                %                             2*LIKxFitSR  + 2*M*(terms_xFitSR+1)/(M-terms_xFitSR-2);
                
                AIC_XFitSR(ix,iy,ixy) = 2*LIKxFitSR + 2*terms_xFitSR;
                BIC_XFitSR(ix,iy,ixy) =   LIKxFitSR + log(M)/2*terms_xFitSR;
                
                % Update the minimum IC
                if AIC_fSigSR(ix,iy,ixy) < currentMin(1)
                    currentMinIndx(:,1) = [ix-1;iy-1;ixy-1];
                    currentMin(1) = min(currentMin(1), AIC_fSigSR(ix,iy,ixy));
                end
                if BIC_fSigSR(ix,iy,ixy) < currentMin(2)
                    currentMinIndx(:,2) = [ix-1;iy-1;ixy-1];
                    currentMin(2) = min(currentMin(2), BIC_fSigSR(ix,iy,ixy));
                end
                
                if AIC_XFitSR(ix,iy,ixy) < currentMin(3)
                    currentMinIndx(:,3) = [ix-1;iy-1;ixy-1];
                    currentMin(3) = min(currentMin(3), AIC_XFitSR(ix,iy,ixy));
                end
                if BIC_XFitSR(ix,iy,ixy) < currentMin(4)
                    currentMinIndx(:,4) = [ix-1;iy-1;ixy-1];
                    currentMin(4) = min(currentMin(4), BIC_XFitSR(ix,iy,ixy));
                end
                
            end
        end
    end
end
% fprintf('\nAverage time to generate model xcov: %g (x %dx%d iterative checks) = total: %d sec\n',timeToGenXcov/(n*m),n,m,timeToGenXcov)
% fprintf(repmat('\b',1,length(s)+1))
if nargout == 0
    % check Max values
    minAICw = min(min(min(AIC_fSigSR)));
    minBICw = min(min(min(BIC_fSigSR)));
    minAICx = min(min(min(AIC_XFitSR)));
    minBICx = min(min(min(BIC_XFitSR)));
    minAICi = min(min(AIC_waxIndiv));
    minBICi = min(min(BIC_waxIndiv));
    minAICo = min(AIC_crossOnly);
    minBICo = min(BIC_crossOnly);
    
    
    currentMin
    if any(abs([minAICw minBICw minAICx minBICx minAICi minBICi minAICo minBICo] - currentMin) > 1e-6)
        warning('recording of minimum is inaccurate');
        [minAICw minBICw minAICx minBICx minAICi minBICi minAICo minBICo]
    end

%     fprintf('\nTrue model order is: q1=%d, q2=%d (orthog comp in Rx, Ry), q3=%d (cross terms)\n',[q1true;q2true;q3true])
    fprintf('\nAIC: fSig-SR:  r1=%d, r2=%d, r3=%d\n',currentMinIndx(:,1))
    fprintf('BIC: fSig-SR:  r1=%d, r2=%d, r3=%d\n',currentMinIndx(:,2))
    fprintf('AIC: xFit-SR:  r1=%d, r2=%d, r3=%d\n',currentMinIndx(:,3))
    fprintf('BIC: xFit-SR:  r1=%d, r2=%d, r3=%d\n',currentMinIndx(:,4))
    fprintf('AIC: indv chan:r1=%d, r2=%d       \n',currentMinIndx(1:2,5))
    fprintf('BIC: indv chan:r1=%d, r2=%d,      \n',currentMinIndx(1:2,6))
    fprintf('AIC: crossOnly:              r3=%d\n',currentMinIndx(3,7))
    fprintf('BIC: crossOnly:              r3=%d\n',currentMinIndx(3,8))
    

%     plotICresults(p,AIC_fSigSR,BIC_fSigSR,AIC_XFitSR,BIC_XFitSR,AIC_waxIndiv,BIC_waxIndiv,AIC_crossOnly,BIC_crossOnly...
%         {'AIC:SigSR','BIC:SigSR','AIC:xfitSR','BIC:xfitSR','AIC:indv','BIC:indv','AIC:crossOnly','BIC:crossOnly'})
    
elseif nargout == 1
    if nargin < 5
        orderEst = currentMinIndx;
    else
        orderEst = currentMinIndx(:,ICtype);
    end
else
    if nargin < 5
        orderEst = currentMinIndx;
    else
        orderEst = currentMinIndx(:,ICtype);
    end
    varargout{1} = diag(K); % provides 'corrs' return variable
end



