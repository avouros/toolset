% DESCRIPTION: Exports the current figure into different formats.
% ARGUMENTS:
%           -get_current_figure: figure for exporting, for current "active"
%                                figure use gcf.
%
%           -get_path: path in which the figure should be saved.
%
%           -get_name: name of the generated file (without extension).
%
%           -get_export_format: export format ('.format', no capitals)
%
%           -get_export_properties: low/high/super quality (for low quality 
%                                   use "saveas" and for the rest use
%                                   "print" with 300 or 600 dpi).

% List of accepted formats:
% - .pdf
% - .svg
% - .eps
% - .jpg
% - .png
% - .tif
% - .bmp

% List of accepted qualities:
% - Low Quality
% - High Quality
% - Super Quality

% Example:
%export_figure(gcf, 'C:\Documents', 'myFig1', '.jpg', 'High Quality');


% Author: Avgoustinos Vouros


function export_figure(get_current_figure, get_path, get_name, get_export_format, get_export_properties)
    
    % file name and extension
    file = strcat(get_name,get_export_format);
    fpath = fullfile(get_path,file);
    
    % if .fig format is requested just save and terminate
    if isequal(get_export_format,'.fig')
        saveas(get_current_figure, fpath);
        return;
    end   
    
    if isequal(get_export_properties,'Low Quality')
        if isequal(get_export_format,'.pdf')
            get_export_format = '.pdf';
        elseif isequal(get_export_format,'.svg')
            get_export_format = '.svg';
        elseif isequal(get_export_format,'.eps')
            %eps level 2 colored
            get_export_format = '.epsc2';
        elseif isequal(get_export_format,'.jpg')    
            get_export_format = '.jpeg';
        elseif isequal(get_export_format,'.png')    
            get_export_format = '.png';
        elseif isequal(get_export_format,'.tif') 
            %compressed
            get_export_format = '.tiff';            
        elseif isequal(get_export_format,'.bmp')    
            get_export_format = '.bmp';
        end
    elseif isequal(get_export_properties,'High Quality') || isequal(get_export_properties,'Super Quality')
        if isequal(get_export_format,'.pdf')
            get_export_format = '-dpdf';
        elseif isequal(get_export_format,'.svg')
            get_export_format = '-dsvg';
        elseif isequal(get_export_format,'.eps')  
            %eps level 3 colored
            get_export_format = '-depsc';
        elseif isequal(get_export_format,'.jpg')    
            get_export_format = '-djpeg';
        elseif isequal(get_export_format,'.png')    
            get_export_format = '-dpng';
        elseif isequal(get_export_format,'.tif')    
            %uncompressed
            get_export_format = '-dtiffn';            
        elseif isequal(get_export_format,'.bmp')    
            get_export_format = '-dbmp';
        end       
    end
    
    file = strcat(get_name,get_export_format);
    fpath = fullfile(get_path,file);  
    if isequal(get_export_properties,'Low Quality')
        saveas(get_current_figure, fpath); 
    elseif isequal(get_export_properties,'High Quality')
        % use 300dpi
        fpath = fullfile(get_path,get_name);
        print(get_current_figure, fpath, get_export_format,'-r300');
    elseif isequal(get_export_properties,'Super Quality')
        % use 600dpi
        fpath = fullfile(get_path,get_name);
        print(get_current_figure, fpath, get_export_format,'-r600');        
    end    
    
end
