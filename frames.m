% sample code of HOG implementation and object recognition
%
% Clear the command window.
clc;
% Close all figures (except those of imtool.)
close all;
% Close all imtool figures.
imtool close all;
% Erase all existing variables.
clear;
% Make sure the workspace panel is showing. 
workspace;  


% global definitions
global vid;
global hImage_Picture;
global imgGrey;
global imgBinary;
global frame;
global opts; 		% training detector (see acfTrain)
global detector;	% trained detector

% constant definitions
threshold = 100;
fontSize = 22;
global endlessLoop; endlessLoop = 0;
global stop; stop = 150;

% call the learning set of Iniria
learningDataSetIniria;

% other functions call
 realVideo;

% Endless loop for all calculation
% while endlessLoop ~= 10

    % image(imgBinary);
    % endlessLoop = endlessLoop + 1;

% end

% We go on until the figure is closed
uiwait(hFigure);
 
% Clean up everything
stop(TimerData);
delete(TimerData);
stop(vid);
delete(vid);
% clear persistent variables
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures.
clear functions;



