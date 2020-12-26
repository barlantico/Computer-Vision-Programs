image1 = imread("Image1.jpg");
image2 = imread("Image2.jpg");

maxGreen =0;
maxPink = 0;

%CONSTANTS
pixelCar = 196.52;
carHeightFt = 4.4167;
carCalibConstant = carHeightFt / pixelCar;
timeFrame = 3; %seconds



fusedImage = imfuse(image1,image2);

cropped = zeros(191,2100,3); 



for i = 350:541
    for j = 1:size(cropped,2)
        cropped(i-349,j,:) = fusedImage(i,j,:);
    end
end

croppedimage = uint8(cropped);
%LOOPS TO CHECK FOR MAXGREEN AND MAXPINK
for i = 1:size(croppedimage,1)
    for j = 1:size(croppedimage,2)
        if croppedimage(i,j,1) >= 30 && croppedimage(i,j,1) <= 40
            if croppedimage(i,j,2) >= 200 && croppedimage(i,j,2) <= 210
                if croppedimage(i,j,3)>= 30 && croppedimage(i,j,3) <= 40
                    if j > maxGreen
                        maxGreen = j;
                    end
                end
            end
        end
    end
end

for i = 1:size(croppedimage,1)
    for j = 1:size(croppedimage,2)
        if croppedimage(i,j,1) >= 200 && croppedimage(i,j,1) <= 205
            if croppedimage(i,j,2) >= 20 && croppedimage(i,j,2) <= 25
                if croppedimage(i,j,3)>= 200 && croppedimage(i,j,3) <= 205
                    if j > maxPink
                        maxPink = j;
                    end
                end
            end
        end
    end
end


pixelsTraveled = maxPink - maxGreen;
distFt = pixelsTraveled * carCalibConstant;
mph = (distFt*3600)/(5280*3);

fprintf("The distance traveled is %f ft\n", distFt);
fprintf("The speed traveled is %f mph\n", mph);
