function ax = setAxesHandle(ax, varargin)
% setAxisHandle allows to conveniently set axes properties relevant for
% publication-quality figures
%   It allows to easily set common paper sizes and orientations,
%   facilitates producing properly centered figures on both on both paper
%   and screen with consistent fonts
%   INPUT:  ax: axes handle
%                   Handle of axes to be modified
%               font: (optional name-value argument): str
%                   Set axes font.
%                   Valid values: Must be amongst the available system
%                   fonts (checks against the return value of the matlab
%                   utility listfonts)
%                   (default: 'Helvetica')
%               fontSize: (optional name-value argument): float
%                   Set axes font size.
%                   (default: auto-adapts to parent figure size)
%               lineWidth: (optional name-value argument): float
%                   Set axes line width.
%                   (default: auto-adapts to parent figure size)
%               tickLength: (optional name-value argument): float
%                   Set axes tick length.
%                   (default: auto-adapts to parent figure size)
%               minorTicks: (optional name-value argument): str
%                   Switch minor ticks on or off.
%                   Valid values: {'on', 'off'}
%                   (default: 'on')
%               tickDir: (optional name-value argument): str
%                   Switch direction of ticks
%                   Valid values: {'in', 'out'}
%                   (default: 'out')
%               color: (optional name-value argument): [1 x 3] array of float
%                   Switch color of all axes elements using RGB array
%                   Valid values: [1 x 3] array of float in interval [0,1]
%                   (default: [0, 0, 0] -> black)
%   OUTPUT: ax: axes handle
%                   Handle of modified axes
%   Usage example:
%       ax = setAxesHandle(ax, 'lineWidth', 1, 'tickLength', [0.04, 0.04])
% Author: Florian Drawitsch <florian.drawitsch@gmail.com>


% Define input argument assertions
checkHandle = @(x) ishandle(x) && strcmp(get(x, 'type'), 'axes');
checkFont = @(x) ~isempty(validatestring(x, listfonts));
checkMinorTicks = @(x) ~isempty(validatestring(x, {'on', 'off'}));
checkTickDir = @(x) ~isempty(validatestring(x, {'out', 'in'}));
checkTickLength = @(x) isequal(size(x), [1 2]) && isnumeric(x);
checkColor = @(x) isequal(size(x), [1 3]) && isnumeric(x);
checkNum = @(x) isnumeric(x);

% Retrieve position from parent figure to infer absolute dimensions
f = ancestor(ax, 'figure');
set(f, 'Units','centimeters');
pos = f.PaperPosition;
scaleRel = pos(3:4) ./ 5;

% Define adaptive default values
tickLengthAuto = 0.025 * 1.2.^scaleRel;
lineWidthAuto = max([0.5, 0.25 * 1.2^round(mean(scaleRel))]);
fontSizeAuto = 10 * 1.2^round(mean(scaleRel));

% Define input argument parser
p = inputParser;
addRequired(p,'handle',checkHandle);
addOptional(p,'font','Helvetica',checkFont)
addOptional(p,'fontSize',fontSizeAuto,checkNum)
addOptional(p,'lineWidth',lineWidthAuto,checkNum)
addOptional(p,'tickLength',tickLengthAuto,checkTickLength)
addOptional(p,'minorTicks','on',checkMinorTicks)
addOptional(p,'tickDir','out',checkTickDir)
addOptional(p,'color',[0 0 0],checkColor)
parse(p,ax,varargin{:})

% Set axes properties
set(ax,'FontName',p.Results.font)
set(ax,'FontSize',p.Results.fontSize)
set(ax,'LineWidth',p.Results.lineWidth)
set(ax,'TickLength',p.Results.tickLength)
set(ax,'XMinorTick',p.Results.minorTicks)
set(ax,'YMinorTick',p.Results.minorTicks)
set(ax,'TickDir',p.Results.tickDir)
set(ax,'GridColor',p.Results.color)
set(ax,'MinorGridColor',p.Results.color)
set(ax,'XColor',p.Results.color)
set(ax,'YColor',p.Results.color)
set(ax,'Box','off')

end

