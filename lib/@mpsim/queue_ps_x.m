function sim = queue_ps_x(sim, ps_name, x_ps)
%QUEUE_PS_X Push updated process-specific state to corresponding FIFO queue
%
%   SIM = SIM.QUEUE_PS_X(PS_NAME, X_PS)
%
%   Takes updated process-specific state to be applied on process finalization
%   and pushes it into a process-specific queue in the simulator object.
%
%   Input:
%       SIM - simulator object
%       PS_NAME - name of process
%       X_PS - updated process-specific state
%
%   Output:
%       SIM - simulator object

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

sim.x_updates.(ps_name){end + 1} = x_ps;
if sim.verbose > 2
    fprintf('sim queued the following process-specific state changes for %s: \n', ...
        ps_name);
    x_ps
end
