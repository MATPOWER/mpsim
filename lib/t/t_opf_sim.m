function t_opf_sim(quiet)
%T_OPF_SIM  Tests for @burger_shop simulation
%
%   Tests @opf_sim, @opf_hourly_dispatch classes and single-dimensional batch
%   of runs based on 'OPF_example' inputs.

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

if nargin < 1
    quiet = 0;
end
num_tests = 8;
t_begin(num_tests, quiet);

%% opf simulation
if exist('runopf','file') > 0
    T = 48;
    sim = opf_sim().run('OPF_example', 'T',T, 'R',2, struct('post_run_on',1));
    t_is(length(sim.processes), 1, 12, 'number of processes');
    t_ok(strcmp(sim.processes{1}.name, 'dispatch'), 'process name');
    t_is(sim.processes{1}.f_period, 1, 12, 'process f period');
    t_is(sim.processes{1}.t0_period, 1, 12, 'process t0 period');
    t_is(sim.processes{1}.tau_period, 0, 12, 'process tau period');
    up = sim.u_preloaded;
    t_is(length(up.sim.byt), 72, 12, 'inputs sim byt');
    t_is(length(sim.y.dispatch), T, 12, 'number of elements in outputs process');
    t_is(sim.y.dispatch(1,5).results.gencost(:,12),[2400;2500;3000;2400;18000;20000],12, 'outputs process gencost');
else
    t_skip(num_tests, 'requires working installation of MATPOWER');
end

t_end
