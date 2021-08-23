% This function generates the delay difference at all switching stages in arbiter system due to RFV and CMOS noise
function res = f_define_T(T_f,mu_n,sigma_n)
% This section creates a normalized matrix of B x S given parameters mu_n
% and sigma_n and adds this to the previously created Tf matrix
    res = T_f + normrnd(mu_n,sigma_n);
end