function sim = queue_out_args(sim, ps_name, out_args)
%QUEUE_OUT_ARGS Save arguments to pass from PS.UPDATE() to PS.OUTPUT() in FIFO
%
%   SIM = SIM.QUEUE_OUT_ARGS(PS_NAME, OUT_ARGS)
%
%   Takes optional arguments returned by PS.UPDATE() and stores into a
%   process-specific queue in the simulator object to later be passed
%   to the corresponding PS.OUTPUT().
%
%   Input:
%       SIM - simulator object
%       PS_NAME - name of process
%       OUT_ARGS - arguments passed from PS.UPDATE() to PS.OUTPUT().
%           Can be empty.
%
%   Output:
%       SIM - simulator object

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

sim.out_args.(ps_name){end + 1} = out_args;
if sim.verbose == 3
    fprintf('sim queued the following optional argument made by %s: \n', ...
        ps_name);
    out_args
end
