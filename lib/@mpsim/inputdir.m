function pathname = inputdir(sim, varargin)
%INPUTDIR  Returns the path to a simulation-specific input file or directory.
%
%   PATHNAME = SIM.INPUTDIR(FOLDERNAME1, FOLDERNAME2, ..., FILENAME)
%
%   pn = sim.inputdir();                %% <INPUTDIR>/<SIMNAME>/inputs
%   pn = sim.inputdir('a','b');         %% <INPUTDIR>/<SIMNAME>/inputs/a/b
%   pn = sim.inputdir('a','b','c.txt'); %% <INPUTDIR>/<SIMNAME>/inputs/a/b/c.txt
%
%   Constructs the full path name to an input directory or file specific
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

pathname = fullfile(sim.config.inputdir, sim.name, 'inputs', varargin{:});
