%% fourier series
% write_series()
modes = 3;
out1= spacederiv(modes, ['C'; 'A'], 't');
out2 = spacederiv(modes, ['Q'; 'C'], 'x');
out3 = spacederiv(modes, ['A'; 'C'], 'xx');
fid= fopen('out.txt', 'w+');
for i = 0:modes
    o = ['\\begin{dmath}\n i\\omega\\left(' ...
        out1{i+1} '\\right) + \\pardif{}{x} \\left('...
        out2{i+1} ' \\right)= \\frac{1}{\\Pe}\\pardiff{}{x}\\left(' ...
        out3{i+1} '\\right) \n\\end{dmath}\n']
fprintf(fid,o);
end
fclose(fid)
open out.txt


function out = spacederiv(max_terms, args,deriv)
    for m = 0:max_terms
        str = '';
        for i = 0:m
            j = m-i;
            coeffs = [i, j, i+j];
           
            if deriv == 't'
                if i == 0
                    str = [str sprintf('%i', coeffs(1))];
                elseif i == 1
                    str = [str ...
                        sprintf('%s_%i %s_%i ', ...
                        args(1), coeffs(1), args(2), coeffs(2))];
                else
                    str = [str ...
                        sprintf('%i %s_%i %s_%i ', ...
                        coeffs(1), args(1), coeffs(1), args(2), coeffs(2))];
                end
            else
                str = [str ...
                    sprintf('%s_%i %s_%i ', ...
                    args(1), coeffs(1), args(2), coeffs(2))];
            end
                      
            
            if i < m; str = [str ' + ']; end 
        end
        out{m+1} = str;
    end
end

%% functions
function write_series()
fid = fopen('exp.txt','w');
series('A', 3, fid)
series('C', 3, fid)
series('Q', 3, fid)
fclose(fid);
open exp.txt
end

function series(arg, terms, file_id)
for i = 0:terms
    if i == 0; fprintf(file_id,'\\left('); end
    fprintf(file_id,'%s_{%i} e^{%ii\\omega t}+', arg, i, i);
%     if i == terms; fprintf(file_id,'\\right)\n');end
    if i == terms; fprintf(file_id,'...\\right)\\\\\n');end

end
end