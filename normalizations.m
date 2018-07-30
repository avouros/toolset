function x = normalizations(x,option,varargin)
%NORMALIZATIONS, various normalizations for vectors / matrices

% List of available normalizations:
% - Center data around mean
% - Sum to 1
% - Euclidean or general vector norm, see MATLAB doc https://bit.ly/2AkEfX4
% - z-score, see https://bit.ly/2l5QFXV
% - Scale

% Author: Avgoustinos Vouros
% Last update: 30/7/2018


%INPUT:
% x: vector / matrix.
% option: 'mean' , 'one' , 'n-norm' , 'z-score' , 'scale' 
% varargin: 
%           (1) For 'n-norm' option it specifies the power n.
%               If omitted then n = 2 (Euclidean). 
%               E.g. normalizations(x,'n-norm',5)
%           (2) For 'scale' option it specifies the upper and lower bounds.
%               If omitted then [0 1] (min-max).
%               E.g. normalizations(x,'scale',[1,10])

%OUTPUT:
% x: the normalized input vector / matrix.

%NOTE: in case of matrix, the operation will be performed per column. 

%%

    % If x = 1:N make it N:1
    [n,~] = size(x);
    if n == 1
        x = x';
    end

    switch option
        case 'mean'
            % center data around mean (common in PCA)
            x = x - repmat(mean(x),size(x,1),1);
            
        case 'one'
            % sum to 1 (common in neural networks)
            x = x ./ sum(x);

        case 'n-norm'
            % sum(abs(x).^n)^(1/n) for 1 <= n < inf
            % if n = 2    => Euclidean
            % if n = inf  => max(abs(x))
            if isempty(varargin)
                a = 2;
            else
                a = varargin{1};
            end
            x = x ./ vecnorm(x,a);
            
        case 'z-score' 
            % zero mean and unit variance
            x = (x - mean(x)) ./ std(x);

        case 'scale' 
            % First do min-max ([0 1], default)
            x = (x - min(x)) ./ (max(x) - min(x));
            % Then scale
            if ~isempty(varargin)
                if length(varargin{1}) == 2
                    a = sort(varargin{1},'ascend');
                    range = a(2) - a(1);
                    x = (x.*range) + a(1);
                end
            end
    end
    
    % Reset x if vector
    if n == 1
        x = x';
    end
end

