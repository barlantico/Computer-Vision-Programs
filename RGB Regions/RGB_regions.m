flo = imread('flowers.jpg');
imshow(flo);

for row = 1:size(flo,1)
    for col = 1:size(flo,2)
        if flo(row,col,1) < 60 || flo(row,col,2) > 90 || flo(row,col,3) > 90
            grey = 0.21 * flo(row,col,1) + 0.72 * flo(row,col,2) + 0.07 * flow(row,col,3);
            flo(row,col,1) = grey;
            flo(row,col,2) = grey;
            flo(row,col,3) = grey;
        end
    end
end
imshow(flo);

imwrite(flo,'gflo.jpg');