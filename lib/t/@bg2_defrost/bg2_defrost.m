classdef bg2_defrost < bg_defrost
%Defrost process is subclass of @MPSIM_PROCESS

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

    properties
    end
    methods
        function obj = bg2_defrost(s)
            obj@bg_defrost(s);
        end
    end
end
