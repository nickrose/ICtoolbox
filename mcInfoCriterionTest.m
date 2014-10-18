function mcInfoCriterionTest(varargin)
% Simulation Monte-Carlo test of model order detection
%
% INPUT: prefScenSelect - a selection parameter for which scenario of
%                         interest to execute
%
% ICresults (optional): 
%   rows (r1,r2,r3), 
%   cols (AIC_wax_fs, BIC_wax_fs, AIC_pca_fs,BIC_pca_fs,
%       AIC_wax_e, BIC_wax_e, AIC_pca_e, BIC_pca_e), 
%   layers (tensor dim 3) (variation in scenario being tested)
%
% Utilizes 'matlab2tikz' library which can be found:
% 
%
% Jan 2014, heavily modified July-September 2014.
% 
% ICtoolbox  Copyright (C) 2014 Nicholas Roseveare
%     This program comes with ABSOLUTELY NO WARRANTY; for details see the LICENSE file
%     This is free software, and you are welcome to redistribute it
%     under certain conditions; see LICENSE file for conditions
%
mat2tikzSrc = '../../library/matlab2tikz_0.4.7/src/';
mat2tikzTools = '../../library/matlab2tikz_0.4.7/tools/';

plots = 1;
debug = 0;
executeSimulation = 1;
prefScenSelect = 0;
if nargin ~= 0 && isscalar(varargin{1})
    prefScenSelect = varargin{1};
    %prefScenSelect used in the following script to initialize all params
    loadParamsPCAccaTest;
    plots = 0;
elseif nargin ~= 0 && ischar(varargin{1})
    load(varargin{1})
    prefScenSelect = -1;
    executeSimulation = 0;
    plots = 1;
end
% don't let these parameters be overridden by a 'load()'
tikzOutput = 0;
subselect = [];
offsetClrMkr = 0;
offsetSize = 0;
baseSizeLW = 3;
baseSizeMark = 5;
markSizeStep = 3;
if tikzOutput
    baseSizeLW = 2;
    baseSizeMark = 7;
    markSizeStep = 2;
else
    saveExtension = 'pdf';%'psc2';
    fileExtension = 'pdf';%'eps'
end
        
if nargin == 0 || prefScenSelect == 0
    testList = {'Samples','CrossTermSigPow',...
        'VaryGenPow','SNR',...
        'DimSampConst', 'NumSigs','NumCrossSig'};
    changeAlong =  testList{1};
    field = 'real';
    n = 10;
    m = 8;
    q1true = 3;
    q2true = 2;
    q3true = 3;
    SigX2 = 10;
    SigY2 = 10; % for 'CrossTermSigPow': X and Y indep term power set equal
    CrossTermPow = [4 6 12]';
    M = 10*n;
    
    numMCruns = 100;
    numTests = 15;
    
    % Generic Vary Power
    termToVary = 'CrossTermPow(1)';
    termToVaryAround = 'SigX2(1)';
    dbHalfRangeGenVary = 1;% 1 means it will vary power from -1 dB to +1 dB
    
    % scenario specific parameters
    % SNR
    dbHalfRange = 1; % 1 means it will vary power from -1 dB to +1 dB
    
    % Dim/sample ratio fixed
    maxDim = 300;
    cRatio = 0.8;
    
    % plotting parameters
    plots = 1;
    modString = '';%'_newXfitTest04032014';
    % use to offset color and line types
    offset = 0;
end

if executeSimulation
    compareThese = [1 2 3 4];
    numToPlot    = length(compareThese);
    
    lgndItemsAll = {...
        'AIC: Signal Fit','BIC: Signal Fit',...
        'AIC: Error Fit','BIC: Error Fit',...
        'AIC: Indiv Fit','BIC:Indiv Fit',...
        'AIC: Cross Only','BIC: Cross Only'...
        };
    
    lgndItems = lgndItemsAll(compareThese);
    if prefScenSelect > 0
        scenNumStr = ['_scNum' num2str(prefScenSelect)];
    else
        scenNumStr = '';
    end
    switch changeAlong % == notice the various parameter settings within ==
        case 'Samples'
            xLabelString = 'Ratio of Samples to Largest Dimension (M/n)';
            testNum = logspace(log10(3),3,numTests);
            detailsStr = sprintf('%s_sc%dsx%dsy%d_x%dy%dc%d_n%dm%d_%dMC',scenNumStr,round(max(CrossTermPow)),round(max(SigX2)),round(max(SigY2)),q1true,q2true,q3true,n,m,numMCruns);
            
        case 'CrossTermSigPow'
            xLabelString = 'Cross term to largest indep term Signal Power ( \sigma_{sc}^2 /\sigma_{sx}^2)';
            testNum = logspace(-1,1,numTests);
            detailsStr = sprintf('%s_sx%dsy%dsxy%d_x%dy%dc%d_n%dm%dM%d_%dMC',scenNumStr,round(max(SigX2)),round(max(SigY2)),round(max(CrossTermPow)),q1true,q2true,q3true,n,m,M,numMCruns);
            
        case 'VaryGenPow'
            % Uses termToVary and termToVaryAround
            xLabelString = 'Cross term to largest indep term Signal Power ( \sigma_{sc}^2 /\sigma_{sx}^2)';
            testNum = logspace(-dbHalfRangeGenVary,dbHalfRangeGenVary,numTests);
            detailsStr = sprintf('%s_sx%dsy%dsxy%dvary%sUM%s_x%dy%dc%d_n%dm%dM%d_%dMC',scenNumStr,round(max(SigX2)),round(max(SigY2)),round(max(CrossTermPow)),termToVary,termToVaryAround,q1true,q2true,q3true,n,m,M,numMCruns);
            
        case 'SNR'
            xLabelString = 'SNR (\sigma_{s}^2 /\sigma_{n}^2)';
            SigX2orig = SigX2;
            SigY2orig = SigY2;
            CrossTermPowOrig = CrossTermPow;
            testNum = logspace(-dbHalfRange,dbHalfRange,numTests);
            detailsStr = sprintf('%s_sc%dsx%dsy%d_x%dy%dc%d_n%dm%dM%d_%dMC',scenNumStr,round(max(CrossTermPow)),round(max(SigX2)),round(max(SigY2)),q1true,q2true,q3true,n,m,M,numMCruns);
            
        case 'DimSampConst'
            % vary the dimension - uses maxDim and cRatio
            testNum = round(logspace(1,log10(maxDim),numTests));%max(numTests-5,10)
            
            nOrig = n;
            mOrig = m;
            xLabelString = sprintf('Composite dim (n+m), c=(n+m)/M=%1.2g',cRatio);
            detailsStr = sprintf('%s_sc%dsx%dsy%d_x%dy%dc%d_cRat%1.2g_%dMC',scenNumStr,round(max(CrossTermPow)),round(max(SigX2)),round(max(SigY2)),q1true,q2true,q3true,cRatio,numMCruns);
            
        case 'NumSigs'
            % it is useful to set n,m very large, otherwise there will be few
            % interest datapoints
            xLabelString = 'Signal multiplier (d)';
            q1Orig = q1true;
            q2Orig = q2true;
            q3Orig = q3true;
            testNum = round(linspace(1,max(m,n)/(q1true+q2true+q3true),numTests));
            detailsStr = sprintf('%s_sc%dsx%dsy%d_x%dy%dc%d_n%dm%dM%d_%dMC',scenNumStr,round(max(CrossTermPow)),round(max(SigX2)),round(max(SigY2)),q1true,q2true,q3true,n,m,M,numMCruns);
            
        case 'NumCrossSig'
            xLabelString = 'No. of Cross Terms (q_3)';
            testNum = 0:(min(n-q1true,m-q2true)-1);
            numTests = length(testNum);
            detailsStr = sprintf('%s_sc%dsx%dsy%d_x%dy%dc%d_n%dm%dM%d_%dMC',scenNumStr,round(max(CrossTermPow)),round(max(SigX2)),round(max(SigY2)),q1true,q2true,q3true,n,m,M,numMCruns);
            
    end
    
    
    ICresults = zeros(3,numToPlot,numTests);
    probError = zeros(3,numToPlot,numTests);
    
    sp = sprintf('scenario %d of %d, MC run no. %d of %d',1,numTests,1,numMCruns);
    fprintf(['\n' sp]);
    averageCCorr = 0;
    for Tidx = 1:numTests
        switch changeAlong
            case 'Samples'
                M = round(testNum(Tidx)*n);
            case 'CrossTermPow'
                CrossTermPow = testNum(Tidx)*SigX2;
                SigY2 = SigX2;
            case 'VaryGenPow'
                % should be e.g., CrossTermPow = testNum(Tidx)*SigX2;
                eval([termToVary,' = testNum(Tidx)*',termToVaryAround,';']);
            case 'SNR'
                xLabelString = 'SNR (\sigma_{s}^2 /\sigma_{n}^2)';
                SigX2 = testNum(Tidx)*SigX2orig;
                SigY2 = testNum(Tidx)*SigY2orig;
                CrossTermPow = testNum(Tidx)*CrossTermPowOrig;
            case 'DimSampConst'
                n = round(nOrig*testNum(Tidx)/testNum(1));
                m = round(mOrig*testNum(Tidx)/testNum(1));
                M = round((n+m)/cRatio);
                xLabelString = sprintf('Composite dim d*(n+m): d s.t. c=d*(n+m)/M=%1.2g',cRatio);
            case 'NumSigs'
                xLabelString = 'Signal multiplier (d)';
                q1true = q1Orig*testNum(Tidx);
                q2true = q2Orig*testNum(Tidx);
                q3true = q3Orig*testNum(Tidx);
            case 'NumCrossSig'
                q3true = testNum(Tidx);
                CrossTermPow = max(CrossTermPow);
        end
        
        if length(SigX2) == 1
            xFitq1trueX = q3true + sum(min(CrossTermPow) < SigX2)*q1true;
        else
            xFitq1trueX = q3true + sum(min(CrossTermPow) < SigX2);
        end
        if length(SigY2) == 1
            xFitq2trueY = q3true + sum(min(CrossTermPow) < SigY2)*q2true;
        else
            xFitq2trueY = q3true + sum(min(CrossTermPow) < SigY2);
        end
        
        TheAnswer = [repmat( [q1true+q3true ;...
            q2true+q3true;...
            q3true]       ,1,4), ...
            repmat( [xFitq1trueX ;...
            xFitq2trueY;...
            q3true]       ,1,4)];
        TheAnswer = TheAnswer(:,compareThese);
        
        for mc = 1:numMCruns
            s = sprintf('scenario %d of %d, MC run no. %d of %d',Tidx,numTests,mc,numMCruns);
            fprintf([repmat('\b',1,length(sp)) s])
            sp = s;
            
            % Run simulated data and obtain criteria outputs
            [X,Y] =     twoChannelSystem(M,n,m,q1true,q2true,q3true,SigX2,SigY2,CrossTermPow,'var',field);
            modOrderEstm = infoCriterion(M,field,X,Y);
            
            ICresults(:,:,Tidx) = ICresults(:,:,Tidx) + modOrderEstm(:,compareThese);
            probError(:,:,Tidx) = probError(:,:,Tidx) + (modOrderEstm(:,compareThese)~=TheAnswer);
        end
    end
    fprintf(repmat('\b',1,1+length(sp)))
    
    ICresults = ICresults/numMCruns;
    probError = probError/numMCruns;
end

%% Plot results
if ~plots
    if prefScenSelect > 0
        save(sprintf('mc_infoCrit_data_scNum%d',prefScenSelect))
    else
        save('mc_infoCrit_data')
    end
else
    
    linColors = lines;
    randColorMix = randn(7);
    randColorMix = randColorMix*randColorMix';
    [randColorMix,s,d]=svd(randColorMix);
    randColorMix = abs(randColorMix)./(repmat(sum(abs(randColorMix),1),7,1));
    
    linColors = [eye(7) randColorMix; zeros(size(linColors,1)-7,14)]'*linColors;
    lintype = {'-','-.','--',':','-','-.','--',':','-','-.'};

    
    % subselect the data (if desired)
    if exist('subselect','var') && ~isempty(subselect)
        try
            lgndItems = lgndItems(subselect);
            ICresults = ICresults(:,subselect,:);
            probError = probError(:,subselect,:);
        catch
            error('mcICsim:invalidSubIndx','The subselection does not exist for this data set, check the dimesion of the IC results before subselect and the call to the plotter');
        end
    end
    if any(strcmp(changeAlong,{'CrossTermPow'}))
        xLevels = 1:3:10;
        numXlev = length(xLevels);
        kis = zeros(numXlev,numTests);
        legendKis = cell(1,numXlev);
        for sigIdx = 1:numXlev
            sigmaX2 = xLevels(sigIdx);
%             kis(sigIdx,:) = (testNum)./((1+testNum)+1/(sigmaX2)); % sc shares column space with sx
            kis(sigIdx,:) = (testNum)./((testNum)+1/(sigmaX2)); % non-shared column space
            legendKis{sigIdx} = sprintf('\\sigma_{sx}^2 = %d',sigmaX2);
        end
        figure(7)
        semilogx(repmat(testNum,numXlev,1)',kis','LineWidth',3)
        legend(legendKis,'Location','Best','FontSize',15)
        xlabel(xLabelString,'FontSize',16)
        ylabel('k_i (ideal)','FontSize',16)
        set(gca,'FontSize',16)
        if tikzOutput
            addpath(mat2tikzSrc,mat2tikzTools)
            matlab2tikz(sprintf('modelOrderTest_ccCoeff_ideal.tikz',changeAlong,modString,detailsStr))
        else
            saveas(gcf,sprintf('modelOrderTest_ccCoeff_ideal.%s',fileExtension),saveExtension)
        end
    end
    
    figure(5)
    hold off;
    estmPlotHeight = round(1.5*max(q3true+q2true,q3true+q1true));
    % plot all methods
    bgstLS = .5*(offsetSize+offsetClrMkr+length(lgndItems))+baseSizeLW;
    biggestMSize = (offsetSize+offsetClrMkr+length(lgndItems))*markSizeStep + baseSizeMark;
    theAns = repmat([q1true+q3true ;...
        q2true+q3true;...
        q3true],1,2);
    ansXrange = repmat([testNum(1) testNum(end)],3,1);
    if ~any(strcmp(changeAlong,{'NumSigs','NumCrossSig'})) % 'SNR','Samples','CrossTermSigPow','VaryGenPow', 'DimSampConst'
        for k = 1:length(lgndItems)
            result = reshape(ICresults(:,k,:),3,numTests);
            semilogx(testNum,result(1,:),[lintype{k+offsetClrMkr}],'Color',linColors(k+offsetClrMkr,:),'MarkerSize',biggestMSize-markSizeStep*(k+offsetClrMkr),'LineWidth',bgstLS-(k+offsetClrMkr)/2);hold on;
        end
        semilogx(ansXrange', theAns','-','Color',[.4 .4 .4],'LineWidth',bgstLS);hold on;
        
        for k = 1:length(lgndItems)
            result = reshape(ICresults(:,k,:),3,numTests);
            
            semilogx(testNum,result(1,:),['s' lintype{k+offsetClrMkr}],'Color',linColors(k+offsetClrMkr,:),'MarkerSize',biggestMSize-markSizeStep*(k+offsetClrMkr),'LineWidth',bgstLS-(k+offsetClrMkr)/2);hold on;
            semilogx(testNum,result(2,:),['o' lintype{k+offsetClrMkr}],'Color',linColors(k+offsetClrMkr,:),'MarkerSize',biggestMSize-markSizeStep*(k+offsetClrMkr),'LineWidth',bgstLS-(k+offsetClrMkr)/2);hold on;
            semilogx(testNum,result(3,:),['x' lintype{k+offsetClrMkr}],'Color',linColors(k+offsetClrMkr,:),'MarkerSize',biggestMSize-markSizeStep*(k+offsetClrMkr),'LineWidth',bgstLS-(k+offsetClrMkr)/2);hold on;
        end
    else % 'NumSigs','NumCrossSig'
        for k = 1:length(lgndItems)
            result = reshape(ICresults(:,k,:),3,numTests);
            plot(testNum,result(1,:),[lintype{(k+offsetClrMkr)}],'Color',linColors((k+offsetClrMkr),:),'MarkerSize',biggestMSize-markSizeStep*(k+offsetClrMkr),'LineWidth',bgstLS-(k+offsetClrMkr)/2);hold on;
        end
        for k = 1:length(lgndItems)
            result = reshape(ICresults(:,k,:),3,numTests);
            
            plot(testNum,result(1,:),['s' lintype{(k+offsetClrMkr)}],'Color',linColors((k+offsetClrMkr),:),'MarkerSize',biggestMSize-markSizeStep*(k+offsetClrMkr),'LineWidth',bgstLS-(k+offsetClrMkr)/2);hold on;
            plot(testNum,result(2,:),['o' lintype{(k+offsetClrMkr)}],'Color',linColors((k+offsetClrMkr),:),'MarkerSize',biggestMSize-markSizeStep*(k+offsetClrMkr),'LineWidth',bgstLS-(k+offsetClrMkr)/2);hold on;
            plot(testNum,result(3,:),['x' lintype{(k+offsetClrMkr)}],'Color',linColors((k+offsetClrMkr),:),'MarkerSize',biggestMSize-markSizeStep*(k+offsetClrMkr),'LineWidth',bgstLS-(k+offsetClrMkr)/2);hold on;
        end
    end
    ax = axis;
    if debug
        ax(4) = max(n,m);
    else
        ax(4) = estmPlotHeight;
    end
    if testNum(1)==testNum(end)
        ax(1:2) = [testNum(1) testNum(end)*1.2]; axis(ax);
    else
        ax(1:2) = [testNum(1) testNum(end)*1.2]; axis(ax);
    end
    
    if debug
        title(regexprep(detailsStr(2:end),'_','-'))
    end
    
    xlabel(xLabelString,'FontSize',16)
    ylabel('Model Order Selected','FontSize',16)
    legend(lgndItems,'Location','Best','FontSize',16)
    set(gca,'FontSize',16)
    % legend('Rx model order estm','Ry model order estm','Cross term model order estm')
    hold off;

    if tikzOutput
        addpath(mat2tikzSrc,mat2tikzTools)
        matlab2tikz(sprintf('modelOrderTest_along%s%s_estmOrd_%s.tikz',changeAlong,modString,detailsStr))
    else
        saveas(gcf,sprintf('modelOrderTest_along%s%s_estmOrd_%s.%s',changeAlong,modString,detailsStr,fileExtension),saveExtension)
    end
    
    if ~debug && ~any(strcmp(changeAlong,{'NumSigs','NumCrossSig'})) % 'SNR','Samples','CrossTermSigPow','VaryGenPow','DimSampConst'
        figure(6);
        hold off;
        % Plot probability of error
        for k = 1:length(lgndItems)
            result = reshape(probError(:,k,:),3,numTests);
            semilogx(testNum,result(1,:),[lintype{(k+offsetClrMkr)}],'Color',linColors((k+offsetClrMkr),:),'MarkerSize',biggestMSize-markSizeStep*(k+offsetClrMkr),'LineWidth',bgstLS-(k+offsetClrMkr)/2);hold on;
        end
        for k = 1:length(lgndItems)
            result = reshape(probError(:,k,:),3,numTests);
            
            semilogx(testNum,result(1,:),['s' lintype{(k+offsetClrMkr)}],'Color',linColors((k+offsetClrMkr),:),'MarkerSize',biggestMSize-markSizeStep*(k+offsetClrMkr),'LineWidth',bgstLS-(k+offsetClrMkr)/2);hold on;
            semilogx(testNum,result(2,:),['o' lintype{(k+offsetClrMkr)}],'Color',linColors((k+offsetClrMkr),:),'MarkerSize',biggestMSize-markSizeStep*(k+offsetClrMkr),'LineWidth',bgstLS-(k+offsetClrMkr)/2);hold on;
            semilogx(testNum,result(3,:),['x' lintype{(k+offsetClrMkr)}],'Color',linColors((k+offsetClrMkr),:),'MarkerSize',biggestMSize-markSizeStep*(k+offsetClrMkr),'LineWidth',bgstLS-(k+offsetClrMkr)/2);hold on;
        end
        ax = axis;
        if testNum(1)==testNum(end)
            ax(1:2) = [testNum(1) testNum(end)*1.2]; axis(ax);
        else
            ax(1:2) = [testNum(1) testNum(end)*1.2]; axis(ax);
        end
         ax(1:2) = [testNum(1) testNum(end)]; axis(ax);
        xlabel(xLabelString,'FontSize',16)
        ylabel('Probability of Error','FontSize',16)
        legend(lgndItems,'Location','Best','FontSize',16)
        set(gca,'FontSize',16)
        hold off;
        
        if tikzOutput
            matlab2tikz(sprintf('modelOrderTest_along%s%s_probError_%s.tikz',changeAlong,modString,detailsStr))
        else
            saveas(gcf,sprintf('modelOrderTest_along%s%s_probError_%s.eps',changeAlong,modString,detailsStr),'psc2')
        end
    end
end
