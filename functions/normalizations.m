function x = normalizations(x,option,varargin)
%NORMALIZATIONS, various normalizations for vectors / matrices

% List of available normalizations:
% - Center data around mean
% - Sum to 1
% - Euclidean or general vector norm, see MATLAB doc https://bit.ly/2AkEfX4
% - z-score, see https://bit.ly/2l5QFXV
% - Scale

%INPUT:
% x: vector or matrix: Each element of the vector or each column will be normalized.
% option: 
%  - 'mean':    center data around mean.
%  - 'one':     sum to 1.
%  - 'n-norm':  general vector norm, default: Euclidean see MATLAB doc
%               https://bit.ly/2AkEfX4 for more info
%  - 'z-score': standarization, see https://bit.ly/2l5QFXV for more info
%  - 'scale':   scalling between an interval, default [0,1]

%EXTRA INPUT (varargin): 
% (1) For 'n-norm' option it specifies the power n.
%     If omitted then n = 2 (Euclidean). 
%     E.g. normalizations(x,'n-norm',5)
% (2) For 'scale' option it specifies the upper and lower bounds.
%     If omitted then [0 1] (min-max).
%     E.g. normalizations(x,'scale',[1,10])

%OUTPUT:
% x: the normalized input vector or matrix.

%NOTE:
%    (1) In case of matrix, the operation will be performed per column.  
%    (2) In case an input vector 1xN is provided then the input x will be
%        the sane as the output x.


% Author:
% Avgoustinos Vouros
% avouros1@sheffield.ac.uk

%%
    
    [n,m] = size(x);

    switch option
        case 'mean'
            % center data around mean (common in PCA)
            if n == 1 %vector
                x = x - mean(x);
            else
                x = x - repmat(mean(x,1),size(x,1),1);
            end
            
        case 'one'
            % sum to 1 (common in neural networks)
            if n == 1 %vector
                x = x ./ sum(x);
            else
                x = x ./ sum(x,2);
            end

        case 'n-norm'
            % sum(abs(x).^n)^(1/n) for 1 <= n < inf
            % if n = 2    => Euclidean
            % if n = inf  => max(abs(x))
            if isempty(varargin)
                a = 2;
            else
                a = varargin{1};
            end
            if n == 1 %vector
                x = x ./ vecnorm(x,a,2);
            else
                x = x ./ vecnorm(x,a,1);
            end
            
        case 'z-score' 
            % zero mean and unit variance
            if n == 1 %vector
                x = (x - mean(x)) ./ std(x);
            else
                x = (x - mean(x,1)) ./ std(x,0,1);
            end

        case 'scale' 
            % First do min-max ([0 1], default)
            if n == 1 %vector
                x = (x - min(x)) ./ (max(x) - min(x));
            else
                x = (x - min(x,[],1)) ./ (max(x,[],1) - min(x,[],1));
            end
            % Then scale
            if ~isempty(varargin)
                if length(varargin{1}) == 2
                    a = sort(varargin{1},'ascend');
                    range = a(2) - a(1);
                    x = (x.*range) + a(1);
                end
            end
    end
end

