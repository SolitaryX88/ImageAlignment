close all;
clear all;
% CS 543 Assignment 1, starter Matlab code
% Adapted from A. Efros
% (http://graphics.cs.cmu.edu/courses/15-463/2010_fall/hw/proj1/)

% name of the input file
imname = '01861a.tif';
% imname = '00149v.jpg';
% read in the image
fullim = imread(imname);

% convert to double matrix (might want to do this later on to same memory)
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);
% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);

[height width] = size(G)

cropStartWidth=2450;
cropStartHeight=300;

cropEndWidth=2750;
cropEndHeight=750;

croppedR = R(cropStartHeight:cropEndHeight,cropStartWidth:cropEndWidth);
croppedG = G(cropStartHeight:cropEndHeight,cropStartWidth:cropEndWidth);
croppedB = B(cropStartHeight:cropEndHeight,cropStartWidth:cropEndWidth);

% test(:,:,1) = croppedR;
% test(:,:,2) = croppedG;
% test(:,:,3) = zeros(size(croppedR));



gradientG=gradient(croppedG);
gradientR=gradient(croppedR);
gradientB=gradient(croppedB);
figure;
imshow(croppedR);
% figure;
% imshow(croppedG);

% title('just blue');

[heightC widthC] = size(croppedR);
Ccrop= normxcorr2(gradientG,gradientR);
% [rowC colC] = find(Ccrop==max(max(Ccrop)))

[num idx] = max(Ccrop(:));
[rowC colC] = ind2sub(size(Ccrop),idx)

offsetXC=widthC -colC
offsetYC=heightC - rowC


% % G and R
cropStartWidth=2450;
cropStartHeight=300;
cropEndWidth=2750;
cropEndHeight=750;
croppedR = R(cropStartHeight:cropEndHeight,cropStartWidth:cropEndWidth);
croppedG = G(cropStartHeight:cropEndHeight,cropStartWidth:cropEndWidth);
croppedB = B(cropStartHeight:cropEndHeight,cropStartWidth:cropEndWidth);


newG = zeros(size(G));
for n=1:height
    if n-offsetYC>0 & n-offsetYC<height
        newG(n-offsetYC,:) = G(n,:);
    end
end

newerG = zeros(size(G));
for n=1:width
    if n-offsetXC>0 & n-offsetXC<=width
        newerG(:,n-offsetXC) = newG(:,n);
    end
end




% % % B and R
cropStartWidth=2450;
cropStartHeight=300;
cropEndWidth=2650;
cropEndHeight=3000;
croppedR = R(cropStartHeight:cropEndHeight,cropStartWidth:cropEndWidth);
croppedB = B(cropStartHeight:cropEndHeight,cropStartWidth:cropEndWidth);


Ccrop= normxcorr2(gradient(croppedR),gradient(croppedB));
[rowC colC] = find(Ccrop==max(max(Ccrop)));
[heightC widthC]=size(croppedR);

offsetYC=heightC - rowC

cropStartWidth=500;
cropStartHeight=1300;
cropEndWidth=3000;
cropEndHeight=1500;
croppedR = R(cropStartHeight:cropEndHeight,cropStartWidth:cropEndWidth);
croppedB = B(cropStartHeight:cropEndHeight,cropStartWidth:cropEndWidth);
Ccrop= normxcorr2((croppedR),(croppedB));
[rowC colC] = find(Ccrop==max(max(Ccrop)));
[heightC widthC]=size(croppedR);
offsetXC=widthC -colC

newB = zeros(size(B));
for n=1:height
    if n+offsetYC>0 & n+offsetYC<height
        newB(n+offsetYC,:) = B(n,:);
    end
end

newerB = zeros(size(B));
for n=1:width
    if n+offsetXC>0 & n+offsetXC<width
        newerB(:,n+offsetXC) = newB(:,n);
    end
end

% newColorImage(:,:,1) = zeros(size(G));
newColorImage(:,:,1) = R;
% newColorImage(:,:,2) = zeros(size(G));
newColorImage(:,:,2) = newerG;
% newColorImage(:,:,3) = zeros(size(G));
% newColorImage(:,:,2) = newerB;
newColorImage(:,:,3) = newerB;
% imshow(newColorImage);

% croped = newColorImage(15:height-18,17:width-28,:);
figure;
imshow(newColorImage);

%% figure(1);

% create a color image (3D array)
% ... use the "cat" command
% show the resulting image
% ... use the "imshow" command
% save result image
%% imwrite(colorim,['result-' imname]);
