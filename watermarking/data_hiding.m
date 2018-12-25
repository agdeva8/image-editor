close all; clear all; clc;

[fname pthname]=uigetfile('*.jpg;*.png;*.tif;*.pgm;*bmp','Select the Asset Image'); %select image
im_asset=imread([pthname fname]);

%im_asset = imread('lena.pgm');

im_asset=im_asset(:,:,1);
[r,c]=size(im_asset);

D_imAsset=dct2(im_asset);

%putting all DCT values in a vector
D_imAssetVec=reshape(D_imAsset,1,r*c);

[fname pthname]=uigetfile('*.jpg;*.png;*.tif;*.pgm;*bmp','Select the data Image'); %select image
wm_im=imread([pthname fname]);

%wm_im = imread('house2.jpg');
wm_im = wm_im(:,:,1);

% resizing the watermarking image: 
wm_im2 = imresize(wm_im, [uint16(r/10), uint16(c/10)]);  %height,widht
[rw,cw] = size(wm_im2);

W = reshape(wm_im2,1,rw*cw);
wm_size=rw*cw;

% taking the absolute values and arranging them in descending order to find
% the first n largerst.
[D_imAssetSort,idx]=sort(abs(D_imAssetVec),'descend');

%choosing wm_size biggest values other than the first value 
idx2=idx(2:wm_size+1);

%finding associated row-column order for vector values
rc=zeros(wm_size,2);
for k=1:wm_size
    x=floor(idx2(k)/r)+1;
    y=mod(idx2(k),r);                   % mod means modulus (%);
    rc(k,1)=y;
    rc(k,2)=x;
end


D_wm=D_imAsset;

% taking it to values 0 to 1;
W2 = double(W)*0.001;

%insert the WM signal into the DCT values
for k=1:wm_size
    D_wm(rc(k,1),rc(k,2))=D_wm(rc(k,1),rc(k,2))+(D_wm(rc(k,1),rc(k,2))*W2(k));
end

im_final=uint8(idct2(D_wm));

imwrite(im_final,'waterMarked_image.bmp' , 'bmp');

figure(1);
subplot(1,2,1)
imshow(im_asset);
title("real asset image");

subplot(1,2,2);
imshow(im_final);
title("watermarked image");

figure(2);
%subplot(1,2,1);
imshow(wm_im2);
title("data to be hidden");