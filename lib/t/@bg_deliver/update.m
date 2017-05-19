function [x_ps, sx_updates, out_args] = update(ps, x, u, sim_name, sim_workdir, r, idx)
%UPDATE @bg_deliver/update

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

deliveries = x.shared.order_queue{1};

sx_updates = struct( ...
    'order_queue', struct('op', '-', 'val', 1), ...
    'frozen_inventory', struct('op', '+', 'val', deliveries) );
x_ps = x.(ps.name) + deliveries;
out_args = deliveries;
