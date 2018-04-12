function t_mpsim_process(quiet)
% T_MPSIM_PROCESS tests process properties and time parameter functions
%
% Tests:
%  -SET_PERIOD
%  -T2IDX
%  -properties of MPSIM_PROCESS
%
%   (missing tests for IDX2T)

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

if nargin < 1
  quiet = 0;
end
num_tests = 24;
t_begin(num_tests, quiet);

%% setting periods
s = struct();
s.name = 'defrost';
s.f = 240;
s.t0 = 60;
s.tau = 180;
defrost_process = bg_defrost(s);

defrost_process = defrost_process.set_period(60);
t_is(defrost_process.t0_period,1,12,'defrost process t0 period');
t_is(defrost_process.tau_period,3,12,'defrost process tau period');
t_is(defrost_process.f_period,4,12,'defrost process f period');

defrost_process = defrost_process.set_period(3);
t_is(defrost_process.t0_period,20,12,'defrost process t0 period with different simulation time step length');
t_is(defrost_process.tau_period,60,12,'defrost process tau period with different simulation time step length');
t_is(defrost_process.f_period,80,12,'defrost process f period with different simulation time step length');

s = struct();
s.name = 'grill';
s.t0 = 30;
s.tau = 60;
s.f = 90;
grilling_process = bg_grill(s);

grilling_process = grilling_process.set_period(30);

t_is(grilling_process.t0, 30, 12, 'grill process t0 is 30');
t_is(grilling_process.tau, 60, 12, 'grill process tau is 60');
t_is(grilling_process.f, 90, 12, 'grill process f is 90');
t_is(grilling_process.t0_period, 1, 12, 'grill process t0 period is 1');
t_is(grilling_process.tau_period, 2, 12, 'grill process tau period is 2');
t_is(grilling_process.f_period, 3, 12, 'grill process f period is 3');

%% trigger
sim = mpsim();
sim.l = 60;                   %% length of simulation time step (in minutes)
sim.units = 'minutes';        %% units of sim.ls
sim.T = 10;                   %% number of simulation time steps
s = struct();
s.name = 'defrost';
s.f = 240;
s.t0 = 60;
s.tau = 180;
defrost_process = bg_defrost(s);
sim = sim.register_process(defrost_process);
processes = sim.processes;
idx = [];
for t = 1:sim.T
  idx(end+1) = processes{1}.t2idx(t, 'T');
end
t_is(idx,[1,0,0,0,2,0,0,0,3,0],12,'triggered on correct time steps');

defrost_process.t0 = 60;
defrost_process.t0_period = (defrost_process.t0/sim.l);
idx = [];
for t = 1:sim.T
  idx(end+1) = defrost_process.t2idx(t, 'T');
end
t_is(idx,[1,0,0,0,2,0,0,0,3,0],12,'triggered on correct time steps after setting t0 period');

defrost_process.f = 180;
defrost_process.f_period = defrost_process.f/sim.l;
idx = [];
for t = 1:sim.T
  idx(end+1) = defrost_process.t2idx(t, 'T');
end
t_is(idx,[1,0,0,2,0,0,3,0,0,4],12,'triggered on correct time steps after setting f period');

defrost_process.tau = 60;
defrost_process.tau_period = defrost_process.tau/sim.l;
idx = [];
for t = 1:sim.T
  idx(end+1) = defrost_process.t2idx(t, 'T');
end
t_is(idx,[1,0,0,2,0,0,3,0,0,4],12,'triggered on correct time after setting tau period');

defrost_process.f = 60;
defrost_process.f_period = defrost_process.f/sim.l;
defrost_process.tau = 60;
defrost_process.tau_period = defrost_process.tau/sim.l;
idx = [];
for t = 1:sim.T
  idx(end+1) = defrost_process.t2idx(t, 'T');
end
t_is(idx,[1,2,3,4,5,6,7,8,9,10],12,'guarantee can set parameters to trigger on all time steps');

%% finalize
sim = mpsim();
sim.l = 60;                   %% length of simulation time step (in minutes)
sim.units = 'minutes';        %% units of sim.ls
sim.T = 10;                   %% number of simulation time steps
s = struct();
s.name = 'defrost';
s.f = 240;
s.t0 = 60;
s.tau = 180;
defrost_process = bg_defrost(s);
sim = sim.register_process(defrost_process);
processes = sim.processes;
idx = processes{1}.t2idx(4, 'F');
t_is(idx,1,12,'check finalized index is 1 on this time step');

idx = processes{1}.t2idx(5, 'F');
t_is(idx,0,12,'check finalized index is 0 on next time step');

idx = [];
for t = 1:sim.T
  idx(end+1) = processes{1}.t2idx(t, 'F');
end
t_is(idx,[0,0,0,1,0,0,0,2,0,0],12,'finalized on correct time steps');

defrost_process.t0 = 60;
defrost_process.t0_period = (defrost_process.t0/sim.l);
idx = [];
for t = 1:sim.T
  idx(end+1) = defrost_process.t2idx(t, 'F');
end
t_is(idx,[0,0,0,1,0,0,0,2,0,0],12,'finalized on correct time steps after setting t0 period');

defrost_process.f = 180;
defrost_process.f_period = defrost_process.f/sim.l;
idx = [];
for t = 1:sim.T
  idx(end+1) = defrost_process.t2idx(t, 'F');
end
t_is(idx,[0,0,0,1,0,0,2,0,0,3],12,'finalized on correct time steps after setting f period');

defrost_process.tau = 60;
defrost_process.tau_period = defrost_process.tau/sim.l;
idx = [];
for t = 1:sim.T
  idx(end+1) = defrost_process.t2idx(t, 'F');
end
t_is(idx,[0,1,0,0,2,0,0,3,0,0],12,'finalized on correct time steps after setting tau period');

defrost_process.f = 60;
defrost_process.f_period = defrost_process.f/sim.l;
defrost_process.tau = 60;
defrost_process.tau_period = defrost_process.tau/sim.l;
idx = [];
for t = 1:sim.T
  idx(end+1) = defrost_process.t2idx(t, 'F');
end
t_is(idx,[0,1,2,3,4,5,6,7,8,9],12,'guarantee can finalize on consecutive time steps by setting parameters');
t_end;
