
SEG = trifseg;
GEN = trifgen;

sum(tot_a_l(trifseg, trifgen, vasc))
hold on
sum(tot_a_l(bifseg, bifgen, vasc))


function length_gen = tot_a_l(SEG, GEN, vasc)
total_arc_length = 0;
for i = 1:length(GEN)
    length_gen(i) = 0;
    for j = 1:length(GEN{i})
        length_gen(i) = length_gen(i) + sum(arclength(vasc(SEG{GEN{i}(j)}, :)));
    end
end
end