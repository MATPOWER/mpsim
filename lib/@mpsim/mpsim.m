classdef mpsim < handle
%MPSIM  Abstract base class for MP-Sim simulator objects
%
%   Given a subclass of MPSIM named 'mysim' and a corresponding simulation
%   batch named 'mybatch', the simulation can be executed as:
%
%       sim = mysim();
%       sim.run('mybatch');
%
%   Implementing an MP-Sim simulation requires creating a subclass of
%   MPSIM and implmenting, at minimum, its INITIALIZE method to define
%   the default values for the simulator properties, to add any shared
%   state objects and to create and register the process objects.
%
%   Public Methods:
%       MPSIM - simulator object constructor (called indirectly by subclass)
%       ADD_SHARED_STATE - add a shared state object and initial val to sim
%       DISPLAY - display information about simulator properties and processes
%       REGISTER_PROCESS - register a process with the simulator
%       RESET - set time index to 1, reset simulator state to initial value
%       RUN - execute specified runs of the simulation
%
%   Private Methods (override as needed):
%       INITIALIZE - set default simulator properties, create and add any
%           shared states, create and register processes
%       LOAD_CURRENT_INPUTS - to load input data at each time step
%       PRELOAD_RUN_INPUTS - to pre-load input data at beginning of each run
%       PRELOAD_SIM_INPUTS - to pre-load input data at beginning of batch
%       POST_RUN - for post-processing simulation outputs
%
%   Properties:
%       l - length of simulation time step
%       units - string value of units of l, for user reference only
%           (e.g. 'minutes' or 'hours')
%       name - name of current simulation batch, also used as part of
%           path to simulation datas
%       processes - cell arrary of process objects registered with simulator
%       R - scalar or vector of dimension of runs in current simulation batch
%       T - number of simulation time steps per run in current simulation batch
%       r - index(es) of current run: 1-D cell array of scalars
%       t - index of current simulation time step
%       x - simulator state, with process-specific portion in x.(process name)
%           and shared portion in x.shared.(shared state name)
%       y - outputs accumulated during the simulation for post-
%           processing by POST_RUN method. struct with process names as
%           field names, indexed by runs and process finalization index.
%           e.g. y.(ps_name)(r,idx)
%       verbose - (0–3), option specifying level of detailed progress to be
%           printed to screen during a simulation run (default = 0, i.e. no
%           output)
%       inspect - (0, 1), option to automatically enter debugger at end of
%           INPUT method to allow user to inspect the input struct
%           (default = 0)
%       post_run_on - (0, 1) option controlling whether or not POST_RUN
%           method is executed (default = 1)
%       options - struct containing custom options passed to run or run all;
%           includes all options passed except the standard R, T, verbose,
%           inspect and post run on which are modified directly in the
%           corresponding SIM properties
%
%   See also MPSIM_PROCESS, MPSIM_SHARED_X

%   Private methods (should not need to override):
%       APPLY_PS_X - apply queued update to process-specific state
%       APPLY_RUN_OPTIONS - copy set of run options to simulator object
%       APPLY_SHARED_X - apply queued update for given process to shared state
%       INCREMENT_RUN - increment simulation run counter in SIM.R
%       INITIALIZE_OUTPUT - initialize the output cache in SIM.Y
%       INPUT - construct input struct U for current run and time step
%       INPUTDIR - return path to a simulation-specific input file or directory
%       OUTPUT - collect output from finalizing processes that provide it
%       OUTPUTDIR - return path to a simulation-specific output file or
%           directory
%       PRELOAD_ALL_RUN_INPUTS - cache results of PRELOAD_RUN_INPUTS for
%           simulator and processes
%       PRELOAD_ALL_SIM_INPUTS - cache results of PRELOAD_SIM_INPUTS for
%           simulator and processes
%       QUEUE_OUT_ARGS - push arguments to pass from PS.UPDATE() to PS.OUTPUT()
%           to corresponding FIFO queue
%       QUEUE_PS_X - push updated process-specific state to corresponding
%           FIFO queue
%       QUEUE_SHARED_X - push shared state updates to corresponding FIFO queue
%       STEP - update state for finalizing processes and increment time step
%       UPDATE - call PS.UPDATE() for processes triggered at current time step
%       WORKDIR - return path to a simulation-specific work file or directory
%   Private properties:
%       config - struct of paths to base directories for input, output and
%           temporary work files in fields inputdir, outputdir and workdir,
%           respectively, as specified in MPSIM_CONFIG
%       out_args - current set of arguments, as provided by PS.UPDATE(),
%           to be passed to SIM.OUTPUT()
%       shared_x_objects - struct of shared state objects used to update
%           shared portion of state x, fields named according to name of
%           corresponding shared state object
%       shared_x_names - cell arry of names of shared state fields/objects
%       u_preloaded - input data preloaded at the beginning of the
%           simulation or the beginning each run by the simulator
%           and process PRELOAD_SIM_INPUTS and PRELOAD_RUN_INPUTS
%           methods
%       x0 - copy if initial simulator state x made before first run
%       x_updates - updates to simulator state to be applied when processes
%           finalize

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

    properties
        %% public
        l               = 1;           % length of simulation time step
        units           = '';          % units of l (for user reference only)
        name            = '';          % name of current simulation batch
        processes       = {};          % cell array of registered process objs
        R               = 1;           % dim of runs in current sim batch
        T               = [];          % number of time steps per run
        r               = {1};         % index(es) of current run
        t               = 1;           % index of current sim time step
        x               = struct();    % simulator state
        y               = struct();    % outputs accumulated in simulation
        verbose         = 0;           % level of progress detail to print
        inspect         = 0;           % option to inspect all parts of simulation in middle of its running
        post_run_on     = 1;           % option to run user-defined function after simulation
        options         = struct();    % whole options struct stored to be able to use (e.g. POST_RUN())

        %% private
        config          = struct();    % paths to directories from MPSIM_CONFIG
        out_args        = struct();    % data passed from UPDATE() to OUTPUT()
        shared_x_objects= struct();    % shared state objects
        shared_x_names  = {};          % names of shared state fields/objects
        u_preloaded     = struct();    % inputs used in simulation
        x0              = struct();    % state at simulation initialization
        x_updates       = struct();    % changes to be applied on x
    end
    methods
        %% constructor and methods for mpsim
        function sim = mpsim()
            config  = mpsim_config();
            sim.config.inputdir     = config.inputdir;
            sim.config.outputdir    = config.outputdir; 
            sim.config.workdir      = config.workdir;
            sim.x_updates           = struct();
            sim.x.shared            = struct();
            
            sim.initialize();
        end

        function initialize(sim)
%           error('@mpsim/initialize: Please override/implement initialize() in your simulator subclass');
        end

        function post_run(sim, y, sim_outputdir)
        end
    end
end
