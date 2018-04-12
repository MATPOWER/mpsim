function u = input(sim, sim_inputdir, r, t)
%INPUT  Construct input struct U for current run and time step
%
%   U = SIM.INPUT(SIM_INPUTDIR, R, T)
%
%   Assembles the input struct U for current run and time step from
%   cached data that was preloaded by PRELOAD_SIM_INPUTS and PRELOAD_RUN_INPUTS
%   methods of the simulation and process objects, and data loaded at the
%   current time step by the LOAD_CURRENT_INPUTS method of the simulator
%   object and any processes triggered at the specified time step.
%  
%   Input:
%       SIM - simulator object
%       SIM_INPUTDIR - path to simulation inputs
%       R - index(es) of simulation run (cell array)
%       T - index of current time step
%
%   Output:
%       U - struct of inputs for current run and time step

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

u  = struct();
up = sim.u_preloaded;

%% simulator inputs preloaded at beginning of simulation
if ~isempty(up.sim.thissim)
    u = nested_struct_copy_mpsim(u, up.sim.thissim);
end
if ~isempty(up.sim.byrun)
    u = nested_struct_copy_mpsim(u, up.sim.byrun(r{:}));
end
if ~isempty(up.sim.byt)
    u = nested_struct_copy_mpsim(u, up.sim.byt(t));
end
if ~isempty(up.sim.byboth)
    u = nested_struct_copy_mpsim(u, up.sim.byboth(r{:},t));
end

%% simulator inputs preloaded at beginning of current run
if ~isempty(up.sim.thisrun.thisrun)
    u = nested_struct_copy_mpsim(u, up.sim.thisrun.thisrun);
end
if ~isempty(up.sim.thisrun.byt)
    u = nested_struct_copy_mpsim(u, up.sim.thisrun.byt(t));
end

%% simulator inputs for this time step
thisidx = sim.load_current_inputs(sim.name, sim_inputdir, r, t);
if ~isempty(thisidx)
    u = nested_struct_copy_mpsim(u, thisidx);
end

%% input setup for processes
for k = 1:length(sim.processes)
    ps = sim.processes{k};
    idx = ps.trigger(sim);
    if idx      %% triggering
        %% process-specific inputs preloaded at beginning of simulation
        if ~isempty(up.(ps.name).thissim)
            u = nested_struct_copy_mpsim(u, up.(ps.name).thissim);
        end
        if ~isempty(up.(ps.name).byrun)
            u = nested_struct_copy_mpsim(u, up.(ps.name).byrun(r{:}));
        end
        if ~isempty(up.(ps.name).byidx)
            u = nested_struct_copy_mpsim(u, up.(ps.name).byidx(idx));
        end
        if ~isempty(up.(ps.name).byboth)
            u = nested_struct_copy_mpsim(u, up.(ps.name).byboth(r{:},idx));
        end

        %% process-specific inputs preloaded at beginning of current run
        if ~isempty(up.(ps.name).thisrun.thisrun)
            u = nested_struct_copy_mpsim(u, up.(ps.name).thisrun.thisrun);
        end
        if ~isempty(up.(ps.name).thisrun.byidx)
            u = nested_struct_copy_mpsim(u, up.(ps.name).thisrun.byidx(idx));
        end

        %% process-specific inputs for this time step
        nidx = ps.t2idx(sim.T, 'F', 1);
        thisidx_input_process = ps.load_current_inputs( ...
                sim.name, sim_inputdir, sim.R, nidx, r, idx);
        if ~isempty(thisidx_input_process)
            u = nested_struct_copy_mpsim(u, thisidx_input_process);
       end
    end
end

%% one last chance for each triggered process to modify u
for k = 1:length(sim.processes)
    ps = sim.processes{k};
    idx = ps.trigger(sim);
    if idx      %% triggering
        u = ps.input(u, sim_inputdir, r, idx);
    end
end

if sim.inspect == 1
    keyboard
end
