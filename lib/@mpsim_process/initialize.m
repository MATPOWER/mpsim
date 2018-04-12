function x_ps = initialize(ps, x, sim_inputdir)
%INITIALIZE  Sets initial value for process-specific state.  Overridable.
%
%   X_PS = PS.INITIALIZE(X, SIM_INPUTDIR)
%
%   By setting an initial value, simulator allocates memory corresponding to
%   the process-specific state for ps.  Called when registering processes
%   before simulation (see @MPSIM/REGISTER_PROCESS).
%
%   Input:
%       PS - process object
%       X - simulator state
%       SIM_INPUTDIR - Path to directory with simulation-specific inputs
%
%   Output:
%       X_PS - Initial value that will go into process-specific state

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

x_ps = [];
