classdef mpsim_shared_x < handle
%MPSIM_SHARED_X  Base class for MP-Sim shared state objects.
%
%   To implement a shared state class, the user must provide implementations
%   of the INITIALIZE and UPDATE methods.
%
%   Properties:
%       name - name of shared state: string
%       initial_value - initial value of shared state
%       value - current value of shared state, updated throughout simulation
%
%   Examples: MPSIM_SHARED_X_NUMERIC, MPSIM_SHARED_X_QUEUE

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

    properties
         name = '';            %% name of shared state
         initial_value = [];   %% starting value of shared state
         value = [];           %% current value of shared state
    end
    methods
        function sx = mpsim_shared_x(sx_name)
           sx.name = sx_name;
        end

        function initial_value = initialize(sx, sim_inputdir, sim_name)
            error('@%s/initialize: implementation not provided', class(sx));
        end

        function update(sx, sx_update)
            error('@%s/update: implementation not provided', class(sx));
        end
    end
end
