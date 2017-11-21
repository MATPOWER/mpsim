function success = test_mpsim(verbose, exit_on_fail)
%TEST_MPSIM  Run all MPSIM tests.
%   TEST_MPSIM
%   TEST_MPSIM(VERBOSE)
%   TEST_MPSIM(VERBOSE, EXIT_ON_FAIL)
%   SUCCESS = TEST_MPSIM(...)
%
%   Runs all of the MPSIM tests. If VERBOSE is true (false by default),
%   it prints the details of the individual tests. If EXIT_ON_FAIL is true
%   (false by default), it will exit MATLAB or Octave with a status of 1
%   unless T_RUN_TESTS returns ALL_OK.
%
%   See also T_RUN_TESTS.

%   MP-Sim
%   Copyright (c) 2016 by Haeyong Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).
%   See https://github.com/MATPOWER/mpsim for more info.

if nargin < 2
    exit_on_fail = 0;
    if nargin < 1
        verbose = 0;
    end
end

tests = {};

%% MP-Sim tests
tests{end+1} = 't_mpsim_shared_x_numeric';
tests{end+1} = 't_mpsim_shared_x_queue';
tests{end+1} = 't_mpsim_process';
tests{end+1} = 't_mpsim';
tests{end+1} = 't_burger_shop';
tests{end+1} = 't_burger_shop_2d';
tests{end+1} = 't_opf_sim';

%% run the tests
all_ok = t_run_tests( tests, verbose );

%% handle success/failure
if exit_on_fail && ~all_ok
    exit(1);
end
if nargout
    success = all_ok;
end
