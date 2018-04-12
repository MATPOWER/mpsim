function config = mpsim_config()
%MPSIM_CONFIG MP-Sim config specifying locations for input, output, temp files
%
% CONFIG = MPSIM_CONFIG()
%
% User editable file that defines three paths used by MP-Sim to access
% input, output and temporary working files, respectively. These paths
% are provided as strings in the variables inputdir, outputdir and
% workdir below.
%
% If the values assigned to the paths are <INPUTDIR>, <OUPUTDIR> and
% <WORKDIR>, respectively, then for a simulation named <SIMNAME>, by
% convention MP-Sim will expect to find the input files in
% <INPUTDIR>/<SIMNAME>/inputs. Similarly, any output files can be written
% to <OUTPUTDIR>/<SIMNAME>/outputs, and temporary working files to
% <WORKDIR>/<SIMNAME>/work.
%
% By default, inputdir is set to <MPSIM>/sim_data, where <MPSIM> is the
% MP-Sim installation path. Both outputdir and workdir default to the same
% path as inputdir.
%
% Input:
%   NONE
%
% Output:
%   CONFIG - Struct with fields inputdir, outputdir and workdir


%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

%--------------------------------------------------------------------------
%% TO BE EDITED BY USER
%--------------------------------------------------------------------------
inputdir  = '';     % path to directory for inputs
                    % (default = '<MPSIM>/sim_data', where <MPSIM> is
                    %  the MP-Sim installation path)

outputdir = '';     % path to directory for outputs
                    % (default = same as inputdir)
workdir   = '';     % path to directory for temporary work files,
                    % (default = same as inputdir)
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
%% DO NOT MODIFY
%--------------------------------------------------------------------------
if isempty(inputdir)        %% set default inputdir
    [p,n,e] = fileparts(which('nested_struct_copy_mpsim'));
    if length(p) > 4
        inputdir = fullfile(p(1:end-4), 'sim_data');
        if ~exist(inputdir, 'dir')
            error('mpsim_config: MPSIM installation appears to be broken, cannot find default input directory <MPSIM>/sim_data.');
        end
    else
        error('mpsim_config: MPSIM installation appears to be broken.');
    end
end

if isempty(outputdir)       %% set default outputdir
    outputdir = inputdir;
end
if isempty(workdir)         %% set default workdir
    workdir = inputdir;
end
config = struct( ...
    'inputdir',     inputdir, ...
    'outputdir',    outputdir, ...
    'workdir',      workdir     );
%--------------------------------------------------------------------------