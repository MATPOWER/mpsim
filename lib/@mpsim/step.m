function sim = step(sim)
%STEP Update state for finalizing processes and increment time step
%
%   SIM = SIM.STEP()
%
%   Applies changes to state from processes finalized at the current time
%   step, then increments the time step.
%
%   Input:
%       SIM - simulator object
%
%   Output:
%       SIM - simulator object

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

for k = 1:length(sim.processes)
    ps = sim.processes{k};
    idx = ps.finalize(sim);
    if idx      %% finalizing
        sim.apply_ps_x(ps.name);        %% applies update from FIFO queue at sim.x_updates.(ps.name)
        sim.apply_shared_x(ps.name);    %% applies update from FIFO queue at sim.x_updates.shared.(ps.name)
    end
end

sim.t = sim.t + 1;