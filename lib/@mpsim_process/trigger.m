function idx = trigger(ps, sim)
%TRIGGER  Returns 0, or trigger index if triggering on current time step.
%
%   IDX = PS.TRIGGER(SIM)
%
%   Returns false unless the process triggers at the current simluation
%   time step. Otherwise returns the index of the process update instance
%   (i.e. the number of times the process has been triggered up to and
%   including the current time step).
%
%   Input:
%       PS - process object
%       SIM  - simulator object
%
%   Output:
%       IDX - index of process update instance; i.e. 0 if not triggering
%             at sim.t, number of times triggered otherwise

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

idx = ps.t2idx(sim.t, 'T');
