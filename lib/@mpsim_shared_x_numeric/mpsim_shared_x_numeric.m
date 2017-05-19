classdef mpsim_shared_x_numeric < mpsim_shared_x
%MPSIM_SHARED_X_NUMERIC  Shared state with numeric (scalar or array) value.
%
%   The initial value is loaded from the file in <SIM_INPUTDIR>/shared_states
%   named <SX_NAME>.txt using the built-in LOAD function, where <SX_NAME> is
%   the name of the shared state.
%
%   Defined update operations are:
%       '+'     add update value to current value
%       '-'     subtract update value from current value
%       '*'     multipy current value by update value (matrix multiply)
%       '/'     divide current value by update value (matrix divide)
%       '^'     raise current value to power of update value (matrix exp)
%       '.*'    multipy current value by update value (elementwise)
%       './'    divide current value by update value (elementwise)
%       '.^'    raise current value to power of update value (elementwise)
%       '='     replace current value with update value
%
%   Note that in cases where order of operations matters, it is
%   the user's responsibility to ensure that the multiple updates in the
%   same time period are consistent.

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

    properties
    end
    methods
        function sx = mpsim_shared_x_numeric(sx_name)
           sx@mpsim_shared_x(sx_name);
        end

        function initial_value = initialize(sx, sim_inputdir, sim_name)
            init_value_path = fullfile(sim_inputdir, ...
                'shared_states', [sx.name '.txt']);
            initial_value = load(init_value_path);
            sx.initial_value = initial_value;
            sx.value = initial_value;
        end

        function update(sx, sx_update)
            for k = 1:length(sx_update)
                switch sx_update(k).op
                    case '+'
                        sx.value = sx.value + sx_update(k).val;
                    case '-'
                        sx.value = sx.value - sx_update(k).val;
                    case '*'
                        sx.value = sx.value * sx_update(k).val;
                    case '/'
                        sx.value = sx.value / sx_update(k).val;
                    case '^'
                        sx.value = sx.value ^ sx_update(k).val;
                    case '.*'
                        sx.value = sx.value .* sx_update(k).val;
                    case './'
                        sx.value = sx.value ./ sx_update(k).val;
                    case '.^'
                        sx.value = sx.value .^ sx_update(k).val;
                    case '='
                        sx.value = sx_update(k).val;
                    otherwise
                        error('%mpsim_shared_x_numeric/update: invalid ''op'' value: %s', sx_update(k).op);
                end
            end
        end
    end
end
