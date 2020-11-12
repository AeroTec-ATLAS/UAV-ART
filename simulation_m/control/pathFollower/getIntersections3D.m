% Get intersections between the bounds of the view and a straight
% r:        origin of the straight
% q:        director vector of the straight
% bounds:   bounds of the view
function ints = getIntersections3D(r,q,bounds)
    ints = zeros(size(bounds));
    numInts = 1;
    
    % For each pair of faces of the visualization paralleliped in the space
    for i=1:size(bounds,1)
        % For the first face or the second of each pair
        for j = 1:2
            % in a parametric equation of a straight line gets the value
            % obtained for the selected face
            fraction = (bounds(i,j)-r(i))/q(i);
            
            indexes = [0.5*i^2-2.5*i+4,-0.5*i^2+1.5*i+2];
            
            points = [fraction*q(indexes(1))+r(indexes(1)),...
                fraction*q(indexes(2))+r(indexes(2))];
            
            if points(1) <= bounds(indexes(1),2) && points(1) >= ...
                    bounds(indexes(1),1) && points(2) <= ...
                    bounds(indexes(2),2) && points(2) >= ...
                    bounds(indexes(2),1)
                ints(indexes(1),numInts)=points(1);
                ints(indexes(2),numInts)=points(2);
                ints(i,numInts)=bounds(i,j);
                
                numInts = numInts+1;
            end
        end
    end
end