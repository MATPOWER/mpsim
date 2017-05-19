function done = increment_run(sim)
%INCREMENT_RUN  Increment the simulation run counter
%
%   DONE = SIM.INCREMENT_RUN()
%
%   Increments the (possibly multi-dimensional) run counter in sim.r
%   and returns true if all runs are complete.
%
%   Inputs:
%       SIM - simulator object
%
%   Output:
%       DONE - flag to indicate that all runs have been completed

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

%% increment last dimension
N = length(sim.R);
sim.r{N} = sim.r{N} + 1;

%% increment next dimension, if necessary
for d = N:-1:2
    if sim.r{d} > sim.R(d)
        sim.r{d} = 1;
        sim.r{d-1} = sim.r{d-1} + 1;
    end
end

%% check if done
if sim.r{1} <= sim.R(1)
    done = 0;
else
    done = 1;
    sim.r = num2cell(sim.R);
end
