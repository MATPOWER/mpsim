classdef mpsim_shared_x_queue < mpsim_shared_x
%MPSIM_SHARED_X_QUEUE  Shared state whose value is a FIFO queue.
%
%   Implements a shared state whose value is a FIFO queue of arbitrary
%   data types. The initial value is an empty queue by default. If
%   some other initial value is desired, it can be handled by
%   implementing a READ_INPUT() method which constructs the initial
%   queue by reading data from the file in <SIM_INPUTDIR>/shared_states
%   named <SX_NAME>.txt, where <SX_NAME> is the name of the shared state.
%   The path to this file is provided in the args to READ_INPUT.
%
%   Defined update operations are:
%       '+'     push update values to the queue, update values can be
%               scalar or cell array
%       '-'     pop values from the queue, where update value gives number
%               of elements to pop

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

    properties
    end
    methods
        function sx = mpsim_shared_x_queue(sx_name)
           sx@mpsim_shared_x(sx_name);
        end

        function initial_value = initialize(sx, sim_inputdir, sim_name)
            sx_path = fullfile(sim_inputdir, 'shared_states');
            fname = [sx.name '.m'];
            if exist(fullfile(sx_path, fname), 'file')
                initial_value = feval_w_path_mpsim(sx_path, sx.name);
            else
                initial_value = {};
            end
            sx.initial_value = initial_value;
            sx.value = initial_value;
        end

        function push(sx, update_val)
            if ~iscell(update_val)
                update_val = { update_val };
            end
            sx.value = {sx.value{:}, update_val{:}};
        end

        function val = pop(sx, num)
            if nargin < 2
                num = 1;
            end
            if length(sx.value) < num
                error('@mpsim_shared_x_queue/pop: queue is empty, no more items to pop');
            end
            val = sx.read(num);
            sx.value(1:num) = [];
        end

        function val = read(sx, num)
            if nargin < 2 || isempty(num) || num == 1
                val = sx.value{1};
            else
                val = sx.value(1:num);
            end
        end

        function update(sx, sx_update)
            for k = 1:length(sx_update)
                switch sx_update(k).op
                    case '+'
                        sx.push(sx_update(k).val);
                    case '-'
                        sx.pop(sx_update(k).val);
                    otherwise
                        error('%mpsim_shared_x_queue/update: invalid ''op'' value: %s', sx_update(k).op);
                end
            end
        end
    end
end
