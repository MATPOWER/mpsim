function sim = apply_run_options(sim, varargin)
%APPLY_RUN_OPTIONS  Copy set of run options to simulator object
%
%   SIM = SIM.APPLY_RUN_OPTIONS(OPT_STRUCT)
%   SIM = SIM.APPLY_RUN_OPTIONS(OPT1_NAME, OPT1_VAL, ...)
%   SIM = SIM.APPLY_RUN_OPTIONS(OPT1_NAME, OPT1_VAL, ... OPT_STRUCT)
%
%   Takes options passed to RUN, as name/value pairs and/or a struct
%   and copies them into the appropriate properties in the SIM object.
%   All but the following are copied to the 'options' field:
%       R, T, verbose, inspect, and post_run_on
%   These are copied to the corresponding property of SIM.
%
%   See RUN for details of the available options.
%
%   Inputs:
%       SIM - simulator object
%       OPT1_NAME  - name of an MP-Sim option
%       OPT1_VAL   - value for MP-Sim option named in OPT1_NAME
%       OPT_STRUCT - struct containing MP-Sim options
%
%   Output:
%       SIM - simulator object
%
%   See also @MPSIM/RUN.

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

standard_options = { 'R', 'T', 'verbose', 'inspect', 'post_run_on'};

%% assemble options into struct
if mod(length(varargin), 2) %% odd number of opt args
    opt = varargin{end};        %% OPT_STRUCT
else                        %% even number of opt args
    opt = struct();
end
k = 2;
while k <= length(varargin)     %% copy name/value pairs
    if ~ischar(varargin{k-1})
        error('@mpsim/apply_run_options: options must be name, value pairs (optional) followed by a struct (optional)');
    end
    opt.(varargin{k-1}) = varargin{k};
    k = k + 2;
end

%% copy standard options to sim object, then remove from options struct
for k = 1:length(standard_options)
    opt_name = standard_options{k};
    if isfield(opt, opt_name)
        sim.(opt_name) = opt.(opt_name);
        opt = rmfield(opt, opt_name);
    end
end

%% put remaining options in sim.options
sim.options = nested_struct_copy_mpsim(sim.options, opt);
