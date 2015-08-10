%% getting pics


%% resized the image

% X = imread('aerial_color.jpg');
% X = imresize(X, 0.5);

%% making smaller maps

% X2 = imcrop(X);
% imshow(X2)
% X3 = imcrop(X);
% imshow(X3)
% X4 = imcrop(X);
% imshow(X4)
% X5 = imcrop(X);
% imshow(X5)
% X6 = imcrop(X);
% imshow(X6)
% X7 = imcrop(X);
% imshow(X7)
% save('images.mat','X2','X3','X4','X5','X6','X7')


%% TRAIN
% reading the image path
im = read_files();
%im = imresize(im, 0.5);
% getting features
%feat_arielmap = getFeatures(im);
%  save('featuresX6','featX6')
load('features_aerial_full.mat','feat_arielmap')
% load('featuresX3.mat','featX3')

% road_hsv = 50;
% crapgreen_lab = 1000;
% road_lab = 1;
% building_hsv = 5000;
% edge = 10000; 
% %manpath_hsv = 5000;
% crap = 1000;
% veg1tree_hsv = 5000;
% veg2walk_hsv = 500;
% green2_lab = 3000;
% manpath_lab = 1000;

%weight =  [crapgreen_lab, road_lab, green2_lab, manpath_lab, edge, building_hsv, veg1tree_hsv, crap, road_hsv, veg2walk_hsv];% seq for X2
%weight =  [green2_lab, manpath_lab, crapgreen_lab, road_hsv, edge, building_hsv, veg2walk_hsv, veg1tree_hsv, crap, road_hsv]; % seq for X3
%weight =  [manpath_lab, crapgreen_lab, road_lab, green2_lab, edge, veg1tree_hsv, crap, road_hsv, building_hsv,veg2walk_hsv]; % seq for X4
%weight =  [green2_lab, road_lab, crapgreen_lab , manpath_lab, edge, crap, building_hsv, road_hsv,veg1tree_hsv,veg2walk_hsv]; % seq for X5  
%weight =  [crapgreen_lab, road_lab, manpath_lab , green2_lab, edge, road_hsv, building_hsv, crap,veg2walk_hsv,veg1tree_hsv ]; % seq for X6  
%weight =  [road_lab, green2_lab,crapgreen_lab , manpath_lab, edge, veg1tree_hsv,veg2walk_hsv, building_hsv,crap,road_hsv ]; % seq for full map 
  
  
% human to walk the weights to start with would be
road_hsv = 5000;
crapgreen_lab = 1000;
road_lab = 5000;
building_hsv = 9000;
edge = 10000; 
crap = 1000;
veg1tree_hsv = 5000;
veg2walk_hsv = 5;
green2_lab = 300;
manpath_lab = 1;
  
weight =  [road_lab, green2_lab,crapgreen_lab , manpath_lab, edge, veg1tree_hsv,veg2walk_hsv, building_hsv,crap,road_hsv ];
costmap = getCostNOW(feat_arielmap,weight);
[finalcost, ctg] = gradDescent(im,feat_arielmap,weight);
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  