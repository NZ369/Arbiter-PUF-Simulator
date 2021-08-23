% This function calculates the normalized Hamming distance
function res = f_HD(r_1,r_2)
% This function utilizes the matlab function pdist2 for this calculation
    res = pdist2(r_1,r_2,'hamming');
end