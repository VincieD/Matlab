% video input

% hardcoded size of window
% minimunm size fo pedestrian needs to be evaluazted 
% size of the windows depends on vehicle speed
% once the pedestrian is detected the coordinates from the picture shall be
% excluded
function slidingWindow(image,speed,angle,pixelStep) %#codegen
imageWidth = 320;
imageHeight = 240;

winWidth = 32;
windowHeight = 32;

if speed <= 10
    for j = 1:uint16((imageHeight - windowHeight + 1)/pixelStep)
        for i = 1:uint16((imageWidth - winWidth + 1)/pixelStep)
            window = image(j:j + windowHeight - 1, i:i + winWidth - 1, :);
            % do stuff with subimage
            [counts,x] = imhist(window);
            % if the histogram is close to some training histogram - we
            % could store the coordinates of the sub window and mark the
            % rectangle around it
        end
    end
else
    for j = 1:uint16((imageHeight - windowHeight + 1)/pixelStep)
        for i = 1:uint16((imageWidth - winWidth + 1)/pixelStep)
            window = image(j:j + windowHeight - 1, i:i + winWidth - 1, :);
            % do stuff with subimage

        end
    end
end