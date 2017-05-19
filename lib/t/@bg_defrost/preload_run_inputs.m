function [thisrun, byidx] = preload_run_inputs(ps, sim_name, sim_inputdir, R, nidx, r)
%PRELOAD_RUN_INPUTS @bg_defrost/preload_run_inputs
%
%   BYIDX is a struct array with field name 'defrosts' containing
%   input data from files in SIM_INPUTDIR named:
%       'defrost-base-run-1.txt'
%       'defrost-growth-run-1.txt'
%   where 'base' corresponds to r{1} = 1 and 'growth' to r{1} = 2

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

season = {'base', 'growth'};
fname = fullfile(sim_inputdir, ...
        sprintf('%s-%s-run-%d.txt', ps.name, season{r{1}}, 1));
defrosts = load(fname);

thisrun = [];
byidx = struct('defrosts', num2cell(defrosts));
