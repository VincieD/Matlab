% Closing all windows before starting algorithm
close all;

% I = imread('road01.jpg');
% I = imread('road02.jpg');
I = imread('road03.jpg');
indexA = 0.2889;
indexB = 0.6870;
indexC = 0.0940;

Igray = indexA*I(:,:,1)+indexB*I(:,:,2)+indexC*I(:,:,3);

figure; 
image(Igray,'CDataMapping','scaled'); 
colormap('gray');

title('Input Image in Grayscale');

% % Obtaining the image gradient
Gx = [-1.8 1];
Gy = Gx';
Ix = conv2(Igray,Gx,'same');
Iy = conv2(Igray,Gy,'same');
Iy = conv2(Igray,Gy,'same');

figure; image(Ix,'CDataMapping','scaled'); colormap('gray'); title('Ix');


BW1 = edge(Ix,'sobel');
BW2 = edge(Ix,'canny');
figure;imshow(BW2);
figure;imshow(BW1);

thresh = 180;
% lanes = im2bw(BW2, thresh/255);
lanes = im2bw(Igray, thresh/255);
%imshow(lanes);

lanes = bwareaopen(lanes,80);
lanes = lanes & ~bwareaopen(lanes,4000);
%imshow(lanes);

%lanes = imclearborder(lanes);
imshow(lanes);

% Find lanes
[B,L] = bwboundaries(lanes,'noholes');
numRegions = max(L(:));
%imshow(label2rgb(L));

stats = regionprops(L,'all');
% keepersA[];
% keepersB[];
shapes = [stats.Eccentricity];
orient = [stats.Orientation];
eccent = [stats.EquivDiameter];
keepersA = find((orient > -60) & (orient < 60));
keepersB = find(eccent < 15);
keepersC = find(shapes > 0.90);
keepers = setdiff(keepersA,keepersC);

for index=1:length(keepers)
    outline = B{keepers(index)};
    line(outline(:,2),outline(:,1),'Color','r','LineWidth',2)
end

[H,theta,rho] = hough(lanes);
peaks = houghpeaks(H,2);
lines = houghlines(lanes,theta,rho,peaks,'FillGap',50,'MinLength',30);

% for index=1:length(lines)
%     arrow(lines(index).point1,lines(index).point2,'EdgeColor','g','FaceColor','g','LineWidth',2)
% end
