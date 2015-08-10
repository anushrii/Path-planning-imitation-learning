function feat = getFeatures(im)
% created an empty feature matrix
feat = {};
figure(1), imshow(im)

% transforming to HSV and L*a*b color space
colorTransform = makecform('srgb2lab');
labX1 = applycform(im, colorTransform);
%figure(2),imshow(labX1)
 hsvX2 = rgb2hsv(im);
%figure(3),imshow(hsvX2)
 hsvX2 = double(hsvX2(:,:,:));

 
 
X1ab = double(labX1(:,:,2:3));
nrows = size(X1ab,1);
ncols = size(X1ab,2);
X1ab1 = reshape(X1ab,nrows*ncols,2);
hsvX2 = reshape(hsvX2,nrows*ncols,3);

% Doing Kmeans on the color spaces to get specific colours out
% repeat the clustering 3 times to avoid local minima
[cluster_idx1 , ~] = kmeans(X1ab1,4,'distance','sqEuclidean','Replicates',3);
[cluster_idx2 , ~] = kmeans(hsvX2,5,'distance','sqEuclidean','Replicates',3);                               
% a_sidewalk = [124.42,138.8455];
% a_road =  [123.8944, 130.2309];
pixel_labels1 = reshape(cluster_idx1,nrows,ncols);

pixel_labels2 = reshape(cluster_idx2,nrows,ncols);


figure(4),imshow(pixel_labels1,[]);
figure(5),imshow(pixel_labels2,[]);
figure(10),imagesc(pixel_labels2), colormap hot
figure(11),imagesc(pixel_labels1), colormap hot

BlackW = rgb2gray(im);

% to get the edge feature, adding the vertical and horizontal edges
horizontalEdgeImage = imfilter(BlackW, [-1 0 1]);

verticalEdgeImage   = imfilter(BlackW, [-1 0 1]');

V  = im2bw(verticalEdgeImage,0.3);
H  = im2bw(horizontalEdgeImage,0.3);
feat{5} = V + H;
figure(105), imshow(feat{5})


% to obtain individual features from the K means
% L*a*b
ColorImagesLAB = cell(1,3);
rgb_label = repmat(pixel_labels1,[1 1 3]);

for k = 1:4
    color = im;
    color(rgb_label ~= k) = 0;
    ColorImagesLAB{k} = color;
end

%HSV
ColorImagesHSV = cell(1,3);
rgb_label = repmat(pixel_labels2,[1 1 3]);

for k = 1:5
    color = im;
    color(rgb_label ~= k) = 0;
    ColorImagesHSV{k} = color;
end
 
s1  = ColorImagesLAB{1};
s1 = rgb2gray(s1);
s1 = im2bw(s1,0);



s2  = ColorImagesLAB{2};
s2 = rgb2gray(s2);
s2 = im2bw(s2,0);



s3  = ColorImagesLAB{3};
s3 = rgb2gray(s3);
s3 = im2bw(s3,0);

s4  = im2bw(rgb2gray(ColorImagesLAB{4}),0);
s6  = im2bw(rgb2gray(ColorImagesHSV{1}),0);
s7 = im2bw(rgb2gray(ColorImagesHSV{2}),0);
s8 = im2bw(rgb2gray(ColorImagesHSV{3}),0);
s9 = im2bw(rgb2gray(ColorImagesHSV{4}),0);
s10 = im2bw(rgb2gray(ColorImagesHSV{5}),0);

% collecting the binary images for each features

feat{1} = s1;
feat{2} = s2;
feat{3} = s3;
feat{4} = s4;
feat{6} = s6;
feat{7} = s7;
feat{8} = s8;
feat{9} = s9;
feat{10} = s10;


figure(101),imshow(ColorImagesLAB{1}), title('objects in LAB cluster 1');
figure(102),imshow(ColorImagesLAB{2}), title('objects in LAB cluster 2');
figure(103),imshow(ColorImagesLAB{3}), title('objects in LAB cluster 3');
figure(104),imshow(ColorImagesLAB{4}), title('objects in LAB cluster 4');

figure(106),imshow(ColorImagesHSV{1}), title('objects in hsv cluster 1');
figure(107),imshow(ColorImagesHSV{2}), title('objects in hsv cluster 2');
figure(108),imshow(ColorImagesHSV{3}), title('objects in hsv cluster 3');
figure(109),imshow(ColorImagesHSV{4}), title('objects in hsv cluster 4');
figure(110),imshow(ColorImagesHSV{5}), title('objects in hsv cluster 5');








