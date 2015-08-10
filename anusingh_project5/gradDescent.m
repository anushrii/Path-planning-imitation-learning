
 function [finalcost, ctg] = gradDescent(im, feat,weight)
 
 % this function implements the gradient descent algorithm.
figure(100), imshow(im)
hold on

% manually inputing the points for handlabelling.
[x, y] = ginput();
X = [];
Y = [];

for i = 1:size(x,1)-1
 
    %Bresenhams algorithm for line drawing:
[X_, Y_] = getMapCellsFromRay(x(i), y(i), x(i+1), y(i+1));
X = [X;X_];
Y = [Y;Y_];
end

% ploting handlabelled path
plot(X,Y,'b.','linewidth',4);
hold off


difference = 20;
j=1;
eta = 1*10^-4;

%Gradient descent as explained in the report:
%limited the iteration number to 20 and set the error sum of abs diff
%threshold between new and old weight as greater than 15
while sum(abs(difference)) > 15 && j <20
    
   % iteration number
    j=j+1;

    % get cost at evry iteration
    costmap = getCostNOW(feat,weight);

    ctg = dijkstra_matrix(double(costmap),y(end),x(end));
    [ip1, jp1] = dijkstra_path(ctg, double(costmap),round(y(1)), round(x(1)));

% plotting the path built at evry iteratio
figure(100)
hold on
plot(jp1, ip1,'r-');
hold off

   % figure, imagesc(costmap), colormap hot
    indices = sub2ind(size(costmap),Y,X);
    ctDesired = costmap(indices);
    index = sub2ind(size(costmap),ip1,jp1);
    ctMin = costmap(index);
    featMatrixDesired =[];
    featMatrixMin =[];
    for i = 1:size(feat,2)
    featMatrixDesired = [featMatrixDesired; (feat{i}(indices))'];
    featMatrixMin = [featMatrixMin; (feat{i}(index))'];
    end
    desiredPath  = sum(bsxfun(@times,double(featMatrixDesired),ctDesired'),2);
    minPath = sum(bsxfun(@times,double(featMatrixMin),ctMin'),2);
    
    % calculating difference and new weight
    diff = desiredPath - minPath;
    difference = -eta*diff;
    weight = weight - (eta*diff)';
    %difference = weight
    weight  = weight + abs(min(weight)) +1;
   
end

% getting the final cost map using the updated weight
finalcost = getCostNOW(feat,weight);
ctg = dijkstra_matrix(double(finalcost),y(end),x(end));
[ip1, jp1] = dijkstra_path(ctg, double(finalcost),round(y(1)), round(x(1)));

% plotting the final path 
figure(100)
hold on
plot(jp1, ip1,'g-','linewidth',3)
hold off




