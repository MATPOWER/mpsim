function t_burger_shop_2d(quiet)
%T_BURGER_SHOP_2D  Tests for @burger_shop_2d simulation
%
%   Tests @burger_shop_2d, @bg2_* classes and two-dimensional batch of runs
%   based on 'burger_shop_example' inputs.

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

if nargin < 1
    quiet = 0;
end
num_tests = 22;
t_begin(num_tests, quiet);

%% multi-dimensional batch of runs
sim = burger_shop_2d().run('burger_shop_example', 'R', [2,2], 'post_run_print', 0);
up = sim.u_preloaded;

t_ok(isfield(sim.y,'order'),'outputs has order field');
t_ok(isfield(sim.y,'deliver'),'outputs has deliver field');
t_ok(isfield(sim.y,'defrost'),'outputs has defrost field');
t_ok(isfield(sim.y,'grill'),'outputs has grill field');
t_is(length(sim.y), 1, 12, 'length of outputs');

current = pwd();
outputdir = sim.outputdir();
cd(outputdir);
load final_data_burger_multi_run
cd(current);
matrix_size = size(matrix_data);
t_is(matrix_data(matrix_size(1),:),[2 2 54 6350 6350 6460 6376 6370],...
    12, 'post-run output correctness verification part 1');
t_is(matrix_data(1,1:matrix_size(2)),[1950 0 0 12 21 700 100 25], ...
    12, 'post-run output correctness verification part 2');

%manually calculated that there will be one time delivery is made.
t_is(matrix_data(1:5,6:8), ...
    [[700;700;390;1090;970],[100;88;344;173;160],[25;16;24;29;22]], ...
    12, 'post-run output correctness verification part 3');
t_is(matrix_data(sim.T-6+(0:4),6:8), ...
    [[930;830;830;520;1070],[122;146;133;346;194],[28;30;22;29;22]], ...
    12, 'post-run output correctness verification part 4');

t_is(sim.y.grill(1,1,1).grills,12,12,'outputs grill 3d part 1');
t_is(sim.y.grill(1,1,2).grills,54,12,'outputs grill 3d part 2');
t_is(sim.y.grill(2,1,2).grills,33,12,'outputs grill 3d part 3');
t_is(sim.y.grill(2,2,2).grills,39,12,'outputs grill 3d part 4');
t_is(sim.t, 55, 12, 'sim time step at the end');
t_is(sim.R, [2,2],12, 'sim total number of runs');
t_is(sim.T, 54, 12, 'sim total number of periods');
t_ok(isequaln(sim.r,{2,2}), 'sim runs at the end');
t_is(length(sim.processes), 4, 12, 'total number of processes');
t_ok(isfield(sim.shared_x_objects,'order_queue'),'order queue exists');
t_ok(isfield(sim.shared_x_objects,'frozen_inventory'),'frozen inventory exists');
t_ok(isfield(sim.shared_x_objects,'thawed_inventory'),'thawed inventory exists');
t_ok(isfield(sim.shared_x_objects,'grilled_inventory'),'grilled inventory exists');
  
t_end
