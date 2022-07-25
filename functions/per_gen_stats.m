step = floor(length(map)/length(trifgen));

for i = 1:length(trifgen)
    vol{i} = [];
    for j = 1:length(trifgen{i})
        rs = rad(trifseg{trifgen{i}(j)});
        as = arclength(vasc(trifseg{trifgen{i}(j)}, :));
        vol{i}(j) = sum(seg_vol(rs, as));
    end
%     mean_vol(i) = sum(vol{i})/length(vol{i});
    no_per_gen(i) = length(trifgen{i});
    cumulative_vol(i) = sum(vol{i});
end


h = figure;
subplot(1, 3, 1);
plot(no_per_gen); xlabel('Generation Number', ...
    'Interpreter', 'latex', 'fontsize', 15);
ylabel('Number of Vessels', ...
    'Interpreter', 'latex', 'fontsize', 15);
title({'Segment Count', 'Per Generation'}, ...
    'Interpreter', 'latex', 'fontsize', 15);
xlim([1 31])



subplot(1, 3, 2);plot(cumulative_vol); 
xlabel('Generation Number', ...
    'Interpreter', 'latex', 'fontsize', 15);
title({'Total Segment Volume', 'Per Generation'}, 'Interpreter', 'latex', 'fontsize', 15);
ylabel('Volume, mm$^3$', 'Interpreter', 'latex', 'fontsize', 15);
xlim([1 31])
subplot(1, 3, 3);plot(cumulative_vol./no_per_gen); 
xlabel('Generation Number', 'Interpreter', 'latex', 'fontsize', 15);
title({'Mean Segment Volume', 'Per Generation'}, 'Interpreter', 'latex', 'fontsize', 15);ylabel('Volume, mm$^3$', 'Interpreter', 'latex', 'fontsize', 15);
ylabel('Volume, mm$^3$', 'Interpreter', 'latex', 'fontsize', 15);

xlim([1 31])
h.Position =[2350 494 878 247];