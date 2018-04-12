function sim = preload_all_run_inputs(sim, r)
%PRELOAD_ALL_RUN_INPUTS  Pre-load inputs for current run
%
%   SIM = SIM.PRELOAD_ALL_RUN_INPUTS(R)
%
%   Pre-loads and caches all inputs that apply to the current run, by
%   calling the PRELOAD_RUN_INPUTS method of the simulator and each process.
%
%   Pre-loaded inputs for the simulator are stored in:
%       sim.u_preloaded.sim.thisrun.thisrun
%       sim.u_preloaded.sim.thisrun.byt(t)
%
%   Pre-loaded inputs for each process are stored in:
%       sim.u_preloaded.(ps.name).thisrun.thisrun
%       sim.u_preloaded.(ps.name).thisrun.byidx(idx)
%
%   Input:
%       SIM - simulator object
%
%   Output:
%       SIM - simulator object

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

ri = struct();
[ri.thisrun, ri.byt] = ...
    sim.preload_run_inputs(sim.name, sim.inputdir(), r);
sim.u_preloaded.sim.thisrun = ri;

for ps_index = 1:length(sim.processes)
  ps = sim.processes{ps_index};
  ri = struct();
  nidx = ps.t2idx(sim.T, 'F', 1);
  [ri.thisrun, ri.byidx] = ...
      ps.preload_run_inputs(sim.name, sim.inputdir(), sim.R, nidx, r);
  sim.u_preloaded.(ps.name).thisrun = ri;
end
