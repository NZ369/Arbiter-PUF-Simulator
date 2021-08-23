% This function produces the response such that r = 1 or 0 based on the output delay 
% difference from the last switching stage being positive or negative, respectively
function res = f_response(Delay_list)
    % Creates the empty results array
    res = [];
    % Goes through the entire Delay_list
    for i = 1:length(Delay_list) % indices
        % If delay is <= 0 then assign 0
        if Delay_list(i) <= 0
            res(i) = 0;
        % If delay is > 0 then assign 1
        elseif Delay_list(i) > 0
            res(i) = 1;
        end
    end
end