function sim = register_process(sim, ps)
%REGISTER_PROCESS Registers the process to the simulator
%
%   SIM = SIM.REGISTER_PROCESS(PS)
%
%   Checks compatibility of process and simulator timing parameters,
%   initializes the private data structures for tracking state updates and
%   output arguments for the process, and registers the process with the
%   simulator.
%
%   Input:
%       SIM - simulator object
%       PS - process object
%
%   Output:
%       SIM - simulator object

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

ps_name = ps.name;
ps = ps.set_period(sim.l);

%% initialize cell arrays for next states and op_arg queue
sim.x_updates.(ps_name) = {};
sim.x_updates.shared.(ps_name) = {};
sim.out_args.(ps_name) = {};

sim.processes{end+1} = ps;
