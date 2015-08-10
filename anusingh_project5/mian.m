% X = imread('aerial_color.jpg');
% X = imresize(X, 0.5);
% 
% X1 = imcrop(X);
% imshow(X1)
%save('images.mat','X1','X')
load('images.mat','X1','X')


% map = rgb2ycbcr(X);
%figure(3), imshow(X1)
colorTransform = makecform('srgb2lab');
labX1 = applycform(X1, colorTransform);
figure(1),imshow(labX1)
% labX1 = rgb2hsv(X1);
% figure(1),imshow(labX1)
% X1ab = double(labX1(:,:,:));


X1ab = double(labX1(:,:,2:3));
nrows = size(X1ab,1);
ncols = size(X1ab,2);
X1ab = reshape(X1ab,nrows*ncols,2);
% X1ab = reshape(X1ab,nrows*ncols,3);
nColors = 3;
% repeat the clustering 3 times to avoid local minima
[cluster_idx , cluster_center] = kmeans(X1ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);
                                  
% a_sidewalk = [124.42,138.8455];
% a_road =  [123.8944, 130.2309];
pixel_labels = reshape(cluster_idx,nrows,ncols);
%figure(2),imshow(pixel_labels,[]), title('image labeled by cluster index');
figure(2),imshow(pixel_labels,[]);
figure(3), imshow(X1)
hold on

[x, y] = ginput();

X = [];
Y = [];

for i = 1:size(x,1)-1
    
[X_, Y_] = getMapCellsFromRay(x(i), y(i), x(i+1), y(i+1));
X = [X;X_];
Y = [Y;Y_];
 end

plot(X,Y,'linewidth',4);
hold off
 BlackW = rgb2gray(X1);
%figure(3),imshow(BlackW)

horizontalEdgeImage = imfilter(BlackW, [-1 0 1]);
%values = horizontalEdgeImage(X,Y);
verticalEdgeImage   = imfilter(BlackW, [-1 0 1]');
figure(5), imshow(horizontalEdgeImage)
figure(6), imshow(verticalEdgeImage)


%hold off

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = X1;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end
figure(101),imshow(segmented_images{1}), title('objects in cluster 1');
figure(102),imshow(segmented_images{2}), title('objects in cluster 1');
figure(103),imshow(segmented_images{3}), title('objects in cluster 1');
%figure(104),imshow(segmented_images{4}), title('objects in cluster 1');
load('trail.mat','road', 'buildings', 'green')
costs = double(road);
costs = 100*imcomplement(costs);
costs = costs + 1;

imagesc(road); axis image;
%[Y, X] = ginput (2);
tic;
ctg = dijkstra_matrix(costs,y(end),x(end));
toc
tic
[ip1, jp1] = dijkstra_path(ctg, costs,round( y(1)), round(x(1)));
toc
[ip2, jp2] = dijkstra_path2(ctg, costs, round(y(1)), round(x(1)));

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

figure(3)
hold on
hold on;
plot(jp1, ip1,'r-');
hold off

% Se = strel('octagon',3);
% D = imdilate(segmented_images{3},Se);
% figure(7),imshow(D)
