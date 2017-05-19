function pathname = workdir(sim, varargin)
%WORKDIR  Returns the path to a simulation-specific work file or directory.
%
%   PATHNAME = SIM.WORKDIR(FOLDERNAME1, FOLDERNAME2, ..., FILENAME)
%
%   pn = sim.workdir();                %% <WORKDIR>/<SIMNAME>/work
%   pn = sim.workdir('a','b');         %% <WORKDIR>/<SIMNAME>/work/a/b
%   pn = sim.workdir('a','b','c.txt'); %% <WORKDIR>/<SIMNAME>/work/a/b/c.txt
%
%   Constructs the full path name to a work directory or file specific
%   to the current simulation. Requires that sim.name, which is set
%   by run(), contain a valid simulation name.
%
%   Inputs:
%       SIM - simulator object
%       Additional string arguments are joined and appended to form the path
%
%   Output:
%       PATHNAME - string containing the full path to the file or directory

%   MP-Sim
%   Copyright (c) 2017 by Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

pathname = fullfile(sim.config.workdir, sim.name, 'work', varargin{:});
