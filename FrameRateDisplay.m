% This function is called by the timer to display one frame
function FrameRateDisplay(obj, event,vid)
	global frame;
	persistent handlesRaw;
	persistent handlesPlot;
	trigger(vid);
	frame=getdata(vid,1,'uint8');
	 
% if isempty(handlesRaw)
   % if first execution, we create the figure objects
   % subplot(2,1,1);
   % handlesRaw=imagesc(IM);
   % title('CurrentImage');
 
   % Plot first value
   % Values=mean(IM(:));
   % subplot(2,1,2);
   % handlesPlot=plot(Values);
   % title('Average of Frame');
   % xlabel('Frame number');
   % ylabel('Average value (au)');
% else
   % We only update what is needed
   % set(handlesRaw,'CData',IM);
   % Value=mean(IM(:));
   % OldValues=get(handlesPlot,'YData');
   % set(handlesPlot,'YData',[OldValues Value]);
end