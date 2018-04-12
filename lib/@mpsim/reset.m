function sim = reset(sim)
%RESET  Resets state to initial value.
%
%   SIM = SIM.RESET()
%
%   Set time index back to 1 and resets the simulator state to the initial
%   value, including the values of all shared state objects. Called before
%   the start of each new run.
%
%   Input:
%       SIM - simulator object
%
%   Output:
%       SIM - simulator object

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

%% reset time index
sim.t = 1;

%% copy back initial state
sim.x = sim.x0;

%% reset values of shared state objects
for i = 1:length(sim.shared_x_names)
    sx_name = sim.shared_x_names{i};
    sim.shared_x_objects.(sx_name).value = ...
        sim.shared_x_objects.(sx_name).initial_value;
end

%% clear any state update values and out_args
for k = 1:length(sim.processes)
    ps = sim.processes{k};
    sim.x_updates.(ps.name) = {};
    sim.x_updates.shared.(ps.name) = {};
    sim.out_args.(ps.name) = {};
end
