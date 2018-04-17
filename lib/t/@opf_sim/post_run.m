function post_run(sim, y, sim_outputdir)
%POST_RUN @opf_sim/post_run
%
% Takes y, which is the global output struct accumulating all
% outputs returned by process(es), and graph relevant plots for
% information.

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

define_constants;
runs = sim.R;

mpc = y.dispatch(1,1).results;
il = find(mpc.branch(:, RATE_A));   %% potentially congested lines
ng = size(mpc.gen, 1);              %% number of gens
Pg = zeros(ng, sim.T);
lam = zeros(3, sim.T);
mu = zeros(length(il), sim.T);

for r = 1:sim.R
    for t = 1:sim.T
        results = y.dispatch(r,t).results;
        if results.success
            Pg(:, t) = Pg(:, t) + results.gen(:, PG);
            lam(:, t) = lam(:, t) + ...
                [ max(results.bus(:, LAM_P));
                  mean(results.bus(:, LAM_P));
                  min(results.bus(:, LAM_P)) ];
            mu(:, t) = mu(:, t) + results.branch(il, MU_SF) + results.branch(il, MU_ST);
        end
    end
end
Pg = Pg / sim.R;
lam = lam / sim.R;
mu = mu / sim.R;

if exist('OCTAVE_VERSION', 'builtin') ~= 5  %% not running under Octave
    if exist(sim_outputdir, 'dir') ~= 7
        [success, msg, msgid] = mkdir(sim_outputdir);
    end
    fig1 = figure('Visible', 'off');
    plot(Pg')
    xlabel('hour');
    ylabel('Generation (MW)');
    title('Average Generation vs. Hour');
    labelmaker = @(x)sprintf('Gen %d', x);
    labels = cellfun(labelmaker, num2cell((1:ng)'), 'UniformOutput', 0);
    legend(labels{:});
    output_file1 = fullfile(sim_outputdir, 'generation');
    print(fig1, output_file1, '-dpdf');

    fig2 = figure('Visible', 'off');
    plot(lam');
    xlabel('hour');
    ylabel('Nodal Price in $/MW');
    title('Nodal Price vs. Hour');
    legend('Max', 'Avg', 'Min');
    output_file2 = fullfile(sim_outputdir, 'nodal_price');
    print(fig2, output_file2, '-dpdf');

    fig3 = figure('Visible', 'off');
    plot(mu');
    xlabel('hour');
    ylabel('Average Shadow Price in $/MVA');
    title('Line Congestion Shadow Price  vs. Hour');
    labelmaker = @(x)sprintf('Line %d', x);
    labels = cellfun(labelmaker, num2cell(il'), 'UniformOutput', 0);
    legend(labels{:});
    output_file3 = fullfile(sim_outputdir, 'congestion');
    print(fig3, output_file3, '-dpdf');
end
