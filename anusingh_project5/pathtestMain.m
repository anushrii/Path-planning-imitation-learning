% final path 

im = read_files();
load('features_aerial_full.mat','feat_arielmap')
load('impweights5_humanpath_best.mat','weight7')

% %% for pedestrain, ideal weight and feature set is loaded
costmapPedes = getCostNOW(feat_arielmap,weight7);
k =1;
[finalcostPedes, ctgPedes , x ,y] = getmapNOW(0, 0, k,im,feat_arielmap,weight7); %% walks only on paths

%% for car to traverse best weight 
load('impweights6_best.mat','weight5')
costmapCar = getCostNOW(feat_arielmap,weight5);
k=2;
[finalcostCar, ctgCar] = getmapNOW(x, y, k,im,feat_arielmap,weight5);
