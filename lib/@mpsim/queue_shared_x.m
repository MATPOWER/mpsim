function sim = queue_shared_x(sim, ps_name, sx_updates)
%QUEUE_SHARED_X Push shared state updates to corresponding FIFO queue
%
%   SIM = SIM.QUEUE_SHARED_X(PS_NAME, SX_UPDATES)
%
%   Takes changes that will be made to shared states, produced by each
%   process's UPDATE() and stores into a process-specific queue in the
%   simulator object.
%
%   Input:
%       SIM - simulator object
%       PS_NAME - name of process
%       SX_UPDATES - struct of shared state updates
%           top-level fields are shared state names, each of which is a
%           struct array with fields 'op' and 'val'.
%
%   Output:
%       SIM - simulator object

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

sim.x_updates.shared.(ps_name){end + 1} = sx_updates;
if sim.verbose > 2
    fprintf('sim queued the following shared state changes made by %s: \n', ...
        ps_name);
    sx_updates
end