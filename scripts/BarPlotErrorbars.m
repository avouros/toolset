% Author: Avgoustinos Vouros 
% Last updated 13/09/2018
% Thanks to Marialena for the idea + initial tests!

% TODO: Description, more testing, find a more fancy name
%       Also a gui for all the configurations!


data = rand(5,7); % Each row is 1 bar group!!
SEM = rand(5,7);

%% User properties

% Figure's aesthetics -----------------------------------------------------
figure_size = 'normal'; % Normali figure window
%figure_size = 'maximize'; % Maximized figure window

% Bars --------------------------------------------------------------------
inGroupGap = 1;    % Gap between each box of the same group
outGroupGap = 2;   % Gap between boxes of different groups
BarLineStyle = '-';
BarLineWidth = 1;

%pick one:
BarEdgeColor = 'same'; % The color of the outline with be the same as the bar's
%BarEdgeColor = 'red'; % The color of the outline with be the defined color

%pick one:
%BarColorGroupBy = 'blue';     % All same color
BarColorGroupBy = 'group';     % Each bar group has different color
%BarColorGroupBy = 'pergroup'; % Each group starts with the same color

% Errorbars ---------------------------------------------------------------
MarkerSize = 10;
MarkerEdgeColor = 'black';
MarkerFaceColor = 'black';
LineStyle = '-';
LineMarker = '.';
LineColor = 'k';
LineWidth = 1;

% Colors ------------------------------------------------------------------
red = [230, 25, 75];
green = [60, 180, 75];
yellow = [255,225,25];
blue = [0, 130, 200];
orange = [245, 130, 48];
purple = [145, 30, 180];
cyan = [70, 240, 240];
magenta = [240, 50, 230];
lime = [210, 245, 60];
pink = [250, 190, 190];
teal = [0, 128, 128];
brown = [170, 110, 40];
maroon = [128, 0, 0];
mint = [170, 255, 195];
olive = [128, 128, 0];
navy = [0, 0, 128];
gray = [128,128,128];
coral = [255,215,180];
pink1 = [242,121,137];
grey1 = [85,67,89];
purple1 = [77,0,51];
%more colors can be defined here...
color = [red;green;yellow;blue;orange;purple;cyan;magenta;lime;...
    pink;teal;brown;maroon;mint;olive;navy;gray;coral;pink1;grey1;...
    purple1]./255;


%% Initialialize and calculate bar pasitions

% Data size
[n,m] = size(data);
nm = n*m;

% Convert data to vector
sdata = reshape(data',1,35);
sSEM = reshape(SEM',1,35);

% Calculate the bar positions
pos = 0;
sw = 0;
for j = 1:n
    for i = 1:m
        if sw == 0
            % Same group
            pos = [pos,pos(end)+inGroupGap];
        else
            % Other group
            pos = [pos,pos(end)+outGroupGap];
            sw = 0;
        end
    end
    sw = 1;
end
pos(1) = [];

% Find also the middles
mpos = reshape(pos,m,n);
mpos = mean(mpos);


%% Generate Graphics %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Figure size
switch figure_size
    case 'normal'
        f = figure;
    case 'maximize'
        f = figure('units','normalized','outerposition',[0 0 1 1]);
end
hold on

% Plot the bars + errorbars
bars = [];
errorbars = [];
LineSpec = strcat(LineStyle,LineMarker,LineColor);
for i = 1:nm 
    % Bar
    B = bar(pos(i),sdata(i),...
        'LineWidth',BarLineWidth,'LineStyle',BarLineStyle);
    bars = [bars;B];
    % Errorbar
    E = errorbar(pos(i),sdata(i),sSEM(i),LineSpec);
    errorbars = [errorbars,E];
    set(E,'MarkerSize',MarkerSize,'MarkerEdgeColor',MarkerEdgeColor,...
        'MarkerFaceColor',MarkerFaceColor,'LineWidth',LineWidth);
end

% Paint the bars
c = 1; %color index
switch BarColorGroupBy
    
    case 'group'
        sbars = reshape(bars,m,n);
        for i = 1:n
            for j = 1:m
                switch BarEdgeColor
                    case 'same'
                        set(sbars(j,i),'EdgeColor',color(c,:),'FaceColor',color(c,:));
                    otherwise
                        set(sbars(j,i),'EdgeColor',BarEdgeColor,'FaceColor',color(c,:));
                end
            end
            if c < size(color,1)
                c = c + 1; %next color
            else
                c = 1;
            end
        end
        
    case 'pergroup'
        sbars = reshape(bars,m,n);
        for i = 1:n
            for j = 1:m
                switch BarEdgeColor
                    case 'same'
                        set(sbars(j,i),'EdgeColor',color(c,:),'FaceColor',color(c,:));
                    otherwise
                        set(sbars(j,i),'EdgeColor',BarEdgeColor,'FaceColor',color(c,:));
                end
                if c < size(colors,1)
                    c = c + 1; %next color
                else
                    c = 1;
                end
            end
            c = 1;
        end        
        
    otherwise
        for i = 1:nm
            switch BarEdgeColor
                case 'same'
                    set(bars(i),'EdgeColor',BarColorGroupBy,'FaceColor',BarColorGroupBy);
                otherwise
                    set(bars(j,i),'EdgeColor',BarColorGroupBy,'FaceColor',BarColorGroupBy);
            end
            if c < size(colors,1)
                c = c + 1; %next color
            else
                c = 1;
            end
        end        
end 

% Fix the axis
faxis = findobj(f,'type','axes'); 
set(faxis,'XTick',mpos);
set(faxis,'XTickLabels',num2str([1:length(mpos)]'));