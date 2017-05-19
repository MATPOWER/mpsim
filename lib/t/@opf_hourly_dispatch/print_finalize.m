function print_finalize(ps, x, y, r, t, idx)
%PRINT_FINALIZE @opf_hourly_dispatch/print_finalize
%
% Print your personal progress outputs when running with verbose options.

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

results = y.(ps.name)(r{:},idx).results;
fprintf('run %d hour %2d : success = %d   total load = %5.1f MW\n', ...
    r{1}, idx, results.success, sum(total_load(results)));
