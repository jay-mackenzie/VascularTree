function [ins, outs] = find_disconnects(SEG)


    ins = []; outs = [];
    
    for i = 1:length(SEG)
        ins = [ins SEG{i}(1)];
        outs = [outs SEG{i}(end)];
    end
    
end