function [x_ps, sx_updates, out_args] = update(ps, x, u, sim_name, sim_workdir, r, idx)
%UPDATE @bg_defrost/update

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

%% number to defrost is min of input value and current frozen inventory
defrosts = u.defrosts;
if x.shared.frozen_inventory < defrosts
    defrosts = x.shared.frozen_inventory;
end

x_ps = x.(ps.name) + defrosts;
sx_updates = struct( ...
    'frozen_inventory', struct('op', '-', 'val', defrosts), ...
    'thawed_inventory', struct('op', '+', 'val', defrosts) );
out_args = defrosts;
