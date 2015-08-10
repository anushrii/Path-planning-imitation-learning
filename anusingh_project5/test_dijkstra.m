% costs = gen_costs(100, 100, .05);
load('trail.mat','road', 'buildings', 'green')
costs = double(road);
costs = 100*imcomplement(costs);
costs = costs + 1;

imagesc(road); axis image;
[Y, X] = ginput (2);
tic;
ctg = dijkstra_matrix(costs,X(2),Y(2));
toc
tic
[ip1, jp1] = dijkstra_path(ctg, costs,round( X(1)), round(Y(1)));
toc
[ip2, jp2] = dijkstra_path2(ctg, costs, round(X(1)), round(Y(1)));

subplot(1,2,1);
imagesc(costs,[1 10]);
colormap(1-gray);
hold on;
plot(jp1, ip1, 'b-', jp2, ip2, 'r-');
hold off;

subplot(1,2,2);
imagesc(ctg);
colormap(1-gray);
hold on;
plot(jp1, ip1, 'b-', jp2, ip2, 'r-');
hold off;
