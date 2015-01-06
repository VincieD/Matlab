% erase the screen and clear teh workspace before start anything

clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures.
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.


% global definitions
global vid;
global hImage_Picture;
global imgGrey;
global imgBinary;

% other functions call
untitled;

% constant definitions
indexA = 0.2989;
indexB = 0.5870;
indexC = 0.1140;
threshold = 100;
fontSize = 22;
global endlessLoop; endlessLoop = 0;
global stop; stop = 150;


% first image before endless loop
firstFrame = getsnapshot(vid);
hImage_Picture = indexA*firstFrame(:,:,1)+indexB*firstFrame(:,:,2)+indexC*firstFrame(:,:,3);

%convert the image in greyscale image
imgGrey = rgb2gray(firstFrame);
		
%convert the image in binary file based on threshold
imgBinary = im2bw(firstFrame, threshold/255);

subplot(2,2,1);
image(imgGrey); 
% scale(grey);
subplot(2,2,2);
image(imgBinary); 
title('hImage_Picture');


% Endless loop for all calculation
while endlessLoop ~= stop
    
    frame = getsnapshot(vid);
%    pause(0.05);
%     hImage_Picture = indexA*frame(:,:,1)+indexB*frame(:,:,2)+indexC*frame(:,:,3);
    imgGrey = rgb2gray(frame);
    imgBinary = im2bw(frame, threshold/255);
    imgEdge_C = canny(imgGrey);
    
    
    subplot(2,2,1);
    image(imgGrey);
    colormap('gray');
    subplot(2,2,2);
    imshow(imgEdge_C);
%     colormap('gray');
    subplot(2,2,3);
    [counts_G,x_G] = imhist(imgGrey);
    stem(x_G,counts_G,'.k');
    subplot(2,2,4);
    [counts_B,x_B] = imhist(imgEdge_C);
    stem(x_B,counts_B,'.b');
%     image(imgBinary);
%     endlessLoop = endlessLoop + 1;
       

% detect moving objects, and track them across video frames

    frame = readFrame();
    [centroids, bboxes, mask] = detectObjects(frame);
    predictNewLocationsOfTracks();
    [assignments, unassignedTracks, unassignedDetections] = ...
        detectionToTrackAssignment();
    
    updateAssignedTracks();
    updateUnassignedTracks();
    deleteLostTracks();
    createNewTracks();
    
    displayTrackingResults();

end

closepreview(vid);
delete(vid);
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures.
