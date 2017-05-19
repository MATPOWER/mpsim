function [x_ps, sx_updates, out_args] = update(ps, x, u, sim_name, sim_workdir, r, idx)
%UPDATE @bg_order/update

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

%% add total patties ordered for the week to x_ps & out_args
%% (u.orders is a row vector)
sx_updates = struct( ...
    'order_queue', struct('op', '+', 'val', {num2cell(u.orders)}) );
x_ps = x.(ps.name) + sum(u.orders);
out_args = sum(u.orders);
