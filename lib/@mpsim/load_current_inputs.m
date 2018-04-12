function thisidx = load_current_inputs(sim, sim_name, sim_inputdir, r, t)
%LOAD_CURRENT_INPUTS  Load inputs for current time step.  Overridable.
%
%   THISIDX = SIM.LOAD_CURRENT_INPUTS(SIM_NAME, SIM_INPUTDIR, R, T)
%
%   Called at each time period to load inputs that are not process-specific
%   (particularly in terms of timing). Returns an empty value by default, but
%   can be overridden by the user to load data for run R and time T
%   specific to their simulation.
%
%   Input:
%       SIM - simulator object
%       SIM_NAME - name of current simulation batch
%       SIM_INPUTDIR - path to simulation inputs
%       R - index(es) of simulation run (cell array)
%       T - index of current time step
%
%   Output:
%       THISIDX - struct of input data for the current run R
%           and time step T
%
%   The input struct U, as passed to the PS.UPDATE() functions, includes
%   the data loaded by this method at each time step. That is, in addition
%   to data from other sources, all fields from THISIDX are copied
%   into input struct U.


%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

thisidx = struct();
