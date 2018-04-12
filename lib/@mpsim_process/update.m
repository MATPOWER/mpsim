function [x_ps, sx_updates, out_args] = update(ps, x, u, sim_name, sim_workdir, r, idx)
%UPDATE  Implements process update function f(x,u).  Must be overridden.
%
%   [X_PS, SX_UPDATES, OUT_ARGS] = PS.UPDATE(X, U, SIM_NAME, SIM_WORKDIR, R, IDX)
%
%   Implements the process update function f(x,u). Called with the current
%   state X and current input U when the process is triggered, to compute
%   updates to the process-specific and shared state. These updates are
%   applied to the state when the corresponding update instance finalizes.
%   It can also use OUT_ARGS to pass along arbitrary data to the corresponding
%   output function.
%
%   This method *must* be implemented in your MPSIM_PROCESS subclass.
%
%   Input:
%       PS - process object
%       X - simulator state
%       U - struct of inputs for current run and time step
%       SIM_NAME - name of current simulation batch
%       SIM_WORKDIR - path to simulation temporary work files
%       R - index(es) of simulation run (cell array)
%       IDX - index of process update instance
%
%   Output:
%       X_PS - Value that process-specific state will adopt after process
%              is finalized
%       SX_UPDATES - struct of shared state updates
%           top-level fields are shared state names, each of which is a
%           struct array with fields 'op' and 'val'.
%       OUT_ARGS - arguments passed from PS.UPDATE() to PS.OUTPUT()

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

error('@mpsim_process/update: Please override/implement update() in your process subclass');
