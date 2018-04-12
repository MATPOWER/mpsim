function idx = t2idx(ps, t, TorF, mode)
%T2IDX  Returns index of process update instance for given time index
%
%   IDX = PS.T2IDX(T, 'T')
%   IDX = PS.T2IDX(T, 'F')
%   IDX = PS.T2IDX(T, 'T', MODE)
%   IDX = PS.T2IDX(T, 'F', MODE)
%
%   Given a simulation time step T, this method returns the index IDX of
%   the process update instance that triggers ('T') or finalizes ('F') at
%   time T, depending on the value of the second input argument. The third
%   argument determines the handling of the case when the process does not
%   trigger/finalize at time T. By default, it returns IDX = 0 in that case.
%
%   Input:
%       PS - process object
%       T  - index of simulation time step
%       MODE - determines handling of case when process does not
%           trigger/finalize at period T
%               0 - (default) set IDX = 0
%               1 - IDX corresponds to most recent period preceding T in
%                   which process triggered/finalized
%               2 - IDX is non-integer
%
%   Output:
%       IDX - index of process update instance

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

switch TorF
    case 'T'
        idx = (t - ps.t0_period)/ps.f_period + 1;
    case 'F'
        idx = (t - ps.t0_period - ps.tau_period)/ps.f_period + 1;
    otherwise
        error('@mpsim_process/idx2t: second input argument must be ''T'' or ''F''');
end

%% handle case when process does not trigger/finalize at t
if rem(idx, 1) ~= 0
    if nargin < 4
        mode = 0;
    end
    if mode == 0        %% set IDX = 0
        idx = 0;
    elseif mode == 1    %% set IDX for most recent trigger/finalize
        idx = fix(idx);
    end
end
