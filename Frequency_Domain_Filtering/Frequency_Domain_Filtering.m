[u,v]=meshgrid(-216:215, -218:217);
BWLPFiler=1./(1+((u.^2 + v.^2)/1300).^6); 


Pic=imread('p3.PNG');
figure, imshow(Pic);
Picfft=fftshift(fft2(Pic));%taking fft of filter
FilteredPicfft=Picfft.*BWLPFiler;%applyfing freq domain filter
figure, imshow(mat2gray(log(1+abs(Picfft)))); %freq domain before filter
figure, imshow(mat2gray(log(1+abs(FilteredPicfft)))); %freq domain after 
InverseFilteredPicfft=ifft2(FilteredPicfft); %Inverse of filtered freq
figure, imshow(mat2gray(abs(InverseFilteredPicfft))); %Filtered image
