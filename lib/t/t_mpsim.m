function t_mpsim(quiet)
% T_MPSIM tests the functions of MPSIM and state values
% 
% Tests:
%  -ADD_SHARED_STATE
%  -APPLY_PS_X
%  -APPLY_SHARED_X
%  -properties of MPSIM (i.e. state)
%  -QUEUE_PS_X
%  -QUEUE_SHARED_X
%  -REGISTER_PROCESS

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

  if nargin < 1
    quiet = 0;
  end
  num_tests = 42;
  t_begin(num_tests, quiet);
  
  %% Registering processes
  sim = mpsim();
  sim.l = 60;                   %% length of simulation time step (in minutes)
  sim.units = 'minutes';        %% units of sim.ls
  sim.T = 15;                   %% number of simulation time steps
  s = struct();
  s.name = 'process1';
  s.t0 = 60;
  s.f = 480;
  s.tau = 360;
  process = bg_defrost(s);
  sim = sim.register_process(process);
  processes = sim.processes;
  process_name = processes{1}.name;
  sim.x.(process_name) = processes{1}.initialize(sim.x, sim.inputdir());
  x = sim.x;
  t_is(length(processes),1,12,'number of processes');
  t_ok(strcmp(process_name,'process1'), 'name of process');
  t_is(x.(process_name),0,12,'value of process-specific state');
  t_ok(isequaln(sim.x_updates.(process_name),{}), 'to-be-copied process-specific state is empty');
  t_ok(isequaln(sim.x_updates.shared.(process_name),{}), 'to-be-copied shared state is empty');
  
  t_is(processes{1}.t0_period,1,12,'period of initial time when process is triggered');
  t_is(processes{1}.f_period,8,12,'period of frequency of process triggering');
  t_is(processes{1}.tau_period,6,12,'duration of update of process');
  
  %% Shared x (state)
  sim = mpsim();
  sim.l = 60;                   %% length of simulation time step (in minutes)
  sim.units = 'minutes';        %% units of sim.ls
  sim.T = 5;                    %% number of simulation time steps
  sim.name = 'burger_shop_example';
  ord_queue   = mpsim_shared_x_queue('order_queue');
  frozen_inv  = mpsim_shared_x_numeric('frozen_inventory');
  thawed_inv  = mpsim_shared_x_numeric('thawed_inventory');
  grilled_inv = mpsim_shared_x_numeric('grilled_inventory');

  sim.add_shared_state(ord_queue);
  sim.add_shared_state(frozen_inv);
  sim.add_shared_state(thawed_inv);
  sim.add_shared_state(grilled_inv);
  
  %taken from @MPSIM/RUN to verify correctness
  for i = 1:length(sim.shared_x_names)
    sx_name = sim.shared_x_names{i};
    sx = sim.shared_x_objects.(sx_name);
    sx_val = sx.initialize(sim.inputdir(), sim.name);
    sim.x.shared.(sx_name) = sx_val;
    sim.shared_x_objects.(sx_name) = sx;
  end
  
  t_ok(isequaln(sim.x.shared.order_queue,{}),'contents of order queue for shared state');
  t_is(sim.x.shared.frozen_inventory,700,12,'value of frozen inventory');
  t_is(sim.x.shared.thawed_inventory,100,12,'value of thawed inventory');
  t_is(sim.x.shared.grilled_inventory,25,12,'value of grilled inventory');
  
  t_ok(strcmp(sim.shared_x_objects.order_queue.name,'order_queue'),'name of order queue');
  t_ok(strcmp(sim.shared_x_objects.frozen_inventory.name,'frozen_inventory'),'name of frozen inventory');
  t_ok(strcmp(sim.shared_x_objects.thawed_inventory.name,'thawed_inventory'),'name of thawed inventory');
  t_ok(strcmp(sim.shared_x_objects.grilled_inventory.name,'grilled_inventory'),'name of grilled inventory');
  
  s = struct();
  s.name = 'defrost';
  s.t0 = 60;
  s.f = 240;
  s.tau = 180;
  defrost_process = bg_defrost(s);
  sim = sim.register_process(defrost_process);
  
  s2 = struct();
  s2.name = 'order';
  s2.t0 = 60;
  s2.f = 240;
  s2.tau = 180;
  order_process = bg_order(s2);
  sim = sim.register_process(order_process);
  
  processes = sim.processes;
  process_name = processes{1}.name;
  process_name2 = processes{2}.name;
  
  %taken from @MPSIM/RUN to verify correctness
  sim_inputdir = sim.inputdir();
  for i = 1:length(sim.processes)
    ps = sim.processes{i};
    sim.x.(ps.name) = ps.initialize(sim.x, sim_inputdir);
  end
  
  xs_updates1 = struct( ...
    'frozen_inventory', struct('op', '-', 'val', 25), ...
    'thawed_inventory', struct('op', '+', 'val', 34) ...
  );
  xs_updates2 = struct( ...
    'order_queue', struct('op', '+', 'val', 1) ...
  );
  sim = sim.queue_shared_x(process_name, xs_updates1);
  sim = sim.queue_shared_x(process_name2, xs_updates2);
  
  t_is(length(sim.x_updates.shared.defrost),1,12,'number of elements in shared state to-be-updated by defrost');
  t_ok(isequaln(sim.x_updates.shared.defrost{1}.frozen_inventory, struct('op', '-', 'val', 25)),'value frozen inventory will be updated by');
  t_ok(isequaln(sim.x_updates.shared.defrost{1}.thawed_inventory, struct('op', '+', 'val', 34)),'value thawed inventory will be updated by');
  t_is(length(sim.x_updates.shared.order),1,12,'number of elements in shared state to-be-updated by order');
  t_ok(isequaln(sim.x_updates.shared.order{1}.order_queue, struct('op', '+', 'val', 1)),'queue that will update (replace) order queue');
  
  sim = sim.apply_shared_x(process_name);
  x = sim.x;
  t_ok(isequaln(x.shared.order_queue,{}),'order queue not affected by defrost');
  t_is(x.shared.frozen_inventory,675,12,'frozen inventory reduced by 25');
  t_is(x.shared.thawed_inventory,134,12,'thawed inventor increased by 34');
  t_is(length(sim.x_updates.shared.(process_name)),0,12,'no more state changes to make for defrost');
  
  sim = sim.apply_shared_x(process_name2);
  x = sim.x;
  t_ok(isequaln(x.shared.order_queue,{1}),'order queue changed by order');
  t_is(x.shared.frozen_inventory,675,12,'frozen inventory unaffected by order');
  t_is(x.shared.thawed_inventory,134,12,'thawed inventory unaffected by order');
  t_is(length(sim.x_updates.shared.(process_name2)),0,12,'no more changes to make for order');
  
  %% process-specific states
  sim = mpsim();
  sim.l = 60;                   %% length of simulation time step (in minutes)
  sim.units = 'minutes';        %% units of sim.ls
  sim.T = 5;                    %% number of simulation time steps
  s = struct();
  s.name = 'defrost';
  s.t0 = 60;
  s.f = 240;
  s.tau = 180;
  defrost_process = bg_defrost(s);
  sim = sim.register_process(defrost_process);
  
  s2 = struct();
  s2.name = 'grill';
  s2.t0 = 60;
  s2.f = 240;
  s2.tau = 180;
  grill_process = bg_grill(s2);
  sim = sim.register_process(grill_process);
  
  s3 = struct();
  s3.name = 'deliver';
  s3.t0 = 120;
  s3.f = 180;
  s3.tau = 120;
  deliver_process = bg_deliver(s3);
  sim = sim.register_process(deliver_process);
  
  processes = sim.processes;
  process_name = processes{1}.name;
  
  %taken from @MPSIM/RUN to verify correctness
  sim_inputdir = sim.inputdir();
  for i = 1:length(sim.processes)
    ps = sim.processes{i};
    sim.x.(ps.name) = ps.initialize(sim.x, sim_inputdir);
  end
  
  t_ok(strcmp(process_name,'defrost'),'process name is defrost');
  x = sim.x;
  t_is(x.(process_name),0,12,'process-specific state is empty');
  x_ps = 117;
  sim = sim.queue_ps_x(process_name,x_ps);
  x = sim.x;
  t_ok(isequaln(sim.x_updates.(process_name),{117}),'defrost will be updated by 117');
  sim = sim.apply_ps_x(process_name);
  x = sim.x;
  t_is(x.(process_name),117,12,'after update, process-specific state is 117');
  t_is(length(sim.x_updates.(process_name)),0,12,'cache storing defrost update value now empty');
  
  process_name2 = processes{2}.name;
  process_name3 = processes{3}.name;
  
  t_ok(strcmp(process_name2,'grill'),'process name is grill');
  t_ok(strcmp(process_name3,'deliver'),'process name is deliver');
  x = sim.x;
  t_ok(isstruct(x.(process_name2)) && ...
    isfield(x.(process_name2), 'grilled') && ...
    isfield(x.(process_name2), 'sold') && ...
    x.(process_name2).grilled == 0 && ...
    x.(process_name2).sold == 0,'initial grill state is struct');
  t_is(x.(process_name3),0,12,'initial deliver state is empty');
  ps_x2 = 10;
  ps_x3 = 124;
  sim = sim.queue_ps_x(process_name2,ps_x2);
  sim = sim.queue_ps_x(process_name3,ps_x3);
  sim = sim.apply_ps_x(process_name2);
  sim = sim.apply_ps_x(process_name3);
  x = sim.x;
  t_is(x.(process_name2),10,12,'grill state now 10 after applying changes');
  t_is(x.(process_name3),124,12,'deliver state now 124 after applying changes');
  t_is(length(sim.x_updates.(process_name2)),0,12,'cache storing grill update value now empty');
  t_is(length(sim.x_updates.(process_name3)),0,12,'cache storing deliver update value now empty');
  t_end;