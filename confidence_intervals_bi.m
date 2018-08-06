function [phat, pci, m] = confidence_intervals_bi(score,sample,confidence)
%CONFIDENCE_INTERVALS_BI computes the binomial confidence intervals.

% INPUT:
% - score: successes
% - sample: trials
% - confidence: confidence level 1-100

% OUTPUT:
% - phat: success percentage
% - pci: confidence intervals
% - m: mean of the confidence intervals (for plotting purposes)

    % Confidence level
    alpha = 1 - (confidence / 100);
    
    % Binomial confidence intervals
    [phat, pci] = binofit(score,sample,alpha);
    
    % Mean
    m = sum(pci)/2;
end

