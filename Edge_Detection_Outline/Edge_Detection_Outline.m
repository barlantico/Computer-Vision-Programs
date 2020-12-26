%GOOD FOR CARDINALS, WORKING FOR RED
image = imread('cardinals.jpg');
imagetemp = image;




sobl=fspecial('sobel');

hor1 = imfilter(imagetemp,sobl);
ver1 = imfilter(imagetemp, sobl');
hor2 = imfilter(imagetemp,-sobl);
ver2 = imfilter(imagetemp, -sobl');

%if 1 on grad, if 255x3 for peppershor,peppers ver, then blue for peppers

for i = 1:size(image,1)
    for j = 1:size(image,2)

            if hor1(i,j,1) >= 150 && hor1(i,j,2) <= 70 && hor1(i,j,3) <= 70
                image(i,j,:) = [0 255 0];
            end
            if ver1(i,j,1) >= 150 && ver1(i,j,2) <= 70 && ver1(i,j,3) <= 70
                image(i,j,:) = [0 255 0];
            end
            
            if hor2(i,j,1) >= 150 && hor2(i,j,2) <= 70 && hor2(i,j,3) <= 70
                image(i,j,:) = [0 255 0];
            end
            if ver2(i,j,1) >= 150 && ver2(i,j,2) <= 70 && ver2(i,j,3) <= 70
                image(i,j,:) = [0 255 0];
            end
    end
end

imshow(image);
imwrite(image, 'carz.jpg');