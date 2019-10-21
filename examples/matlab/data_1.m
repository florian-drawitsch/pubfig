function [x1, y1] = data_1()
%DATA Returns pub-fig example data 
% Author: Florian Drawitsch <florian.drawitsch@gmail.com>

x1 = -7:0.25:7;
y1 = 0.5*x1 + normrnd(0,1,1,length(x1)); 

end

