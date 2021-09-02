function f = set_figure_handle(f, varargin)
% setFigureHandle allows to conveniently set figure properties relevant for
% publication-quality figures
%   It allows to easily set common paper sizes and orientations,
%   facilitates producing properly centered figures on both on both paper
%   and screen while ensuring consistent font usage
%   INPUT:  f: figure handle
%                   Handle of figure to be modified
%               width (optional name-value argument): int
%                   Set figure width
%                   (default: maximum for respective paperSize)
%               height (optional name-value argument): int
%                   Set figure height
%                   (default: maximum for respective paperSize)
%               paperSize (optional name-value argument): str
%                   Set Din Paper Size. 
%                   Valid values: 'A1', ..., 'A6'.
%                   (default: 'A4')
%               orientation: (optional name-value argument): str
%                   Set paper orientation.
%                   Valid values: 'portrait', 'landscape'
%                   (default: 'portrait')
%               font: (optional name-value argument): str
%                   Set global figure font.
%                   Valid values: Must be amongst the available system
%                   fonts (checks against the return value of the matlab
%                   utility listfonts)
%                   (default: 'Helvetica')
%               fontWeight: (optional name-value argument): str
%                   Set global figure font weight.
%                   Valid values: 'Normal', 'Bold'
%                   (default: 'Normal')
%   OUTPUT: f: figure handle
%                   Handle of modified figure
%   Usage example:
%       f = setFigureHandle(f, 'width', 7, 'height', 5, 'font', 'Monospaced')
% Author: Florian Drawitsch <florian.drawitsch@gmail.com>


% Define input argument assertions
checkHandle = @(x) ishandle(x) && strcmp(get(x,'type'),'figure');
checkPaperSize = @(x) ~isempty(regexpi(x,'^A\d$'));
checkOrientation = @(x) ~isempty(validatestring(x,{'portrait','landscape'}));
checkFont = @(x) ~isempty(validatestring(x,listfonts));
checkFontWeight = @(x) ~isempty(validatestring(x,{'Normal','Bold'}));
checkNum = @(x) isnumeric(x);

% Define input argument parser
p = inputParser;
addRequired(p,'handle',checkHandle);
addOptional(p,'width',Inf,checkNum)
addOptional(p,'height',Inf,checkNum)
addOptional(p,'paperSize','A4',checkPaperSize)
addOptional(p,'orientation','portrait',checkOrientation)
addOptional(p,'font','Helvetica',checkFont)
addOptional(p,'fontWeight','Normal',checkFontWeight)
parse(p,f,varargin{:})

% Din A size table
dinDim.A1 = [594 841];
dinDim.A2 = [420 594];
dinDim.A3 = [297 420];
dinDim.A4 = [210 297];
dinDim.A5 = [148 210];
dinDim.A6 = [105 148];

% Set Din Dimensions
dinDim.selected = dinDim.(p.Results.paperSize)*0.1;
if strcmp(p.Results.orientation,'portrait')
    Y = dinDim.selected(2);
    X = dinDim.selected(1);
elseif strcmp(p.Results.orientation,'landscape')
    Y = dinDim.selected(1);
    X = dinDim.selected(2);
end

% Set Global Paper Parameters
set(f, 'PaperOrientation',p.Results.orientation)
set(f, 'PaperUnits','centimeters')
set(f, 'PaperSize',[X Y])
set(f, 'Color', [1 1 1])

% Set Paper Position
xMargin = 1;        
yMargin = 1;            
xSizeMax = X - 2*xMargin;   
ySizeMax = Y - 2*yMargin; 
if p.Results.width >= xSizeMax
    xSize = xSizeMax;
    xStart = xMargin;
else
    xSize = p.Results.width;
    xStart = (xSizeMax - xSize)/2;
end
if p.Results.height >= ySizeMax
    ySize = ySizeMax;
    yStart = yMargin;
else
    ySize = p.Results.height;
    yStart = (ySizeMax - ySize)/2;
end

% Set figure size displayed on screen
set(f, 'Units','centimeters', 'Position',[0 0 xSize ySize])
movegui(f, 'center')

% Set figure size printed on paper
set(f, 'PaperPosition',[xStart yStart xSize ySize])

% Adapt all figure fonts to target
set(findall(f,'-property','FontName'),'FontName', p.Results.font)
set(findall(f, 'type', 'text'),'FontWeight', p.Results.fontWeight)

end
