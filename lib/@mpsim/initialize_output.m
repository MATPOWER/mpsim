function sim = initialize_output(sim)
%INITIALIZE_OUTPUT  Initialize output cache in sim.y.
%
%   SIM = SIM.INITIALIZE_OUTPUT()
%
%   Initializes the output cache in
%       sim.y.(ps.name)
%
%   Input:
%       SIM - simulator object
%
%   Output:
%       SIM - simulator object

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

sim.y = struct();

r = num2cell(sim.R);
for k = 1:length(sim.processes)
  ps = sim.processes{k};
  y_ps = ps.output();
  if ~isempty(y_ps)
    nidx = ps.t2idx(sim.T, 'F', 1);
    if nidx
        sim.y.(ps.name)(r{:}, nidx) = y_ps;
    end
  end
end
