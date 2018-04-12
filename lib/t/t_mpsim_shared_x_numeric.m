function t_mpsim_shared_x_numeric(quiet)
%T_MPSIM_SHARED_X_NUMERIC  Tests for MPSIM_SHARED_X_NUMERIC

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

if nargin < 1
    quiet = 0;
end
num_tests = 50;
t_begin(num_tests, quiet);

[p,n,e] = fileparts(which('t_mpsim_shared_x_numeric'));
sim_inputdir = p;
sim_name = 'test';

t0 = 'mpsim_shared_x_numeric (scalar) : ';
t = 'constructor : ';
sx = mpsim_shared_x_numeric('numeric_scalar');
t_ok(strcmp(class(sx), 'mpsim_shared_x_numeric'), [t0 t 'class']);
t_ok(strcmp(sx.name, 'numeric_scalar'), [t0 t 'name']);
t_ok(isempty(sx.value), [t0 t 'value']);
t_ok(isempty(sx.initial_value), [t0 t 'initial_value']);

t = 'initialize : ';
sx.initialize(sim_inputdir, sim_name);
t_is(sx.value, pi, 12, [t0 t 'value']);
t_is(sx.initial_value, pi, 12, [t0 t 'initial_value']);

t = 'update + : ';
sx.update(struct('op', '+', 'val', 2.3));
t_is(sx.value, pi + 2.3, 12, [t0 t 'value']);
t_is(sx.initial_value, pi, 12, [t0 t 'initial_value']);

t = 'update - : ';
sx.update(struct('op', '-', 'val', 2.3));
t_is(sx.value, pi, 12, [t0 t 'value']);
t_is(sx.initial_value, pi, 12, [t0 t 'initial_value']);

t = 'update * : ';
sx.update(struct('op', '*', 'val', 2.1));
t_is(sx.value, pi*2.1, 12, [t0 t 'value']);
t_is(sx.initial_value, pi, 12, [t0 t 'initial_value']);

t = 'update / : ';
sx.update(struct('op', '/', 'val', 2.1));
t_is(sx.value, pi, 12, [t0 t 'value']);
t_is(sx.initial_value, pi, 12, [t0 t 'initial_value']);

t = 'update ^ : ';
sx.update(struct('op', '^', 'val', 2));
t_is(sx.value, pi^2, 12, [t0 t 'value']);
t_is(sx.initial_value, pi, 12, [t0 t 'initial_value']);

t = 'update .^ : ';
sx.update(struct('op', '.^', 'val', 0.5));
t_is(sx.value, pi, 12, [t0 t 'value']);
t_is(sx.initial_value, pi, 12, [t0 t 'initial_value']);

t = 'update ./ : ';
sx.update(struct('op', './', 'val', 3));
t_is(sx.value, pi/3, 12, [t0 t 'value']);
t_is(sx.initial_value, pi, 12, [t0 t 'initial_value']);

t = 'update .* : ';
sx.update(struct('op', '.*', 'val', 3));
t_is(sx.value, pi, 12, [t0 t 'value']);
t_is(sx.initial_value, pi, 12, [t0 t 'initial_value']);

t = 'update = : ';
sx.update(struct('op', '=', 'val', 3*pi));
t_is(sx.value, 3*pi, 12, [t0 t 'value']);
t_is(sx.initial_value, pi, 12, [t0 t 'initial_value']);

t0 = 'mpsim_shared_x_numeric (matrix) : ';
t = 'constructor : ';
sx = mpsim_shared_x_numeric('numeric_matrix');
t_ok(strcmp(class(sx), 'mpsim_shared_x_numeric'), [t0 t 'class']);
t_ok(strcmp(sx.name, 'numeric_matrix'), [t0 t 'name']);
t_ok(isempty(sx.value), [t0 t 'value']);
t_ok(isempty(sx.initial_value), [t0 t 'initial_value']);

t = 'initialize : ';
v = [1 2; 4 3];
sx.initialize(sim_inputdir, sim_name);
t_is(sx.value, v, 12, [t0 t 'value']);
t_is(sx.initial_value, v, 12, [t0 t 'initial_value']);

t = 'update + : ';
sx.update(struct('op', '+', 'val', -2*v));
t_is(sx.value, -v, 12, [t0 t 'value']);
t_is(sx.initial_value, v, 12, [t0 t 'initial_value']);

t = 'update - : ';
sx.update(struct('op', '-', 'val', -2*v));
t_is(sx.value, v, 12, [t0 t 'value']);
t_is(sx.initial_value, v, 12, [t0 t 'initial_value']);

t = 'update .* : ';
sx.update(struct('op', '.*', 'val', 10));
t_is(sx.value, 10.*v, 12, [t0 t 'value']);
t_is(sx.initial_value, v, 12, [t0 t 'initial_value']);

t = 'update ./ : ';
sx.update(struct('op', './', 'val', 10));
t_is(sx.value, v, 12, [t0 t 'value']);
t_is(sx.initial_value, v, 12, [t0 t 'initial_value']);

t = 'update .^ : ';
sx.update(struct('op', '.^', 'val', 3));
t_is(sx.value, v.^3, 12, [t0 t 'value']);
t_is(sx.initial_value, v, 12, [t0 t 'initial_value']);
sx.update(struct('op', '.^', 'val', 1/3));

t = 'update * : ';
y = [2; 1];
sx.update(struct('op', '*', 'val', y));
t_is(sx.value, v*y, 12, [t0 t 'value']);
t_is(sx.initial_value, v, 12, [t0 t 'initial_value']);

t = 'update / : ';
sx.update(struct('op', '/', 'val', y));
t_is(sx.value, (v*y)/y, 12, [t0 t 'value']);
t_is(sx.initial_value, v, 12, [t0 t 'initial_value']);

t = 'update ^ : ';
sx.update(struct('op', '^', 'val', 2));
t_is(sx.value, ((v*y)/y)^2, 12, [t0 t 'value']);
t_is(sx.initial_value, v, 12, [t0 t 'initial_value']);

t = 'update = : ';
sx.update(struct('op', '=', 'val', -v));
t_is(sx.value, -v, 12, [t0 t 'value']);
t_is(sx.initial_value, v, 12, [t0 t 'initial_value']);

t = 'update (multiple) : ';
sx = mpsim_shared_x_numeric('numeric_matrix');
sx.initialize(sim_inputdir, sim_name);
sx_update = struct( ...
    'op',   {'-', '+', './', '.^', '.^', '.*', '*', '/', '^'}, ...
    'val',  {-2*v, -2*v, 10, 1/3, 3, 10, y, y, 2} ...
);
sx.update(sx_update);
t_is(sx.value, ((v*y)/y)^2, 12, [t0 t 'value']);
t_is(sx.initial_value, v, 12, [t0 t 'initial_value']);

t_end
