function [thissim, byrun, byt, byboth] = preload_sim_inputs(sim, sim_name, sim_inputdir)
%PRELOAD_SIM_INPUTS  Pre-load inputs at beginning of simulation.  Overridable.
%
%   [THISSIM, BYRUN, BYT, BYBOTH] = ...
%           SIM.PRELOAD_SIM_INPUTS(SIM_NAME, SIM_INPUTDIR)
%
%   Called at the beginning of a simulation batch to pre-load inputs
%   that are not process-specific (particularly in terms of timing).
%   Returns empty values by default, but can be overridden by the user
%   to load data specific to their simulation.
%
%   Input:
%       SIM - simulator object
%       SIM_NAME - name of current simulation batch
%       SIM_INPUTDIR - path to simulation inputs
%
%   Output:
%       THISSIM - struct, pre-loaded input data for all update function calls
%       BYRUN - struct array indexed by run index r{:}, pre-loaded input data
%           for each run
%       BYT - struct array indexed by time index t, pre-loaded input data
%           for each time step
%       BYBOTH - struct array indexed by run index r{:} and time index t,
%           pre-loaded input data for each time step of each run
%
%   The input struct U, as passed to the PS.UPDATE() functions, includes
%   data pre-loaded by this method at the beginning of the simulation.
%   That is, in addition to data from other sources, all fields from the
%   following elements of this method's return args are copied into input
%   struct U:
%       THISSIM,
%       BYRUN(r{:}) for the current run r,
%       BYT(t) for the current time step t,
%       BYBOTH(r{:},t) for the current run r and time step t.

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

thissim = [];
byrun   = [];
byt     = [];
byboth  = [];
