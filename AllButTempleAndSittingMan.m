close all;
clear all;
% CS 543 Assignment 1, starter Matlab code
% Adapted from A. Efros
% (http://graphics.cs.cmu.edu/courses/15-463/2010_fall/hw/proj1/)

% name of the input file
imname = '00149v.jpg';
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

[height width] = size(G);
croppedAmount=40;
croppedR = R(croppedAmount:height-croppedAmount,croppedAmount:width-croppedAmount);
croppedG = G(croppedAmount:height-croppedAmount,croppedAmount:width-croppedAmount);
croppedB = B(croppedAmount:height-croppedAmount,croppedAmount:width-croppedAmount);

% test(:,:,1) = croppedR;
% test(:,:,2) = croppedG;
% test(:,:,3) = zeros(size(croppedR));
% figure;
% imshow(test);

[heightC widthC] = size(croppedR);
Ccrop= normxcorr2(croppedG,croppedR);
[rowC colC] = find(Ccrop==max(max(Ccrop)));

offsetXC=widthC -colC
offsetYC=heightC - rowC


% % G and R




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
Ccrop= normxcorr2(croppedR,croppedB);
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

croped = newColorImage(15:height-18,17:width-28,:);
figure;
imshow(croped);
% open figure
%% figure(1);

% create a color image (3D array)
% ... use the "cat" command
% show the resulting image
% ... use the "imshow" command
% save result image
%% imwrite(colorim,['result-' imname]);
