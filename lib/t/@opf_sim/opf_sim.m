classdef opf_sim < mpsim
%Subclass of MPSIM in OPF simulation.  Specify all simulation definitions here.

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

    properties
    end
    methods
        function initialize(sim)
            %% set default values for simulator properties
            sim.l = 1;              %% l, length of simulation time step
            sim.units = 'hours';    %% units of l, length of time step
            sim.T = 24*3;           %% T, number of simulation periods
            sim.R = 2;              %% R, dimension(s) of simulation runs

            %% create and register process objects
            sim.register_process(opf_hourly_dispatch(...
                struct( 'name', 'dispatch', ...
                        'f', 1, ...
                        't0', 1, ...
                        'tau', 0) ));
        end
    end
end
