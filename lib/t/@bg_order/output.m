function y_ps = output(ps, x, u, sim_name, sim_outputdir, r, idx, out_args)
%OUTPUT @bg_order/output
%
% Provided additional return value for when no arguments are passed (except
% for the process itself), in this case the value 0.

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

if nargin == 1
    y_ps = 0;
else
    y_ps = out_args;
end