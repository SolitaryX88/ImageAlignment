close all;
clear all;
% CS 543 Assignment 1, starter Matlab code
% Adapted from A. Efros
% (http://graphics.cs.cmu.edu/courses/15-463/2010_fall/hw/proj1/)

% name of the input file
imname = '00153v.jpg';
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
croppedHeightStart=20;
croppedHeightEnd=20;
croppedWidthStart=30;
croppedWidthEnd=20;
croppedR = R(croppedHeightStart:height-croppedHeightEnd,croppedWidthStart:width-croppedWidthEnd);
croppedG = G(croppedHeightStart:height-croppedHeightEnd,croppedWidthStart:width-croppedWidthEnd);
croppedB = B(croppedHeightStart:height-croppedHeightEnd,croppedWidthStart:width-croppedWidthEnd);

test(:,:,1) = croppedR;
test(:,:,2) = croppedG;
test(:,:,3) = croppedB;
% figure;
% imshow(test);
% title('initial crop');
% figure;
% imshow(gradient(croppedR));
% title('red crop');


[heightC widthC] = size(croppedR);
CcropGR= normxcorr2(gradient(croppedG),gradient(croppedR));
rangeC = CcropGR(heightC-15:heightC+15,widthC-15:widthC+15);


[rowC colC] = find(CcropGR==max(max(CcropGR)));
offsetXCgr=widthC-colC
offsetYCgr=heightC-rowC 
% [rowC colC] = find(rangeC==max(max(rangeC)));
% offsetXCgr=colC-15
% offsetYCgr=rowC-15
% offsetYCgr=15

% % G and R




newG = zeros(size(G));
for n=1:height
    if n-offsetYCgr>0 & n-offsetYCgr<height
        newG(n-offsetYCgr,:) = G(n,:);
    end
end

newerG = zeros(size(G));
for n=1:width
    if n-offsetXCgr>0 & n-offsetXCgr<=width
        newerG(:,n-offsetXCgr) = newG(:,n);
    end
end




% % % % B and R
Ccrop= normxcorr2(gradient(croppedR),gradient(croppedB));
[rowC colC] = find(Ccrop==max(max(Ccrop)));

offsetXC=widthC -colC
offsetYC=heightC - rowC

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
newColorImage(:,:,3) = newerB;
% imshow(newColorImage);

croped = newColorImage(20:height-20,30:width-20,:);
figure;
% subplot(2,1, 2);
imshow(croped);
title('after alignment');
% open figure
%% figure(1);

% create a color image (3D array)
% ... use the "cat" command
% show the resulting image
% ... use the "imshow" command
% save result image
%% imwrite(colorim,['result-' imname]);
