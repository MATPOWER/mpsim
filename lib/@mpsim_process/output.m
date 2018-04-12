function y_ps = output(ps, x, u, sim_name, sim_outputdir, r, idx, out_args)
%OUTPUT  Implements process output function g(x,u).  Overridable.
%
%   Y_PS = PS.OUTPUT(X, U, SIM_NAME, SIM_OUTPUTDIR, R, IDX, OUT_ARGS)
%
%   Implements the process output function g(x,u). Creates the outputs for
%   a particular update instance of the process upon finalization. This
%   method can save files to the SIM_OUTPUTDIR, print output to the console
%   or return output values to be cached by the simulator for post-processing
%   by the simulator's POST_RUN method.
%
%   This method is called without input arguments during simulation
%   initialization to determine whether the process returns outputs
%   for post-processing. In this context it should return an empty
%   matrix if it will not be returning output for post-processing.
%   Otherwise, it should return a non-empty scalar, if it's output will
%   be a simple scalar, or if it will be a struct, then it should
%   return a struct with the same fields that will be returned during the
%   simulation. These values are stored in the simulator output struct at
%   sim.y.(ps.name)(r{:}, idx).
%
%   Input:
%       PS - process object
%       X - simulator state
%       U - struct of inputs for current run and time step
%       SIM_NAME - name of current simulation batch
%       SIM_OUTPUTDIR - path to simulation outputs
%       R - index(es) of simulation run (cell array)
%       IDX - index of process update instance
%       OUT_ARGS - arguments passed from PS.UPDATE() to PS.OUTPUT()
%
%   Output:
%       Y_PS - output values for this process

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

y_ps = [];
