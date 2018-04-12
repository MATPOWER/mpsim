function sim = output(sim, u, sim_outputdir, r, t)
%OUTPUT  Collect output from finalizing processes that provide it
%
%   SIM = SIM.OUTPUT(U, SIM_OUTPUTDIR, R, T)
%
%   Calls the OUTPUT() method, with optional arguments returned by
%   the corresponding UPDATE(), of processes being finalized. For processes
%   returning output values, they are collected for possible post-processing
%   by the simulator's POST_RUN() method.
%
%   Output for a given process is found in sim.y.(ps_name)(r{:}, idx).
%   The OUTPUT() method of the process when called with no arguments must
%   return a value of the same type as those that are returned during the
%   simulation.
%
%   Input:
%       SIM - simulator object
%       U - struct of inputs for current run and time step
%       SIM_OUTPUTDIR - path to simulation outputs
%       R - index(es) of simulation run (cell array)
%       T - index of current time step
%
%   Output:
%       SIM - simulator object

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

for k = 1:length(sim.processes)
    ps = sim.processes{k};
    idx = ps.finalize(sim);
    if idx      %% finalizing
        out_args = sim.out_args.(ps.name){1};
        sim.out_args.(ps.name)(1) = [];
        y_ps = ps.output(sim.x, u, sim.name, sim_outputdir, r, idx, out_args);
        if ~isempty(y_ps)
            sim.y.(ps.name)(r{:}, idx) = y_ps;
        end
    end
end

%% display finalized process if verbose option is turned on
 if sim.verbose > 0
     for k = 1:length(sim.processes)
         ps = sim.processes{k};
         idx = ps.finalize(sim);
         if idx      %% finalizing
            ps.print_finalize(sim.x, sim.y, r, t, idx);
            % options
            if sim.verbose > 1
                fprintf('%s specific outputs are generated: \n', ps.name);
                out_args
            end
         end
     end
 end
