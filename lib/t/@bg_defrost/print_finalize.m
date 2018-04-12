function print_finalize(ps, x, y, r, t, idx)
%PRINT_FINALIZE @bg_defrost/print_finalize

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

fprintf('%d : finalize %s %d\n', t, ps.name, y.(ps.name)(r{:}, idx));
