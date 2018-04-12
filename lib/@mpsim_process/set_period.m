function ps = set_period(ps, l)
%SET_PERIOD  Check timing parameters and convert units to time steps
%
%   PS = PS.SET_PERIOD(L)
%
%   Ensure that the timing parameters for the processes are all divisible
%   by the time step length, i.e. trigger and finalize always occur at a
%   discrete simulation time step. Convert each from original units to
%   simulation time steps.
%  
%   Input:
%       PS - process object
%       L - Length of simulation time step
%
%   Output:
%       PS - process object, with more time details added to its properties

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

f = ps.f;
tau = ps.tau;
t0 = ps.t0;

if f < tau
    error('@mpsim_process/set_period: Cannot re-run process before updating is done');
end
if t0 <= 0
    error('@mpsim_process/set_period: Starting time period must be positive');
end
if mod(f,l) ~=0 || mod(t0,l) ~= 0 || mod(tau,l) ~= 0
    error('@mpsim_process/set_period: Process parameters are not evenly divisible');
else
    ps.f_period = f/l;
    ps.tau_period = tau/l;
    ps.t0_period = t0/l;
end
