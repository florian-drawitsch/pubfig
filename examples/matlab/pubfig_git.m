function [f, ax] = pubfig_git()
%pubfig_git provides an extended usage example demonstrating
% how figures can be generated with auxiliary tables indicating
% the git commit and blob hashes of relevant data files
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

% Compose cell array holding all relevant paths (e.g. matlab functions,
% or markup files etc.) used to generate this plot. Here, this would be
% the plotting function (this function) and the functions called to retrieve data
% for the plot generation (data_1 and data_2, see data import above)
paths = {mfilename('fullpath'), which('data_1'), which('data_2')};

% Retrieve git hashes of these paths and write them to csv to allow to 
% precisely reconstruct how a given figure was generated at a later time
% point
path_hashes = get_git_hashes(paths);
writetable(path_hashes, [output_prefix, '.csv']);

end

