function laneDetection()
    Gx = [-0.8 1];
    Gy = Gx';

    Ix = conv2(hImage_Picture,Gx,'same');
    BW1 = edge(Ix,'sobel');
    BW2 = edge(Ix,'canny');
%     imshow(BW2);
%     
%     hImage_blue = 0.0*firstFrame(:,:,1)+0.0*firstFrame(:,:,2)+1.0*firstFrame(:,:,3);
%     imshow(hImage_blue);

    
    % lanes = im2bw(BW2, threshold/255);
    lanes = im2bw(hImage_Picture, threshold/255);
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