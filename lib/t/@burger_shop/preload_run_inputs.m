function [thisrun, byt] = preload_run_inputs(sim, sim_name, sim_inputdir, r)
%PRELOAD_RUN_INPUTS @burger_shop/preload_run_inputs

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

season = {'base-run', 'growth-run'};

fname = fullfile(sim_inputdir, ...
    sprintf('sold-%s.txt', season{r{1}}));
sold = load(fname);

thisrun = [];
byt = struct('sold', num2cell(sold));
