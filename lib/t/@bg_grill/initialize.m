function x_ps = initialize(ps, x, sim_inputdir)
%INITIALIZE @bg_grill/initialize

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

%% grill state is (1x2 vector) of cumulative number of patties grilled and sold
x_ps = struct('grilled', 0, 'sold', 0);
