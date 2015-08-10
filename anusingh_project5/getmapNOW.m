function [finalcost, ctg ,x , y] = getmapNOW(x, y, k,im,feat_arielmap,weight7)
if k==1
figure(200), imshow(im)
hold on

[x, y] = ginput();

% gets the cost based on the weights and the features
finalcost = getCostNOW(feat_arielmap,weight7);

% calculates cost to go
ctg = dijkstra_matrix(double(finalcost),y(end),x(end));

% calculates path
[ip1, jp1] = dijkstra_path(ctg, double(finalcost),round(y(1)), round(x(1)));

% plot path
figure(200)
hold on
plot(jp1, ip1,'g-','linewidth',3)
else
    
% case two : car
finalcost = getCostNOW(feat_arielmap,weight7);
ctg = dijkstra_matrix(double(finalcost),y(end),x(end));
[ip1, jp1] = dijkstra_path(ctg, double(finalcost),round(y(1)), round(x(1)));
figure(200)
hold on
plot(jp1, ip1,'r-','linewidth',2)

end