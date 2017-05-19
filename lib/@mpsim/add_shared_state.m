function sim = add_shared_state(sim, sx)
%ADD_SHARED_STATE Adds shared state objects into simulator.
%
%   SIM = SIM.ADD_SHARED_STATE(SX)
% 
%   Adds the shared state object and its initial value into the simulator.
%
%   Input:
%       SIM - simulator object
%       SX - shared state object, subclass of @mpsim_shared_x
%
%   Output:
%       SIM - simulator object

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

sim.shared_x_objects.(sx.name) = sx;
sim.shared_x_names{end+1} = sx.name;
