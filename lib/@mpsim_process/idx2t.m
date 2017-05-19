function t = idx2t(ps, idx, TorF)
%IDX2T  Returns simulation time step at which trigger/finalize occurs
%
%   T = PS.IDX2T(IDX, 'T')
%   T = PS.IDX2T(IDX, 'F')
%
%   Given the index IDX of a process update instance, this method returns
%   the simulation time step T in which the process triggers ('T') or
%   finalizes ('F'), depending on the value of the second input argument.
%
%   Input:
%       PS - process object
%       IDX - index of process update instance
%
%   Output:
%       T  - index of simulation time step

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

switch TorF
    case 'T'
        t = (idx-1) * ps.f_period + ps.t0_period;
    case 'F'
        t = (idx-1) * ps.f_period + ps.t0_period + ps.tau_period;
    otherwise
        error('@mpsim_process/idx2t: second input argument must be ''T'' or ''F''');
end
