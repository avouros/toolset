function [CI,SEM,SEM2,m] = bio_errorbars(data,confidence,confidence2)
%BIO_ERRORBARS computes various common error bars.
% This code is a simplified version of
% notBoxPlot by Rob Campbell (https://bit.ly/2ztobls)
% for calculating the errorbars and no plotting support is provided.

% Reference:
% Cumming, Geoff, Fiona Fidler, and David L. Vaux. 
% "Error bars in experimental biology." The Journal 
% of cell biology 177.1 (2007): 7-11.

% INPUT:
% - data: vector
% - confidence: (optional) confidence level 1-100 for CI
% - confidence2: (optional) confidence level 1-100 for SEM2

% OUTPUT:
% - CI: confidence intervals
% - SEM: standard error
% - SEM2: alpha SEM, where alpha = 95% confidence interval (default)
% - m: mean of data

% NOTE:
% These statistics can be plotted above and below the mean using the
% command:
% - errorbar(x,y,neg,pos): x = location, y = m, 
%                          neg and pos (both) = CI or SEM or SEM2

    if nargin < 2
        confidence = 95;
        confidence2 = 95;
    elseif nargin < 3
        confidence2 = 95;
    end

    % Remove any NaN values
    x = data;
    x(isnan(x)) = [];
    % Number of data
    s = length(x);

    % Check input
    if s < 2 || confidence <= 0 || confidence2 <= 0
        CI = [0,0];
        SEM = 0;
        SEM2 = 0;
    end
    
    % Confidence level
    alpha = 1 - (confidence / 100);
    
    % Mean
    m = mean(x);
    
    % Standard error
    SEM = std(x) / sqrt(s);
    
    % T-Score
    ts = tinv( [ alpha/2 , 1-(alpha/2) ], s-1);
    
    % Confidence Intervals
    CI = ts(2)*SEM;
    
    % SEM2
    alpha = 1 - (confidence2 / 100);
    SEM2 = SEM * abs(norminv(alpha/2));
end

