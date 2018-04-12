function [thissim, byrun, byidx, byboth] = preload_sim_inputs(ps, sim_name, sim_inputdir, R, nidx)
%PRELOAD_SIM_INPUTS  Retrieves inputs for entire simulation.  Overridable.
%
%   [THISSIM, BYRUN, BYIDX, BYBOTH] = PS.PRELOAD_SIM_INPUTS(SIM_NAME, SIM_INPUTDIR, R, NIDX)
%
%   Retrieves the inputs necessary for the process throughout the entire 
%   simulation, some of which will become available on a certain time step
%   when the process is triggered and/or run.  Can be overridable by user 
%   when subclassing MPSIM_PROCESS.
%
%   Input:
%       PS - process object
%       SIM_NAME - name of current simulation batch
%       SIM_INPUTDIR - path to simulation inputs
%       R - scalar or vector of dimension of runs in current simulation batch
%       NIDX - number of process update instances per run in current sim batch
%
%   Output:
%       THISSIM - Value containing input values necessary that will persist
%           throughout the entire simulation
%       BYRUN - Value containing input values that will become available on a
%           certain run
%       BYIDX - Value containing input values that will become available on a
%           certain time step corresponding to when the process is
%           triggered
%       BYBOTH - Value containing input values that will become available on a 
%           certain run and triggering time step (indexed in that order)

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

thissim = [];
byrun   = [];
byidx   = [];
byboth  = [];
