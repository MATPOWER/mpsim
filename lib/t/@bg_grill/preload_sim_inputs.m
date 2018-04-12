function [thissim, byrun, byidx, byboth] = preload_sim_inputs(ps, sim_name, sim_inputdir, R, nidx)
%PRELOAD_SIM_INPUTS @bg_grill/preload_sim_inputs
%
%   [THISSIM, BYRUN, BYIDX, BYBOTH] = PS.PRELOAD_SIM_INPUTS(SIM_NAME, SIM_INPUTDIR, R, NIDX)
%
%   BYBOTH is a struct array with field name 'grills' containing
%   input data from files in SIM_INPUTDIR named:
%       'grill-base-run-1.txt'
%       'grill-growth-run-1.txt'
%   where 'base' corresponds to run 1 and 'growth' to run 2

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

fname = fullfile(sim_inputdir, ...
        sprintf('%s-run-%d.txt', ps.name, 1));
grills = load(fname)';

thissim = [];
byrun   = [];
byidx   = [];
byboth  = struct('grills', num2cell(grills));
