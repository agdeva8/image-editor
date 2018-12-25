close all; clear all; clc;

[fname pthname]=uigetfile('*.jpg;*.png;*.tif;*.pgm;*bmp','Select the Asset Image');
im_asset=imread([pthname fname]);

%im_asset = imread('lena.pgm');

im_asset=im_asset(:,:,1);
[r,c]=size(im_asset);

D_imAsset=dct2(im_asset);

%putting all DCT values in a vector
D_imAssetVec=reshape(D_imAsset,1,r*c);

% taking the absolute values and arranging them in descending order to find
% the first n largerst.
[D_imAssetSort,idx]=sort(abs(D_imAssetVec),'descend');

wm_size = uint16(r/10)*uint16(c/10);
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

[fname pthname]=uigetfile('*.jpg;*.png;*.tif;*.pgm;*bmp','Select the watermarked Image');
im_wm=imread([pthname fname]);

%im_wm = imread('waterMarked_image.bmp');
D_wm = dct2(im_wm);

W2=[];
for k=1:wm_size
    W2(1,k) = (D_wm(rc(k,1), rc(k,2)) - D_imAsset(rc(k,1), rc(k,2)))/(D_imAsset(rc(k,1),rc(k,2))*0.001);
end

W2 = uint8(W2);

% only for comparision purpose i am importing the original data file here;
[fname pthname]=uigetfile('*.jpg;*.png;*.tif;*.pgm;*bmp','Select the original data Image');
wm_im=imread([pthname fname]);

%wm_im = imread('house2.jpg');
wm_im = wm_im(:,:,1);

% resizing the watermarking image: 
wm_im2 = imresize(wm_im, [uint16(r/10), uint16(c/10)]);  %height,widht
[rw,cw] = size(wm_im2);

subplot(1,2,1);
imshow(wm_im2);
title("original data image");

subplot(1,2,2);
W3 = reshape(W2,rw,cw);
imshow(W3);
title("extracted data");