function pathname = outputdir(sim, varargin)
%OUTPUTDIR  Returns the path to a simulation-specific output file or directory.
%
%   PATHNAME = SIM.OUTPUTDIR(FOLDERNAME1, FOLDERNAME2, ..., FILENAME)
%
%   pn = sim.outputdir();                %% <OUTPUTDIR>/<SIMNAME>/outputs
%   pn = sim.outputdir('a','b');         %% <OUTPUTDIR>/<SIMNAME>/outputs/a/b
%   pn = sim.outputdir('a','b','c.txt'); %% <OUTPUTDIR>/<SIMNAME>/outputs/a/b/c.txt
%
%   Constructs the full path name to an output directory or file specific
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

pathname = fullfile(sim.config.outputdir, sim.name, 'outputs', varargin{:});
