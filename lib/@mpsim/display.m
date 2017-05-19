function display(sim)
%DISPLAY  Display information about simulation properties and processes.
%
%   SIM.DISPLAY()
%
%   Input:
%       SIM - simulator object
%
%   Output:
%       NONE

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

disp('Simulation Parameters:');
disp(sim);

for k = 1:length(sim.processes)
    disp(sprintf('Process %d', k));
    display(sim.processes{k});
end
