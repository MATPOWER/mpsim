function thisidx = load_current_inputs(ps, sim_name, sim_inputdir, R, nidx, r, idx)
%LOAD_CURRENT_INPUTS @bg_order/load_current_inputs

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

season = {'base', 'growth'};
fcn_name = sprintf('%s_%s_run', ps.name, season{r{1}});
orders = feval_w_path_mpsim(sim_inputdir, fcn_name, idx);

thisidx = struct('orders', orders);
