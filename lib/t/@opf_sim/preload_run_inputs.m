function [thisrun, byt] = preload_run_inputs(sim, sim_name, sim_inputdir, r)
%PRELOAD_RUN_INPUTS @opf_sim/preload_run_inputs
% 
%   Gives load profile of entire run and puts into struct.

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

dir_load = fullfile(sim_inputdir, sprintf('loads%d.txt', r{:}));
vector_load = load(dir_load);

thisrun = [];
byt = struct('load', num2cell(vector_load));
