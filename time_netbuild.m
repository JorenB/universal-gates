% wrapper function that times the execution of the net builder
% also inputs some useful standard parameters
function tuple = time_netbuild(depth)  
s = tic;
dimension = size(constants.MATRICES{1}, 1);
[gates words] = buildGateNet(depth, constants.MATRICES, {eye(dimension)}, {''}, {eye(dimension)});
tuple = {processGates(gates), words};
toc(s)
end
