function [thisrun, byt] = preload_run_inputs(sim, sim_name, sim_inputdir, r)
%PRELOAD_RUN_INPUTS  Pre-load inputs at beginning of each run.  Overridable.
%
%   [THISRUN, BYT] = SIM.PRELOAD_RUN_INPUTS(SIM_NAME, SIM_INPUTDIR, R)
%
%   Called at the beginning of each simulation run to pre-load inputs
%   that are not process-specific (particularly in terms of timing).
%   Returns empty values by default, but can be overridden by the user
%   to load data for run R specific to their simulation.
%
%   Input:
%       SIM - simulator object
%       SIM_NAME - name of current simulation batch
%       SIM_INPUTDIR - path to simulation inputs
%       R - index(es) of simulation run (cell array)
%
%   Output:
%       THISRUN - struct, pre-loaded input data for the the current run r
%       BYT - struct array indexed by time index t, pre-loaded input data
%           for each time step of the current run r
%
%   The input struct U, as passed to the PS.UPDATE() functions, includes
%   data pre-loaded by this method at the beginning of each simulation run.
%   That is, in addition to data from other sources, all fields from the
%   following elements of this method's return args are copied into input
%   struct U:
%       THISRUN,
%       BYT(t) for the current time step t,

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

thisrun = [];
byt     = [];
