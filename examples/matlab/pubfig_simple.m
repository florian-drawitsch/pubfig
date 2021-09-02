function [f, ax] = pubfig_simple()
%pubfig_simple provides a basic usage example for the figure 
% and axes handle modifiers of pubfig 
% Author: Florian Drawitsch <florian.drawitsch@gmail.com>

% Set relative package path
addpath(fullfile(pwd,'..','pubfig'));

% Import data
[x1, y1] = data_1();
[x2, y2] = data_2();

% Generate simple figure
f = figure;
ax = gca;
scatter(x1, y1, 10, [.2 .4 .6]);
hold on;
plot(x2, y2, 'Color', [.7 .3 .3], 'LineWidth', 1);
ax.XLim = [-10, 10];
ax.YLim = [-10, 10];
ax.XLabel.String = 'Var 1';
ax.YLabel.String = 'Var 2';
ax.Title.String = {'My arbitrary','correlation'};

% Pass figure and axes handles through pubfig utilities
f = set_figure_handle(f, 'width', 5, 'height', 5);
ax = set_axes_handle(ax);

% Save in example vector and raster graphics formats
output_prefix = mfilename;
print(f, [output_prefix, '.pdf'], '-dpdf');
saveas(f, [output_prefix, '.png']);

end

