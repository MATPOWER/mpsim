function u = input(ps, u, sim_inputdir, r, idx)
%INPUT  Modify input data struct.  Overridable.
%
%   U = PS.INPUT(U, SIM_INPUTDIR, R, IDX)
%
%   After setting up the inputs corresponding to this run and time that the
%   process is triggered, this function offers the opportunity to reconfigure
%   the input U that will be passed into the process's UPDATE().
%
%   Input:
%       PS - process object
%       U - struct of inputs for current run and time step
%       SIM_INPUTDIR - path to simulation inputs
%       R - index(es) of simulation run (cell array)
%       IDX - index of process update instance
%
%   Output:
%       U - struct of inputs for current run and time step, updated

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

%% return u unchanged
