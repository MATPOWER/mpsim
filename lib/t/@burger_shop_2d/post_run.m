function post_run(sim, y, sim_outputdir)
%POST_RUN @burger_shop_2d/post_run

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

print = 1;
if isfield(sim.options, 'post_run_print')
    print = sim.options.post_run_print;
end

outputdir = sim.outputdir();
[status, msg, msgID] = mkdir(outputdir);

processes = sim.processes;
matrix_data = [];
hours_in_day = processes{2}.f/processes{4}.f;

runs_vector = [{1,1};{1,2};{2,1};{2,2}];

starting_point = 1;
for k = 1:length(runs_vector)
    r = runs_vector(k,:);
    total_order = 0;
    total_deliver = 0;
    total_defrost = 0;
    total_grill = [0,0];
    for k2 = starting_point:sim.T
        day = fix(k2/hours_in_day) + 1;
        hour = mod(k2, hours_in_day);
        if hour == 0
            day = day - 1;
            hour = hours_in_day;
        end
        % mapping from index to time period for each process for trigger
        % and finalize
        value_order = 0;
        value_deliver = 0;
        value_defrost = 0;
        value_grill = struct( ...
            'grills', 0, ...
            'sold', 0, ...
            'frozen_inventory', 0, ...
            'thawed_inventory', 0, ...
            'grilled_inventory', 0 ...
        );
        value_grill2 = value_grill;
        idx_order = processes{1}.t2idx(k2, 'F');
        idx_deliver = processes{2}.t2idx(k2, 'F');
        idx_defrost = processes{3}.t2idx(k2, 'F');
        idx_grill = processes{4}.t2idx(k2, 'F');
        
        if idx_order > 0
            value_order = y.order(r{:}, idx_order);
            total_order = total_order + value_order;
        end
        if idx_deliver > 0
            value_deliver = y.deliver(r{:}, idx_deliver);
            total_deliver = total_deliver + value_deliver;
        end
        if idx_defrost > 0
            value_defrost = y.defrost(r{:}, idx_defrost);
            total_defrost = total_defrost + value_defrost;
        end
        if idx_grill > 0
            value_grill = y.grill(r{:}, idx_grill);
            if k2 < sim.T
               value_grill2 = y.grill(r{:}, idx_grill+1);
            else
                value_grill2.frozen_inventory = value_grill.frozen_inventory - value_defrost;
                value_grill2.thawed_inventory = value_grill.thawed_inventory + value_defrost - value_grill.grills;
                value_grill2.grilled_inventory = value_grill.grilled_inventory + value_grill.grills - value_grill.sold;
            end 
            total_grill = total_grill + [value_grill.grills value_grill.sold];
        end
   
        if print == 1
            if k2 == starting_point
                fprintf('Results for run ');
                for mini_i = 1:length(r)
                    fprintf('%d ', r{mini_i});
                end
                fprintf(':\n');
                fprintf('                                                                 ');
                fprintf('                     inventories\n');
                fprintf('period   day   hr   ordered    delivered   defrosted   grilled   sold');
                fprintf('             frozen   thawed   grilled\n');
                fprintf('------   ---   --   -------    ---------   ---------   -------   ----');
                fprintf('             ------   ------   -------\n');
                
                fprintf('                                                     ');
                fprintf('                              %4d     %4d    %4d \n', ...
                    value_grill.frozen_inventory, value_grill.thawed_inventory, value_grill.grilled_inventory);
            end
            fprintf('  %3d    %3d   %3d   %4d       %4d', ...
                (k2-starting_point+1),day,hour,value_order,value_deliver);
            fprintf('         %3d        %4d      %3d              %4d', ...
                value_defrost,value_grill.grills, value_grill.sold,value_grill2.frozen_inventory);
            fprintf('     %4d    %4d\n', ...
                value_grill2.thawed_inventory,value_grill2.grilled_inventory);
            
            if hour == hours_in_day
                fprintf('\n');
            end
            
            if k2 == sim.T
                fprintf('\ntotal:               %3d       %3d         %3d', ...
                        total_order, total_deliver, total_defrost);
                fprintf('        %3d       %3d\n', ...
                    total_grill(1), total_grill(2));
                fprintf('End of run \n\n');
            end
        end
        
        matrix_data = [matrix_data; ...
            value_order, value_deliver, value_defrost, ...
            value_grill.grills, value_grill.sold, value_grill.frozen_inventory, ...
            value_grill.thawed_inventory, value_grill.grilled_inventory ];
    end
end

matrix_data = [ matrix_data;
    sim.R, sim.T, sim.x.order, sim.x.deliver, sim.x.defrost, ...
        sim.x.grill.grilled sim.x.grill.sold ];
output_filepath = fullfile(outputdir, 'final_data_burger_multi_run.mat');
save(output_filepath, 'matrix_data');
