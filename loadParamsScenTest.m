% loadParamsScenTest.m
%
% The purpose of this script is to provide a fixed set of setups for
% various interesting test cases of the two-channel model ID information
% criteria.
%
% September 2014 (modified from loadParamsPCAccaTest.m)
%
% ICtoolbox  Copyright (C) 2014 Nicholas Roseveare
%     This program comes with ABSOLUTELY NO WARRANTY; for details see the LICENSE file
%     This is free software, and you are welcome to redistribute it
%     under certain conditions; see LICENSE file for conditions
%

% need to have prefScenSelect defined, otherwise return with it set to zero
if ~exist('prefScenSelect','var') || prefScenSelect == 0
    prefScenSelect = 0;
else
    % The 'changeAlong' list corresponds to the type of test, we index
    % this list as
    % 'Samples'--------- 1
    % 'CrossTermPow'- 2
    % 'VaryGenPow'------ 3
    % 'SNR'------------- 4
    % 'DimSampConst'---- 5
    % 'NumSigs'--------- 6
    % 'NumCrossSig'----- 7
    
    testList = {'Samples','CrossTermPow',...
                'VaryGenPow','SNR',...
                'DimSampConst', 'NumSigs','NumCrossSig'};
    
    % parameters for all scenarios
    numMCruns = 100;
    numTests = 15;
    field = 'real';
    
    % plotting parameters for later
    modString = '';
    % use to offset color and line types
    offset = 0;
    
    switch prefScenSelect
    % =======================================
    % 'Samples' tests
    % =======================================
        case 11
            changeAlong =  testList{1};
            n = 20;
            m = 18;
            q1true = 3;
            q2true = 2;
            q3true = 4;
            SigX2 = 5;
            SigY2 = 5; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 2;
        case 111
            changeAlong =  testList{1};
            n = 10;%20;
            m = 8;%18;
            q1true = 1;
            q2true = 2;
            q3true = 1;
            SigX2 = 10;
            SigY2 = 10; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 8;
        case 112
            changeAlong =  testList{1};
            n = 10;%20;
            m = 8;%18;
            q1true = 1;
            q2true = 2;
            q3true = 1;
            SigX2 = 3;
            SigY2 = 3; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 5;

        % Test cases run 22/8/14-25/8/14    
        case 121
            changeAlong =  testList{1};
            n = 20;
            m = 25;
            q1true = 2;
            q2true = 3;
            q3true = 3;
            SigX2 = 10;
            SigY2 = 10; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 8;
        case 122
            changeAlong =  testList{1};
            n = 20;
            m = 25;
            q1true = 2;
            q2true = 3;
            q3true = 3;
            SigX2 = 5;
            SigY2 = 5; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 4;
        case 123
            changeAlong =  testList{1};
            n = 20;
            m = 25;
            q1true = 7;
            q2true = 8;
            q3true = 4;
            SigX2 = 10;
            SigY2 = 10; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 8;
        case 124
            changeAlong =  testList{1};
            n = 20;
            m = 25;
            q1true = 7;
            q2true = 8;
            q3true = 4;
            SigX2 = 10;
            SigY2 = 10; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 8;
        
        case 131
            changeAlong =  testList{1};
            n = 25;
            m = 25;
            q1true = 2;
            q2true = 3;
            q3true = 3;
            SigX2 = 10;
            SigY2 = 10; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 8;
        case 132
            changeAlong =  testList{1};
            n = 25;
            m = 25;
            q1true = 2;
            q2true = 3;
            q3true = 3;
            SigX2 = 5;
            SigY2 = 5; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 4;
        case 133
            changeAlong =  testList{1};
            n = 25;
            m = 25;
            q1true = 7;
            q2true = 8;
            q3true = 4;
            SigX2 = 10;
            SigY2 = 10; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 8;
        case 134
            changeAlong =  testList{1};
            n = 25;
            m = 25;
            q1true = 7;
            q2true = 8;
            q3true = 4;
            SigX2 = 5;
            SigY2 = 5; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 4;
            
        case 141
            changeAlong =  testList{1};
            n = 40;
            m = 35;
            q1true = 3;
            q2true = 2;
            q3true = 4;
            SigX2 = 10;
            SigY2 = 10; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 8;
        case 142
            changeAlong =  testList{1};
            n = 40;
            m = 35;
            q1true = 3;
            q2true = 2;
            q3true = 4;
            SigX2 = 5;
            SigY2 = 5; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 4;
        case 143
            changeAlong =  testList{1};
            n = 40;
            m = 35;
            q1true = 16;
            q2true = 10;
            q3true = 7;
            SigX2 = 10;
            SigY2 = 10; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 8;
        case 144
            changeAlong =  testList{1};
            n = 40;
            m = 35;
            q1true = 16;
            q2true = 10;
            q3true = 7;
            SigX2 = 5;
            SigY2 = 5; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 4;
            
        case 151
            changeAlong =  testList{1};
            n = 40;
            m = 40;
            q1true = 3;
            q2true = 2;
            q3true = 4;
            SigX2 = 10;
            SigY2 = 10; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 8;
        case 152
            changeAlong =  testList{1};
            n = 40;
            m = 40;
            q1true = 3;
            q2true = 2;
            q3true = 4;
            SigX2 = 5;
            SigY2 = 5; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 4;
        case 153
            changeAlong =  testList{1};
            n = 40;
            m = 40;
            q1true = 16;
            q2true = 10;
            q3true = 7;
            SigX2 = 10;
            SigY2 = 10; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 8;
        case 154
            changeAlong =  testList{1};
            n = 40;
            m = 40;
            q1true = 16;
            q2true = 10;
            q3true = 7;
            SigX2 = 5;
            SigY2 = 5; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = 4;
        % =====================================================    
        % Test cases run 26/8/14-
% MISMATCHED DIM     
   % LOW SNR
        % signal to dim ratio .1 -> .6 (x,y both); (few corr sigs)
        case 1611
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 3;q2true = 2;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))';
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1612
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 9;q2true = 7;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1613
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 15;q2true = 11;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        % signal to dim ratio .1 -> .6 (x,y both); (many corr sigs)
        case 1614
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 3;q2true = 2;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1615
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 9;q2true = 7;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1616
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 15;q2true = 11;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        % signal to dim ratio .1 -> .6 x,y fixed low; (few corr sigs)
        case 1621
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 3;q2true = 4;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1622
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 9;q2true = 4;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1623
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 15;q2true = 4;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        % signal to dim ratio .1 -> .6 x,y fixed low; (many corr sigs)
        case 1624
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 3;q2true = 4;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1625
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 9;q2true = 4;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1626
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 15;q2true = 4;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        
        % signal to dim ratio .1 -> .6 x,y fixed large; (few corr sigs)
        case 1631
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 3;q2true = 9;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1632
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 9;q2true = 9;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1633
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 15;q2true = 9;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        % signal to dim ratio .1 -> .6 x,y fixed large; (many corr sigs)
        case 1634
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 3;q2true = 9;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1635
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 9;q2true = 9;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1636
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 15;q2true = 9;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        

   % HIGH SNR
        % signal to dim ratio .1 -> .6 (x,y both); (few corr sigs)
        case 1711
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 3;q2true = 2;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1712
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 9;q2true = 7;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1713
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 15;q2true = 11;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        % signal to dim ratio .1 -> .6 (x,y both); (many corr sigs)
        case 1714
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 3;q2true = 2;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1715
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 9;q2true = 7;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1716
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 15;q2true = 11;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        
            
        % signal to dim ratio .1 -> .6 x,y fixed low; (few corr sigs)
        case 1721
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 3;q2true = 4;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1722
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 9;q2true = 4;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1723
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 15;q2true = 4;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        % signal to dim ratio .1 -> .6 x,y fixed low; (many corr sigs)
        case 1724
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 3;q2true = 4;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1725
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 9;q2true = 4;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1726
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 15;q2true = 4;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
        
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        % signal to dim ratio .1 -> .6 x,y fixed large; (few corr sigs)
        case 1731
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 3;q2true = 9;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1732
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 9;q2true = 9;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1733
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 15;q2true = 9;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        % signal to dim ratio .1 -> .6 x,y fixed large; (many corr sigs)
        case 1734
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 3;q2true = 9;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1735
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 9;q2true = 9;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1736
            changeAlong =  testList{1};
            n = 25; m = 19; q1true = 15;q2true = 9;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow = 8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        
% MATCHED DIM     
   % LOW SNR
        % signal to dim ratio .1 -> .6 (x,y both); (few corr sigs)
        case 1811
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 2;q2true = 2;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1812
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 8;q2true = 8;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1813
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 13;q2true = 13;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        % signal to dim ratio .1 -> .6 (x,y both); (many corr sigs)
        case 1814
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 2;q2true = 2;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1815
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 8;q2true = 8;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1816
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 13;q2true = 13;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        
        % signal to dim ratio .1 -> .6 x,y fixed low; (few corr sigs)
        case 1821
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 2;q2true = 4;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1822
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 8;q2true = 4;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1823
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 13;q2true = 4;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        % signal to dim ratio .1 -> .6 (x,y both); (many corr sigs)
        case 1824
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 2;q2true = 4;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1825
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 8;q2true = 4;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1826
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 13;q2true = 4;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
         
         
        % signal to dim ratio .1 -> .6 x,y fixed high; (few corr sigs)
        case 1831
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 2;q2true = 11;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1832
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 8;q2true = 11;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1833
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 13;q2true = 11;q3true = 2;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        % signal to dim ratio .1 -> .6 (x,y both); (many corr sigs)
        case 1834
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 2;q2true = 11;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1835
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 8;q2true = 11;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1836
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 13;q2true = 11;q3true = 6;
            SigX2init = 3;SigY2init = 3;CrossTermPow =2;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
         
  % HIGH SNR
        % signal to dim ratio .1 -> .6 (x,y both); (few corr sigs)
        case 1911
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 2;q2true = 2;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1912
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 8;q2true = 8;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1913
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 13;q2true = 13;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        % signal to dim ratio .1 -> .6 (x,y both); (many corr sigs)
        case 1914
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 2;q2true = 2;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1915
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 8;q2true = 8;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1916
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 13;q2true = 13;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        
        % signal to dim ratio .1 -> .6 x,y fixed low; (few corr sigs)
        case 1921
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 2;q2true = 4;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1922
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 8;q2true = 4;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1923
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 13;q2true = 4;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        % signal to dim ratio .1 -> .6 (x,y both); (many corr sigs)
        case 1924
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 2;q2true = 4;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1925
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 8;q2true = 4;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1926
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 13;q2true = 4;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
         
         
        % signal to dim ratio .1 -> .6 x,y fixed high; (few corr sigs)
        case 1931
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 2;q2true = 11;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1932
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 8;q2true = 11;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1933
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 13;q2true = 11;q3true = 2;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        % signal to dim ratio .1 -> .6 (x,y both); (many corr sigs)
        case 1934
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 2;q2true = 11;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
            
        case 1935
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 8;q2true = 11;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
        case 1936
            changeAlong =  testList{1};
            n = 22; m = 22; q1true = 13;q2true = 11;q3true = 6;
            SigX2init = 10;SigY2init = 10;CrossTermPow =8;% for 'CrossTermPow': X and Y indep term power set equal
            SigX2 = ((SigX2init-1+4/q1true):(4/q1true):(SigX2init+3))'; 
            SigY2 = ((SigY2init-1+4/q2true):(4/q2true):(SigY2init+3))';
         
            
    % =======================================
    % 'CrossTermPow' tests
    % =======================================
        case 21
            changeAlong =  testList{2};
            n = 10;
            m = 8;
            q1true = 3;
            q2true = 2;
            q3true = 3;
            SigX2 = 10;
            SigY2 = 10; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = [1 15 8]';
            M = 10*n;
    % =======================================
    % 'VaryGenPow' tests
    % =======================================
        case 31
            changeAlong =  testList{3};
            termToVary = 'CrossTermPow(1)';
            termToVaryAround = 'SigX2(1)';
            dbHalfRangeGenVary = 1;% 1 means it will vary power from -1 dB to +1 dB
            n = 20;
            m = 18;
            q1true = 3;
            q2true = 2;
            q3true = 3;
            SigX2 = 10;
            SigY2 = 10; 
            CrossTermPow = [1 15 7]';
            M = 10*n;
    % =======================================
    % 'SNR' tests
    % =======================================
        case 41
            changeAlong =  testList{4};

            dbHalfRange = 1; % 1 means it will vary power from -1 dB to +1 dB
            n = 20;
            m = 18;
            q1true = 3;
            q2true = 2;
            q3true = 3;
            SigX2 = 10;
            SigY2 = 10; 
            CrossTermPow = [2 8 15]';
            M = 10*n;
            
    % =======================================
    % 'DimSampConst' tests
    % =======================================
        case 51
            changeAlong =  testList{5};
            maxDim = 300;
            cRatio = 0.1;
            n = 10;
            m = 8;
            q1true = 4;
            q2true = 3;
            q3true = 3;
            SigX2 = 10;
            SigY2 = 10; 
            CrossTermPow = [1 15 8]';
            
    % =======================================
    % 'NumSigs' tests
    % =======================================
        case 61
            changeAlong =  testList{6};
            n = 40;
            m = 35;
            q1true = 2;
            q2true = 2;
            q3true = 1;
            SigX2 = 5;
            SigY2 = 5; 
            CrossTermPow = 8;
            M = 10*n;
            
    % =======================================
    % 'NumCrossSig' tests
    % =======================================
        case 71
            changeAlong =  testList{7};
            n = 40;
            m = 35;
            q1true = 3;
            q2true = 2;
            q3true = 3;
            SigX2 = 10;
            SigY2 = 10; % for 'CrossTermPow': X and Y indep term power set equal
            CrossTermPow = [1 15 8]';
            M = 10*n; 
            
    % =======================================
        otherwise
            disp('The index provided does not correspond to a valid scenario, try again with another number')
            break;
            
    end     
end
