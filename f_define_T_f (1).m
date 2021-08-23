% This function generates the delay difference at all switching stages in arbiter system due to RFV
function res = f_define_T_f(mu_f,sigma_f,B,S)
% This section creates a normalized matrix of B x S given parameters mu_f
% and sigma_f
    res = normrnd(mu_f,sigma_f,[B,S]);
end