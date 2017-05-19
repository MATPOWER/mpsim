function sim = preload_all_sim_inputs(sim)
%PRELOAD_ALL_SIM_INPUTS  Pre-load inputs for entire simulation batch
%
%   SIM = SIM.PRELOAD_ALL_SIM_INPUTS(R)
%
%   Pre-loads anc caches all inputs that apply to the entire simulation batch,
%   by calling the PRELOAD_SIM_INPUTS method of the simulator and each process.
%
%   Pre-loaded inputs for the simulator are stored in:
%       sim.u_preloaded.sim.thissim
%       sim.u_preloaded.sim.byrun
%       sim.u_preloaded.sim.byt
%       sim.u_preloaded.sim.byboth
%
%   Pre-loaded inputs for each process are stored in:
%       sim.u_preloaded.(ps.name).thissim
%       sim.u_preloaded.(ps.name).byrun
%       sim.u_preloaded.(ps.name).byidx
%       sim.u_preloaded.(ps.name).byboth
%
%   Input:
%       SIM - simulator object
%
%   Output:
%       SIM - simulator object

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

sim.u_preloaded = struct();
si = struct();
[si.thissim, si.byrun, si.byt, si.byboth] = ...
    sim.preload_sim_inputs(sim.name, sim.inputdir());
sim.u_preloaded.sim = si;

r = num2cell(sim.R);
for k = 1:length(sim.processes)
  ps = sim.processes{k};
  psi = struct();
  nidx = ps.t2idx(sim.T, 'F', 1);
  [psi.thissim, psi.byrun, psi.byidx, psi.byboth] = ...
      ps.preload_sim_inputs(sim.name, sim.inputdir(), sim.R, nidx);
  sim.u_preloaded.(ps.name) = psi;
end
