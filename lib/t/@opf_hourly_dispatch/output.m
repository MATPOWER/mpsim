function y_ps = output(ps, x, u, sim_name, sim_outputdir, r, idx, out_args)
%OUTPUT @opf_hourly_dispatch/output
%
% If no argument is passed in, Y_PS is a struct containing value 0.
% Otherwise, Y_PS is a struct containing the optional argument passed
% from @OPF_HOURLY_DISPATCH/UPDATE().

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

if nargin == 1
    y_ps = struct('results', 0);
else
    y_ps = struct('results', out_args);
end
