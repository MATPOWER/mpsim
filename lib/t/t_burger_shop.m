function t_burger_shop(quiet)
%T_BURGER_SHOP  Tests for @burger_shop simulation
%
%   Tests @burger_shop, @bg_* classes and single-dimensional batch of runs
%   based on 'burger_shop_example' inputs.

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

if nargin < 1
    quiet = 0;
end
num_tests = 28;
t_begin(num_tests, quiet);

%% configs
config = mpsim_config();
t_ok(isfield(config,'inputdir'),'config inputdir is a field');
t_ok(isfield(config,'workdir'),'config workdir directory is a field');
t_ok(isfield(config,'outputdir'),'config outputdir is a field');

%% single-dimensional batch of runs
sim = burger_shop().run('burger_shop_example', 'post_run_print', 0);
up = sim.u_preloaded;

t_ok(isfield(sim.y,'order'),'outputs has field order');
t_ok(isfield(sim.y,'deliver'),'outputs has field deliver');
t_ok(isfield(sim.y,'defrost'),'outputs has field defrost');
t_ok(isfield(sim.y,'grill'),'outputs has field grill');
t_is(length(sim.y), 1, 12, 'length of outputs is 1');
t_is(sim.y.grill(1,1).grills,12,12,'outputs grill grills');
t_is(sim.y.grill(1,1).sold,21,12,'outputs grill sold');
t_is(sim.y.grill(1,1).frozen_inventory,700,12,'outputs grill frozen_inventory');
t_is(sim.y.grill(1,1).thawed_inventory,100,12,'outputs grill thawed_inventory');
t_is(sim.y.grill(1,1).grilled_inventory,25,12,'outputs grill grilled_inventory');
t_is(sim.y.order(1,1),1950,12,'outputs order result in 1st period of 1st run');
t_is(sim.y.deliver(1,1),700,12,'outputs deliver result 1st period, 1st run');
t_is(sim.y.defrost(1,1),310,12,'outputs defrosted 1st period, 1st run');
t_is(sim.t, 55, 12, 'simulation time step at end');
t_is(sim.R, 2, 12, 'simulation total runs');
t_is(sim.T, 54, 12, 'simulation total time steps');
t_is(sim.r{1}, 2 ,12, 'simulation runs at end');
t_is(length(sim.processes), 4, 12, 'number of processes');
t_ok(isfield(sim.shared_x_objects,'order_queue'), 'order queue exists');
t_ok(isfield(sim.shared_x_objects,'frozen_inventory'), 'frozen inventory exists');
t_ok(isfield(sim.shared_x_objects,'thawed_inventory'), 'thawed inventory exists');
t_ok(isfield(sim.shared_x_objects,'grilled_inventory'), 'grilled inventory exists');
current = pwd();
outputdir = sim.outputdir();
cd(outputdir);
load final_data_burger_single_run
cd(current);
matrix_size = size(matrix_data);
t_is(matrix_data(matrix_size(1),:),[2,0,54,6350,6350,6450,6362,6370],12,...
    'post-run output correctness verification part 1');
t_is(matrix_data(1:4,1:5), [[1950,0,0,12,21];[0,0,310,54,46];...
    [0,700,0,171,166];[0,0,120,133,140]],12,...
    'post-run output correctness verification part 2');
t_is(matrix_data(matrix_size(1)-3:matrix_size(1)-1,:), ...
    [[0,0,120,175,174,730,176,30];[0,0,0,84,84,730,92,30];[0,0,130,34,47,600,188,17]], ...
    12,'post-run output correctness verification part 3');

t_end
