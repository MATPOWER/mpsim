function sim = update(sim, x, u, sim_workdir, r, t)
%UPDATE  Call PS.UPDATE() for processes triggered at current time step
%
%   SIM = SIM.UPDATE(X, U, SIM_WORKDIR, R, T)
%
%   For every process that is triggered on given time step, this function
%   will call that process's UPDATE() and store the changes that will be made
%   on the process-specific and shared states as well as the optional
%   arguments produced from the process's UPDATE() into various FIFO queues.
%  
%   Input:
%       SIM - simulator object
%       X - simulator state
%       U - struct of inputs for current run and time step
%       SIM_WORKDIR - path to simulation temporary work files
%       R - index(es) of simulation run (cell array)
%       T - index of current time step
%
%   Output:
%       SIM - simulator object

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

%% display triggered process with verbose option on
if sim.verbose > 0
    for k = 1:length(sim.processes)
        ps = sim.processes{k};
        idx = ps.trigger(sim);
        if idx      %% triggering
            ps.print_trigger(x, sim.y, r, t, idx);
        end
    end
end

%% trigger updates
for k = 1:length(sim.processes)
    ps = sim.processes{k};
    idx = ps.trigger(sim);
    if idx      %% triggering
        [x_ps, sx_updates, out_args] = ps.update(x, u, sim.name, sim_workdir, r, idx);
        sim.queue_ps_x(ps.name, x_ps);          %% saves x_ps in FIFO queue at sim.x_updates.(ps.name)
        sim.queue_shared_x(ps.name, sx_updates);%% saves sx_updates in FIFO queue at sim.x_updates.shared.(ps.name)
        sim.queue_out_args(ps.name, out_args);  %% saves out_args in FIFO queue at sim.out_args.(ps.name)
    end
end
