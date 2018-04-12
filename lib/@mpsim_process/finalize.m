function idx = finalize(ps, sim)
%FINALIZE  Returns 0, or finalize index if finalizing on current time step.
%
%   IDX = PS.FINALIZE(SIM)
%
%   Returns false unless the process finalizes at the current simluation
%   time step. Otherwise returns the index of the process update instance
%   (i.e. the number of times the process has been finalized up to and
%   including the current time step).
%
%   Input:
%       PS - process object
%       SIM  - simulator object
%
%   Output:
%       IDX - index of process update instance; i.e. 0 if not finalizing
%             at sim.t, number of times finalized otherwise

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

idx = ps.t2idx(sim.t, 'F');
