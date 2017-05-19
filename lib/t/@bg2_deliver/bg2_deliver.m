classdef bg2_deliver < bg_deliver
%Deliver process is subclass of @MPSIM_PROCESS

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

    properties
    end
    methods
        function obj = bg2_deliver(s)
            obj@bg_deliver(s);
        end
    end
end
