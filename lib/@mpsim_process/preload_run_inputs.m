function [thisrun, byidx] = preload_run_inputs(ps, sim_name, sim_inputdir, R, nidx, r)
%PRELOAD_RUN_INPUTS  Retrieves inputs for current run.  Overridable.
%
%   [THISRUN, BYIDX] = PS.PRELOAD_RUN_INPUTS(SIM_NAME, SIM_INPUTDIR, R, NIDX, r)
%
%   Retrieves the inputs necessary for the process ps at the current run.  
%   Can be overridable by user when subclassing MPSIM_PROCESS.
%  
%   Input:
%       PS - process object
%       SIM_NAME - name of current simulation batch
%       SIM_INPUTDIR - path to simulation inputs
%       R - scalar or vector of dimension of runs in current simulation batch
%       NIDX - number of process update instances per run in current sim batch
%       r - index(es) of simulation run (cell array)
%
%   Output:
%       THISRUN - data that applies to every time step of the current run
%       BYIDX - data indexed by the process index for this run

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

thisrun = [];
byidx   = [];
