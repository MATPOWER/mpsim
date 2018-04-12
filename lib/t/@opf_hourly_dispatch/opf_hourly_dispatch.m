classdef opf_hourly_dispatch < mpsim_process
%OPF_HOURLY_DISPATCH Subclass of MPSIM_PROCESS

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

    properties
    end
    methods
        function obj = opf_hourly_dispatch(s)
            obj@mpsim_process(s);
        end
    end
end
