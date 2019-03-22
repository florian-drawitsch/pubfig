% Create some example data
x1 = normrnd(0,2,100,1);
y1 = normrnd(1,1.5,100,1) + x1;

f = figure
ax = gca
scatter(x1, y1, 20)
ax.XLim = [-10, 10]
ax.YLim = [-10, 10]
ax.XLabel.String = 'Var 1'
ax.YLabel.String = 'Var 2'
ax.Title.String = {'My arbitrary','correlation'}

f = setFigureHandle(f, 'width', 5, 'height', 5.5)
ax = setAxesHandle(ax, 'lineWidth', 1, 'tickLength', [0.04, 0.04], 'font', 'Helvetica')



