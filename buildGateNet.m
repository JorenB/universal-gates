%recursive function for computing matrix product in tree up to specific depth.
%if a previously encountered matrix is calculated, the algorithm exits the branch and backtracks in order to generate only new matrices

% 'depth' is the maximum tree depth walked
% 'base' is the base generating set of gates
% 'upper_gates' is the collection of gates generated in the level above this one
% 'upper_words' is the collection of words associated with upper_gates
function [total_gates, total_words] = buildGateNet(depth, base, upper_gates, upper_words)

	if nargin < 3 
		if nargin < 2
			base = constants.MATRICES;
		end				
		for k=1:length(base)
			base{k} = rotateToSU2(base{k});
		end
		upper_gates = base;
		upper_words = {'1','2','3','4'};
	end

	
	% display progress at every level
	disp('---');
	disp(depth);
	disp(size(upper_gates,2));

	new_gates = {};
	new_words = {};
	t = tic;
	

	for j = 1:length(base)
        for k = 1:length(upper_gates)

			uw = str2num(upper_words{k}(1));
			if uw == 1 && j == 3
				continue;
			elseif uw == 2 && j == 4
		 		continue;		
			elseif uw == 3 && j == 1
				continue;
			elseif uw == 4 && j == 2
				continue;
			end;
            candidate = rotateToSU2(base{j}) * upper_gates{k}; 

            new_gates{length(new_gates)+1} = candidate;
			new_words{length(new_words)+1} = [int2str(j), upper_words{k} ];
        end
	end

	disp(toc(t));

	% if we haven't reached the bottom level, apply the function recursively
    if depth > 1 && size(new_gates, 2) > 0
		[new_gates new_words] = buildGateNet(depth - 1, base, new_gates, new_words);
	end
    
	total_gates = [ upper_gates new_gates ];
	total_words = [ upper_words new_words ];
end
