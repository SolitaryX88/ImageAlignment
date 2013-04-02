close all;
clear all;
% CS 543 Assignment 1, starter Matlab code
% Adapted from A. Efros
% (http://graphics.cs.cmu.edu/courses/15-463/2010_fall/hw/proj1/)

% name of the input file
imname = '00125v.jpg';
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

% Align the images
% Functions that might be useful to you for aligning the images include: 
% "circshift", "sum", and "imresize" (for multiscale)
%%%%%aG = align(G,B);
%%%%%aR = align(R,B);
% figure;
% imshow(R+G+B)

% figure;
% imshow(G)
% figure;
% imshow(B)

% % G and R

C=normxcorr2(G,R);
[row col] = find(C==max(max(C)))

[height width] = size(G)

offsetX=width -col
offsetY=height - row

newG = zeros(size(G));
for n=1:height
    if n-offsetY>0 & n-offsetY<height
        newG(n-offsetY,:) = G(n,:);
    end
end

newerG = zeros(size(G));
for n=1:height
    if n-offsetX>0 & n-offsetX<height
        newerG(n-offsetX,:) = newG(n,:);
    end
end

% newColorImage(:,:,3) = B;
newColorImage(:,:,1) = R;
newColorImage(:,:,2) = newG;


% % B and R
C=normxcorr2(R,B);
[row col] = find(C==max(max(C)))

[height width] = size(B)





offsetX=width -col
offsetY=height - row

newB = zeros(size(B));
for n=1:height
    if n+offsetY>0 & n+offsetY<height
        newB(n+offsetY,:) = B(n,:);
    end
end

newerB = zeros(size(B));
for n=1:height
    if n+offsetX>0 & n+offsetX<height
        newerB(n+offsetX,:) = newB(n,:);
    end
end

% newColorImage(:,:,1) = zeros(size(G));
newColorImage(:,:,1) = R;
% newColorImage(:,:,2) = zeros(size(G));
newColorImage(:,:,2) = newerG;
% newColorImage(:,:,3) = zeros(size(G));
newColorImage(:,:,3) = newerB;
% imshow(newColorImage);

croped = newColorImage(20:height-10,25:width-20,:);
imshow(croped);
% open figure
%% figure(1);

% create a color image (3D array)
% ... use the "cat" command
% show the resulting image
% ... use the "imshow" command
% save result image
%% imwrite(colorim,['result-' imname]);
