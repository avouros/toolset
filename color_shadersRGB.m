function colors = color_shadersRGB(RGB,n,option)
%COLOR_SHADERSRGB takes an RGB triplet and produces n dark/light shades of it
    
    % Default
    if nargin < 3
        option = 'darker';
    end
    
    % Check input
    [nn,m] = size(RGB);
    if nn~=1 || m~=3
        error('Input needs to be a 1x3 vector specifying an RGB color.');
    end
    
    switch option
        case 'darker'
            colors = rgb2hsv(RGB);
            values = linspace(0.5,1,n);
            colors = [colors(1,1).*ones(n,1),colors(1,2).*ones(n,1),values'];
            colors = hsv2rgb(colors);
            colors = flipud(colors);
        case 'lighter'
            colors = rgb2hsv(RGB);
            values = linspace(0.5,1,n);
            colors = [colors(1,1).*ones(n,1),values',colors(1,2).*ones(n,1)];
            colors = hsv2rgb(colors);
            colors = flipud(colors);   
        otherwise
            error('Wrong option.');
    end
end

