function [thissim, byrun, byidx, byboth] = preload_sim_inputs(ps, sim_name, sim_inputdir, R, nidx)
%PRELOAD_SIM_INPUTS @bg2_deliver/preload_sim_inputs
%
%   This is an example; inputs returned from this function are not used in
%   the actual burger shop simulation.

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

thissim = struct('process_static_field', 100);
byrun = struct('process_byrun_field', {1, 2; R(1), R(end)});
byboth = [];
byidx = struct('process_byidx_field', num2cell(nidx+(1:nidx)));
