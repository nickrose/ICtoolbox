function x = dPSinv(x)
% dPSinv.m - diagonal matrix pseudo-inverse.
% USAGE:
%   x = dPSinv(x)
%   x is the diagonal matrix; function operates by assuming diagonal,
%   inverse the vector of diagonals, and reforming the diagonal matrix.
%
% ICtoolbox  Copyright (C) 2014 Nicholas Roseveare
%     This program comes with ABSOLUTELY NO WARRANTY; for details see the LICENSE file
%     This is free software, and you are welcome to redistribute it
%     under certain conditions; see LICENSE file for conditions
%
x = diag(x);
x(abs(x)>1e-10) = 1./x(abs(x)>1e-10);
x = diag(x);