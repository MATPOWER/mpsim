classdef mpsim_process < handle
%MPSIM_PROCESS  Abstract base class for MP-Sim process objects
%
%   Implementing an MP-Sim process to be used in an MP-Sim simulator
%   requires creating a subclass of MPSIM_PROCESS and implementing,
%   at minimum, its UPDATE method to define how it will update the
%   simulator state.
%
%   Public Methods:
%       MPSIM_PROCESS - process constructor (called indirectly by subclass)
%       DISPLAY - display the process object
%       IDX2T - convert the index of a process update instance to the time
%           step in which it is triggered or finalized
%       T2IDX - convert a simulation time index into the index of the
%           process update instance triggered or finalized at that time
%
%   Private Methods (override as needed):
%       INITIALIZE - set initial value for process-specific state
%       LOAD_CURRENT_INPUTS - to load input data at each process trigger
%       PRELOAD_RUN_INPUTS - to pre-load input data at beginning of each run
%       PRELOAD_SIM_INPUTS - to pre-load input data at beginning of batch
%       INPUT - modify or update input struct U
%       OUTPUT - process output function g(x,u), create process outputs
%       PRINT_FINALIZE - print custom output upon process finalize
%       PRINT_TRIGGER - print custom output upon process trigger
%       UPDATE - implement process update function f(x,u) to update
%           process-specific and shared state
%
%   Properties:
%       name - name of process
%       f - amount of time between instances of process update
%       t0 - time at which first process update instance is triggered
%       tau - length of process run time, or amount of time from trigger
%           to corresponding finalize
%
%   See also MPSIM, MPSIM_SHARED_X

%   Private methods (should not need to override):
%       FINALIZE - return index of process update instance if process
%           finalizes in current period, 0 otherwise
%       SET_PERIOD - check timing parameters and convert units to time steps
%       TRIGGER - return index of process update instance if process
%           triggers in current period, 0 otherwise
%   Private properties:
%       f_period - number of time steps between instances of process update
%       t0_period - index of time step in which first process update instance
%           is triggered
%       tau_period - length of process run time, or number of time steps
%           from trigger to corresponding finalize

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

    properties  
        %% public
        name = '';      % name of process
        f    = 0;       % time between instances of process update
        t0   = 0;       % time at which 1st process update is triggered
        tau  = 0;       % length of process run time, time from process
                        % trigger to corresponding finalize

        %% private
        f_period = 0;   % f in units of time steps
        t0_period = 0;  % t0 in units of time steps
        tau_period = 0; % tau in units of time steps
    end
    methods
        %% constructor and methods for mpsim_process
        function ps = mpsim_process(s)
            %% error checking
            if s.tau < 0
                error('@mpsim_process/mpsim_process: tau must be nonnegative');
            end
            if strcmp(s.name, 'sim')
                error('@mpsim_process/mpsim_process: ''sim'' is not a valid process name');
            end
            ps.name = s.name;
            ps.t0   = s.t0;
            ps.f    = s.f;
            ps.tau  = s.tau;
        end

        function print_trigger(ps, x, y, r, t, idx)
        end

        function print_finalize(ps, x, y, r, t, idx)
        end
    end
end
