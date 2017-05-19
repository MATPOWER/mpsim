function t_mpsim_shared_x_queue(quiet)
%T_MPSIM_SHARED_X_QUEUE  Tests for MPSIM_SHARED_X_QUEUE

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

if nargin < 1
    quiet = 0;
end
num_tests = 20;
t_begin(num_tests, quiet);

[p,n,e] = fileparts(which('t_mpsim_shared_x_queue'));
sim_inputdir = p;
sim_name = 'test';

t0 = 'mpsim_shared_x_queue : ';
t = 'constructor : ';
sx = mpsim_shared_x_queue('queue');
t_ok(strcmp(class(sx), 'mpsim_shared_x_queue'), [t0 t 'class']);
t_ok(strcmp(sx.name, 'queue'), [t0 t 'name']);
t_ok(isempty(sx.value), [t0 t 'value']);
t_ok(isempty(sx.initial_value), [t0 t 'initial_value']);

t = 'initialize : ';
sx.initialize(sim_inputdir, sim_name);
t_ok(isequaln(sx.value, {}), [t0 t 'value']);
t_ok(isequaln(sx.initial_value, {}), [t0 t 'initial_value']);

t = 'update + : ';
sx.update(struct('op', '+', 'val', 2.3));
t_ok(isequaln(sx.value, {2.3}), [t0 t 'value']);
t_ok(isequaln(sx.initial_value, {}), [t0 t 'initial_value']);
sx.update(struct('op', '+', 'val', {[1;2;3], {{'hello', 'world'}}}));
t_ok(isequaln(sx.value, {2.3, [1;2;3], {'hello', 'world'}}), [t0 t 'value']);
t_ok(isequaln(sx.initial_value, {}), [t0 t 'initial_value']);

t = 'update - : ';
sx.update(struct('op', '-', 'val', 2));
t_ok(isequaln(sx.value, {{'hello', 'world'}}), [t0 t 'value']);
t_ok(isequaln(sx.initial_value, {}), [t0 t 'initial_value']);

t = 'update (multiple) : ';
sx_update = struct( ...
     'op',   {'+', '-', '+', '-'}, ...
     'val',  {{'foo', pi, struct('x', 1, 'y', 0), 'bar'}, 2, 'hey', 1} ...
);
sx.update(sx_update);
t_ok(isequaln(sx.value, {struct('x', 1, 'y', 0), 'bar', 'hey'}), [t0 t 'value']);
t_ok(isequaln(sx.initial_value, {}), [t0 t 'initial_value']);

t0 = 'mpsim_shared_x_queue (with read_input()) : ';
t = 'constructor : ';
sx = mpsim_shared_x_queue('test_queue');
t_ok(strcmp(class(sx), 'mpsim_shared_x_queue'), [t0 t 'class']);
t_ok(strcmp(sx.name, 'test_queue'), [t0 t 'name']);
t_ok(isempty(sx.value), [t0 t 'value']);
t_ok(isempty(sx.initial_value), [t0 t 'initial_value']);

t = 'initialize : ';
val0 = {3, 'Hello FIFO!', struct('x', 1, 'y', 2)};
sx.initialize(sim_inputdir, sim_name);
t_ok(isequaln(sx.value, val0), [t0 t 'value']);
t_ok(isequaln(sx.initial_value, val0), [t0 t 'initial_value']);

t_end
