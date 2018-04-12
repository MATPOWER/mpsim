function [x_ps, xs_updates, out_args] = update(ps, x, u, sim_name, sim_workdir, r, idx)
%UPDATE @opf_hourly_dispatch/update

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

%% define named indices into bus, gen, branch matrices
[GEN_BUS, PG, QG, QMAX, QMIN, VG, MBASE, GEN_STATUS, PMAX, PMIN, ...
    MU_PMAX, MU_PMIN, MU_QMAX, MU_QMIN, PC1, PC2, QC1MIN, QC1MAX, ...
    QC2MIN, QC2MAX, RAMP_AGC, RAMP_10, RAMP_30, RAMP_Q, APF] = idx_gen;

%% structure of input
%%      u
%%          .mpc
%%          .mpopt
%%          .load
%%          .cost

%% set up MATPOWER case
mpc = scale_load(u.load, u.mpc);
mpc.gencost(5:6,:) = modcost(mpc.gencost(5:6,:), u.cost);

%% limit PMIN and PMAX as necessary to reflect ramp limits from previous hour
if ~isempty(x.dispatch)
    temp_min = x.dispatch - mpc.gen(:,RAMP_30)*2;
    temp_max = x.dispatch + mpc.gen(:,RAMP_30)*2;
    k = find(temp_min > mpc.gen(:, PMIN));
    if ~isempty(k)
        mpc.gen(k, PMIN) = temp_min(k);
    end
    k = find(temp_max < mpc.gen(:, PMAX));
    if ~isempty(k)
        mpc.gen(k, PMAX) = temp_max(k);
    end
end

%% run OPF
results = runopf(mpc, u.mpopt);

%% process-specific state is Pg
x_ps = results.gen(:, PG);
xs_updates = struct();  %% no shared state updates
out_args = results;     %% pass OPF results to output()
