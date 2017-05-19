function x_ps = initialize(ps, x, sim_inputdir)
%INITIALIZE @bg_deliver/initialize

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

%% deliver state is (scalar) cumulative number of patties delivered
x_ps = 0;
