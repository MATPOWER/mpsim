classdef bg2_order < bg_order
%Order process is subclass of @MPSIM_PROCESS

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

    properties
    end
    methods
        function obj = bg2_order(s)
            obj@bg_order(s);
        end
    end
end
