% edgeImage = sobel(originalImage)
% Sobel edge detection. Given a normalized image (with double values)
% return an image where the edges are detected w.r.t. threshold value.
function edgeImage = canny(originalImage) %#codegen
Gx = [-0.8 1];
Gy = Gx';

Ix = conv2(originalImage,Gx,'same');

edgeImage = edge(Ix,'canny');
