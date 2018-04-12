function [x_ps, sx_updates, out_args] = update(ps, x, u, sim_name, sim_workdir, r, idx)
%UPDATE @bg_grill/update

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

x_ps = x.(ps.name);

grills = 0;
if x.shared.thawed_inventory > 0
    %% number to grill is min of input value and current thawed inventory
    grills = u.grills;
    if x.shared.thawed_inventory < grills
        grills = x.shared.thawed_inventory;
    end
end

sx_updates = struct( ...
    'thawed_inventory', struct('op', '-', 'val', grills), ...
    'grilled_inventory', struct('op', '+', 'val', grills - u.sold) );
x_ps.grilled = x_ps.grilled + grills;
x_ps.sold = x_ps.sold + u.sold;
out_args = grills;