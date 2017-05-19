function sim = run(sim, sim_name, varargin)
%RUN  Runs the simulation
%
%   SIM = SIM.RUN(SIM_NAME, OPT_STRUCT)
%   SIM = SIM.RUN(SIM_NAME, OPT1_NAME, OPT1_VAL, ...)
%   SIM = SIM.RUN(SIM_NAME, OPT1_NAME, OPT1_VAL, ... OPT_STRUCT)
%
%   Executes the specified runs of the simulation using the input, output
%   and work directories and files corresponding to the simulation batch
%   indicated by SIM_NAME, and the specified MP-Sim options. If the 'r'
%   option is not specified, it executes all runs specified by the 'R'
%   attribute of the simulation, which can be set at run time by the 'R'
%   option.
%
%   Input:
%       SIM - simulator object
%       SIM_NAME - name of current simulation batch
%       OPT1_NAME - name of an MP-Sim option
%       OPT1_VAL - value for MP-Sim option named in OPT1_NAME
%       OPT_STRUCT - struct of MP-Sim options
%
%   MP-Sim options can be specified as a struct (OPT_STRUCT) or a set of
%   name/value pairs (OPT1_NAME, OPT1_VAL, etc) or a combination of both.
%   The following are standard options that are available in the
%   corresponding public attributes of the simulator object.
%       'verbose' - integer from 0 to 4 specifying the level of detail of
%           progress output printed during the simulation. Default = 0.
%       'inspect' - 1 to pause simulation at each step after construction
%           of the input data u to allow inspection. Default = 0.
%       'r' - index(es) of single simulation run to execute (cell array)
%       'R' - scalar or vector of dimension of runs to execute
%       'T' - number of simulation time steps per run to execute
%
%   All other options are considered custom options and are available in
%   sim.options.
%
%   Output:
%       SIM - simulator object
%
%   Examples:
%       sim = burger_shop();
%       sim.run('burger_shop_example');
%           (executes all runs for all time periods with no progress output)
%       sim.run('burger_shop_example', 'verbose', 1, 'R', 2, 'T', 5);
%           (executes 2 runs for 5 time periods with minimal level of
%            progress output displayed)
%       opt = struct('verbose', 2);
%       sim.run('burger_shop_example', 'r', {2}, opt);
%           (executes run #2 for all time periods with more detailed
%            progress output)

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

%% misc setup
sim.name = sim_name;
sim.apply_run_options(varargin{:});
sim_inputdir = sim.inputdir();

%% check for existence of simulation input directory
if ~exist(sim_inputdir, 'dir')
    error('@mpsim/run: simulation input directory ''%s'' does not exist', sim_inputdir);
end

%% single run
if isfield(sim.options, 'r') && ~isempty(sim.options.r)
    single_run = 1;
    sim.r = sim.options.r;  %% set r from options
    sim.post_run_on = 0;    %% disable post_run_on
else
    single_run = 0;         %% set r to all 1's
    sim.r = num2cell(ones(1, length(sim.R)));
end

%% initialize shared state
for i = 1:length(sim.shared_x_names)
    sx_name = sim.shared_x_names{i};
    sx = sim.shared_x_objects.(sx_name);
    sx_val = sx.initialize(sim.inputdir(), sim_name);
    sim.x.shared.(sx_name) = sx_val;
    sim.shared_x_objects.(sx_name) = sx;
end

%% initialize process-specific state
for i = 1:length(sim.processes)
    ps = sim.processes{i};
    sim.x.(ps.name) = ps.initialize(sim.x, sim_inputdir);
end

%% save copy of initial state (for possible subsequent runs)
sim.x0 = sim.x;

%% preload inputs and initialize output data structure
sim.preload_all_sim_inputs();
sim.initialize_output();

%% loop over runs in simulation batch
done = 0;
while ~done
    %% prepare the run
    sim.reset();
    sim.preload_all_run_inputs(sim.r);

    %% execute the run
    while sim.t <= sim.T
        u = sim.input(sim.inputdir(), sim.r, sim.t);
        sim.update(sim.x, u, sim.workdir(), sim.r, sim.t);
        sim.output(u, sim.outputdir(), sim.r, sim.t);
        sim.step();
    end

    %% are we done?
    if single_run
        done = 1;
    else
        done = sim.increment_run();
    end
end

%% post-processing of output
if sim.post_run_on == 1
    sim.post_run(sim.y, sim.outputdir());
end

%% summary output
if sim.verbose > 0
    fprintf('======================\n');
    fprintf('  Simulation Summary\n');
    fprintf('======================\n');
    fprintf('Simulator Class: ''%s''\n', class(sim));
    fprintf('Simulation Name: ''%s''\n', sim_name);
    fprintf('Number of runs:%s\n', sprintf(' %d', sim.R));
    fprintf('Simulation periods per run: %d\n', sim.T);
    fprintf('Simulation time step: %d %s\n\n', sim.l, sim.units);
    for k = 1:length(sim.processes)
        ps = sim.processes{k};
        fprintf('  ''%s'' process:\n  -------------------------------------------\n', ps.name);
        fprintf('  triggered at t = %d, then every %d period(s)\n', ps.t0_period, ps.f_period);
        fprintf('  runs for %d periods\n\n', ps.tau_period);
    end
end
