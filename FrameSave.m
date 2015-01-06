% Callback Every fps Frames
function FrameSave(vid,eventdata,frm)
	disp(vid.FramesAcquired);
	imgRGB = getdata(vid,vid.FramesAcquiredFcnCount);
	newImg = true;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% General settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% frames per second settings of picture calculation
fps = 15;

% frames per second settings of picture calculation
threshold = 0.5;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GUI settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% will create a AXES object based on the axes handler
axes(handles.axes1);

% the video resource link to adapter name and device ID 
vid = videoinput('winvideo', 1, 'YUY2_320x240');

set(vid,'FramesAcquiredFcn',{@FrameSave},'FramesAcquiredFcnCount',fps);
set(vid,'FramesPerTrigger',nframes,'LoggingMode','memory');
set(vid, 'Timeout', fps);
set(vid, 'ReturnedColorSpace', 'RGB');

% create an handle of image object where will be the images displayed
% zeros(320,240,3) – will create a 352 by 288 by 3 array
hImage=image(zeros(320,240,3),'Parent',handles.axes1);

preview(vid,hImage);

axes(handles.axes2);
hImageSub=image(zeros(320,240,3),'Parent',handles.axes2);
imshow(hImageSub);

%convert the image in greyscale image
%imgGrey = rgb2gray(imgRGB);
		
%convert the image in binary file based on threshold
%imgBinary = im2bw(imgGrey, threshold);








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Endless loop of calcuation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% while 1 do
% 	% Begin loop - get the image from video - based on fps - 15 frames per second
% 	%img = getsnapshot(vid);
% 	
% 	% Process the image
% 	if newImg == True do
% 		newImg = false;
% 		
% 		%convert the image in greyscale image
% 		imgGrey = rgb2gray(imgRGB);
% 		
% 		%convert the image in binary file based on threshold
% 		imgBinary = im2bw(imgGrey, threshold);		
% 		
%   else
% 	
% 	% End loop - show the image on the screen
% 	imshow(img);
%   end
% end