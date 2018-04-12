function sim = apply_ps_x(sim, ps_name)
%APPLY_PS_X  Apply queued update to process-specific state
%
%   SIM = SIM.APPLY_PS_X(PS_NAME)
%
%   Called when a process is finalized to update the process-specific state
%   to the value indicated by the corresponding PS.UPDATE() call.
%
%   Input:
%       SIM - simulator object
%       PS_NAME - name of process whose state is being updated
%
%   Output:
%       SIM - simulator object

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

sim.x.(ps_name) = sim.x_updates.(ps_name){1};
sim.x_updates.(ps_name)(1) = [];
if sim.verbose > 1
    fprintf('%s specific state after changes are applied: \n', ps_name);
    sim.x.(ps_name)
end
