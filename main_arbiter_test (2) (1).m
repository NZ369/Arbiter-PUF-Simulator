clear all
close all
clc

%% Arbiter system parameters
B = 2^10; % Number of response bits 
S = 2^3; % Number of 2X2 switching stages in arbiter row

% PUF stochastic parameters
mu_f = 0; % Mean of RFV
sigma_f = 0.3; % Standard deviation of delay due to RFV
mu_n = 0; % Mean of CMOS noise
sigma_n = sigma_f/30; % Standard deviation due to CMOS noise

%% Define tau_f values for all rows and stages

% Delay difference B X S matrix of a valid device due to RFV
T_f_valid = f_define_T_f(mu_f,sigma_f,B,S); 

% Delay difference B X S matrix of a fake device due to RFV
T_f_fake  = f_define_T_f(mu_f,sigma_f,B,S);

%% Generate tau_p + tau_n for all rows and stages

% Delay difference B X S matrix at fab house due to RFV & CMOS noise
T_fab   = f_define_T(T_f_valid,mu_n,sigma_n); 

% Delay difference B X S matrix at valid device due to RFV & CMOS noise
T_valid = f_define_T(T_f_valid,mu_n,sigma_n); 

% Delay difference B X S matrix of fake device due to RFV & CMOS noise
T_fake  = f_define_T(T_f_fake,mu_n,sigma_n);

%% Generate output delay difference for fab, valid and fake devices

% Total switching stages delay difference of device at fab house
Delay_fab = sum(T_fab,2);

% Total switching stages delay difference of valid device
Delay_valid = sum(T_valid,2);

% Total switching stages delay difference of fake device
Delay_fake  = sum(T_fake,2);  

%% Generate responses for fab, valid and fake devices

r_fab = f_response(Delay_fab); % B-bit response at fab

r_valid = f_response(Delay_valid); % B-bit valid device response

r_fake = f_response(Delay_fake); % B-bit fake device response

%% Hamming distance calculations between fab/valid and fab/fake

normalizedHD_fab_valid   = f_HD(r_fab,r_valid)
normalizedHD_fab_fake    = f_HD(r_fab,r_fake)

% The intra-Hamming distance should be, on average, 50% of the output bits​, which is also what the ideal inter-Hamming distance should be
%% Intrahamming distance
%Intra_distance_fab = pdist(r_fab, "hamming")/B
%Intra_distance_valid = pdist(r_valid, "hamming")/B
%Intra_distance_fake = pdist(r_fake, "hamming")/B

% This function calculates the normalized Hamming distance
function res = f_HD(r_fab,r_valid)
% This function utilizes the matlab function pdist2 for this calculation
    res = pdist2(r_fab,r_valid,'hamming');
end

function res = f_define_T_f(mu_f,sigma_f,B,S)
% This section creates a normalized matrix of B x S given parameters mu_f
% and sigma_f
    res = normrnd(mu_f,sigma_f,[B,S]);
end

% This function generates the delay difference at all switching stages in arbiter system due to RFV and CMOS noise
function res = f_define_T(T_f_valid,mu_n,sigma_n)
% This section creates a normalized matrix of B x S given parameters mu_n
% and sigma_n and adds this to the previously created Tf matrix
    res = T_f_valid + normrnd(mu_n,sigma_n);
end

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