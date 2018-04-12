function [thissim, byrun, byt, byboth] = preload_sim_inputs(sim, sim_name, sim_inputdir)
%PRELOAD_SIM_INPUTS @opf_sim/preload_sim_inputs
% 
%   Stores MATPOWER case struct and options struct into THISSIM and
%   generator cost data into BYT.

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

mpc = loadcase(fullfile(sim_inputdir, 'case30_mpsim'));
verbose = max(0, sim.verbose - 1);
mpopt = mpoption('opf.ac.solver', 'MIPS', 'verbose', verbose, 'out.all', 0);

thissim = struct('mpc', mpc, 'mpopt', mpopt);
byrun = [];
byt = struct('cost', num2cell(4*ones(72,1)));
byboth = [];
