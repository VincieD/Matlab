function realVideo()
 
% Define frame rate
NumberFrameDisplayPerSecond=10;
 
% Open figure
hFigure=figure(1);
 
% Set-up webcam video input
try
   % For windows
   vid = videoinput('winvideo', 1, 'YUY2_640x480');
catch
   try
      % For macs.
      vid = videoinput('macvideo', 1);
   catch
      errordlg('No webcam available');
   end
end
 
% Set parameters for video
% Acquire only one frame each time
set(vid,'FramesPerTrigger',1);
% Go on forever until stopped
set(vid,'TriggerRepeat',Inf);
% Get a grayscale image
set(vid,'ReturnedColorSpace','grayscale');
triggerconfig(vid, 'Manual');
 
% set up timer object
TimerData=timer('TimerFcn', {@FrameRateDisplay,vid},'Period',1/NumberFrameDisplayPerSecond,'ExecutionMode','fixedRate','BusyMode','drop');
 
% Start video and timer object
start(vid);
start(TimerData);
 

 
% This function is called by the timer to display one frame of the figure
 
function FrameRateDisplay(obj, event,vid)
	persistent IM;
	persistent handlesRaw;
	persistent handlesPlot;
	trigger(vid);
	
	IM=getdata(vid,1,'uint8');
	
	imgBinary = im2bw(IM, 150/255);
    imgEdge_C = canny(IM);
	
    subplot(2,2,1);
    image(IM);
    colormap('gray');
	
    subplot(2,2,2);
	I=single(IM);
	tic, H=hog(I,8,9); toc 
	% tic,V=hogDraw(H,25);toc 
	imshow(imgEdge_C);
%     colormap('gray');

    subplot(2,2,3);
    [counts_G,x_G] = imhist(IM);
    stem(x_G,counts_G,'.k');
	title('Histogram of greyscale picture');
	xlabel('Greyscale range from 0 - 255');
	ylabel('Absolute Value');
	
    subplot(2,2,4);
    % [counts_B,x_B] = imhist(imgEdge_C);
    % stem(x_B,counts_B,'.b');
	Values=mean(IM(:));
	subplot(2,1,2);
	handlesPlot=plot(Values);
	title('Average of Frame');
	xlabel('Frame number');
	ylabel('Average value (au)');

% if isempty(handlesRaw)
   % if first execution, we create the figure objects
   % subplot(2,1,1);
   % handlesRaw=imagesc(IM);
   % title('CurrentImage');
   % colormap('gray');
 
   % Plot first value
   % Values=mean(IM(:));
   % subplot(2,1,2);
   % handlesPlot=plot(Values);
   % title('Average of Frame');
   % xlabel('Frame number');
   % ylabel('Average value (au)');
% else
   % We only update what is needed
   	% I=single(IM);
	% tic, H=hog(I,8,9); toc 
	% tic,V=hogDraw(H,25);toc 
   % set(handlesRaw,'CData',IM);
   % Value=mean(IM(:));
   % OldValues=get(handlesPlot,'YData');
   % set(handlesPlot,'YData',[OldValues Value]);
% end