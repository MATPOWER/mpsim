function thisidx = load_current_inputs(ps, sim_name, sim_inputdir, R, nidx, r, idx)
%LOAD_CURRENT_INPUTS  Retrieves inputs for triggered time step.  Overridable.
%
%   THISIDX = PS.LOAD_CURRENT_INPUTS(SIM_NAME, SIM_INPUTDIR, R, NIDX, r, IDX)
%
%   Retrieves the inputs necessary for the process PS at the triggered time
%   step IDX (different from just the time step).  Can be overridable by user
%   when subclassing MPSIM_PROCESS.
%
%   Input:
%       PS - process object
%       SIM_NAME - name of current simulation batch
%       SIM_INPUTDIR - path to simulation inputs
%       R - scalar or vector of dimension of runs in current simulation batch
%       NIDX - number of process update instances per run in current sim batch
%       r - index(es) of simulation run (cell array)
%       IDX - index of process update instance
%
%   Output:
%       THISIDX - Value containing input values necessary for this time
%                   step

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

thisidx = [];
