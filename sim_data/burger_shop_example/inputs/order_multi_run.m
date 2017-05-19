function inputs = order_multi_run(r2, stage, idx)

if strcmp(stage, 'base_run') == 1
    if r2 == 1
        orders = {  [700, 700, 550],
                    [700, 650, 500],
                    [650, 650, 550] };
    else
        orders = {  [700, 700, 550],
                    [700, 600, 500],
                    [600, 650, 550] };
    end
else
    if r2 == 1
        orders = {  [700, 700, 550],
                    [1000, 750, 600],
                    [750, 750, 550] };
    else
        orders = {  [700, 700, 550],
                    [1000, 750, 600],
                    [800, 700, 550] };
    end
end

inputs = orders{idx};
