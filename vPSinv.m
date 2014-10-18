function x = vPSinv(x)
% vPSinv.m - vector pseudo-inverse
% USAGE: 
%  x = vPSinv(x)
%  x is the vector on which to perform pseudo-inverse
%
% ICtoolbox  Copyright (C) 2014 Nicholas Roseveare
%     This program comes with ABSOLUTELY NO WARRANTY; for details see the LICENSE file
%     This is free software, and you are welcome to redistribute it
%     under certain conditions; see LICENSE file for conditions
%

x(abs(x)>1e-10) = 1./x(abs(x)>1e-10);