A=imread('gtr.jpg');

k = 3; %integer to increase size by

% define new image dimensions
Row = k*size(A,1);
Col = k*size(A,2);

%interpolated rows/cols to new image size
interpRow = zeros(1,Row);
interpCol = zeros(1,Col);

%Row/Col ratio correlating to original image.
for i=1:Row
    interpRow(i) = ceil(i/k);
end

for i=1:Col
    interpCol(i) = ceil(i/k);
end

%matrices for RGB bands
Red = zeros(Row,Col);
Green = zeros(Row,Col);
Blue = zeros(Row,Col);

%RED BAND
Temp= A(:,:,1);


for i=1:Row
    for j=1:size(A,2)
        Red(i,j) = Temp(interpRow(i),j);
    end
end

%temp matrix so we don't manipulate the row interpolations values
Temp = Red;
for i=1:Row
    for j=1:Col   
        Red(i,j) = Temp(i,interpCol(j));
    end
end


%GREEN BAND
Temp= A(:,:,2);

for i=1:Row
    for j=1:size(A,2)
        Green(i,j) = Temp(interpRow(i),j);
    end
end

Temp = Green;
for i=1:Row
    for j=1:Col   
        Green(i,j) = Temp(i,interpCol(j));
    end
end


%BLUE BAND
Temp = A(:,:,3);

for i=1:Row
    for j=1:size(A,2)
        Blue(i,j) = Temp(interpRow(i),j);
    end
end


Temp = Blue;
for i=1:Row
    for j=1:Col   
        Blue(i,j) = Temp(i,interpCol(j));
    end
end


%Setting the bands of each color to the overall image matrix
newImage=zeros([Row,Col,3]);
newImage(:,:,1)=Red;
newImage(:,:,2)=Green;
newImage(:,:,3)=Blue;

%casting to unsigned 8bit integer
newImage = uint8(newImage);

figure, imshow(A);
figure, imshow(newImage);

%save image
imwrite(newImage,"gtr3.jpg");

