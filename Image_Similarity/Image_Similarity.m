p1 = imread('A.jpg');
p2 = imread('B.jpg');

%resizing second image down to the first image 
p2 = imresize(p2,[size(p1,1) size(p1,2)]);

%grayscale image for gradience
p1gray = rgb2gray(p1);
p2gray = rgb2gray(p2);

sobl=fspecial('sobel');
%horizontal gradience
p1hor = imfilter(p1gray,sobl);
p2hor = imfilter(p2gray,sobl);
%vertical gradience
p1ver = imfilter(p1gray,sobl');
p2ver = imfilter(p2gray,sobl');

%variables for computing gradience similarity
x1 = 0;
y1 = 0;
x2 = 0;
y2 = 0;

%thresholds for gradience and RGB histograms
gradthreshold = 200;
rgbthreshold = 100;

%Instead of comparing the entire gradiency, compare only the edges
for row = 1:size(p1hor,1)
    for col = 1:size(p1hor,2)
        if p1hor(row,col,1) > gradthreshold
            y1 = y1 + 1;
            if p2hor(row,col,1) > gradthreshold - 100
                x1 = x1 + 1;
            end
        end
    end
end

x1 = x1 / y1; % x for gradient similarity



%Instead of comparing the entire gradiency, compare only the edges
for row = 1:size(p1ver,1)
    for col = 1:size(p1ver,2)
        if p1ver(row,col,1) > gradthreshold
            y2 = y2 + 1;
            if p2ver(row,col,1) > gradthreshold - 100
                x2 = x2 + 1;
            end
        end
    end
end

x2 = x2 / y2;

grad = (x1+x2) / 2;

fprintf('The gradience similarity between the two images is %f percent\n', grad*100);
    
r1 = zeros(1,256);
g1 = zeros(1,256);
b1 = zeros(1,256);

r2 = zeros(1,256);
g2 = zeros(1,256);
b2 = zeros(1,256);

%Making histograms for each image and band
for row = 1:size(p1,1)
    for col = 1:size(p1,2)
        r1(p1(row,col,1)+1) = r1(p1(row,col,1)+1) + 1;
        g1(p1(row,col,2)+1) = g1(p1(row,col,2)+1) + 1;
        b1(p1(row,col,3)+1) = b1(p1(row,col,3)+1) + 1;
    end
end

for row = 1:size(p2,1)
    for col = 1:size(p2,2)
        r2(p2(row,col,1)+1) = r2(p2(row,col,1)+1) + 1;
        g2(p2(row,col,2)+1) = g2(p2(row,col,2)+1) + 1;
        b2(p2(row,col,3)+1) = b2(p2(row,col,3)+1) + 1;
    end
end

histcmpr = 0;
histcmpg = 0;
histcmpb = 0;

%difference b/w levels for rgb respectively
for i = 1:256
     if abs(r1(i) - r2(i)) < rgbthreshold
       histcmpr = histcmpr + 1; 
     end
end

for i = 1:256
     if abs(g1(i) - g2(i)) < rgbthreshold
       histcmpg = histcmpg + 1; 
     end
end

for i = 1:256
     if abs(b1(i) - b2(i)) < rgbthreshold
       histcmpb = histcmpb + 1; 
     end
end

%average similarity for each band
histcmpr = histcmpr / 256;
histcmpg = histcmpg / 256;
histcmpb = histcmpb / 256;

%average similarity for all 3 bands
histcmp = (histcmpr + histcmpg + histcmpb) / 3;

fprintf('The color histogram similarity between the two images is %f percent\n', histcmp*100);
            
