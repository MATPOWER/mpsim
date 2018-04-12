function x_ps = initialize(ps, x, sim_inputdir)
%INITIALIZE @bg_order/initialize

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

%% order state is (scalar) cumulative number of patties ordered
x_ps = 0;
