function sim = apply_shared_x(sim, ps_name)
%APPY_SHARED_X  Apply queued update for given process to shared state
%
%   SIM = SIM.APPY_SHARED_X(PS_NAME)
%
%   Called when a process is finalized to update the shared state
%   with any updates indicated by the corresponding PS.UPDATE() call.
%
%   Input:
%       SIM - simulator object
%       PS_NAME - name of process that initiated the shared state
%           updates being applied
%
%   Output:
%       SIM - simulator object

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

%% pop the shared state updates from the queue for the given process
sx_updates = sim.x_updates.shared.(ps_name){1};
sim.x_updates.shared.(ps_name)(1) = [];

%% apply updates for all shared states with updates
if ~isempty(sx_updates)
    shared_fields = fieldnames(sx_updates);
    for k = 1:length(shared_fields)
        sx_name = shared_fields{k};
        sim.shared_x_objects.(sx_name).update(sx_updates.(sx_name));
        sim.x.shared.(sx_name) = sim.shared_x_objects.(sx_name).value;
        if sim.verbose > 2
            fprintf('shared state ''%s'' after update: \n', sx_name);
            sim.x.shared.(sx_name)
        end
    end
end
