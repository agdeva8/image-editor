% making visible watermarking

% clearing the init
clear all; close all; clc;

% reading the asset image:
[fname pthname]=uigetfile('*.jpg;*.png;*.tif;*.pgm;*bmp','Select the asset Image'); %select image
im_ast=imread([pthname fname]);

%im_ast = imread('lena.pgm');        %ast = asset
[m_ast,n_ast] = size(im_ast);

% reading the watermarked(wmrk) image: 
[fname pthname]=uigetfile('*.jpg;*.png;*.tif;*.pgm;*bmp','Select the logo'); %select image
im_wmrk=imread([pthname fname]);


%im_wmrk = imread('deva.jpg');

im_wmrk = im_wmrk(:,:,1);
[m_wmrk,n_wmrk] = size(im_wmrk);

figure(1);
imshow(im_ast);
title("asset image");

figure(2);
imshow(im_wmrk);
title("image for watermarking");

disp("the size of watermarking image is " + m_wmrk +" x " + n_wmrk);
% select the rectangle where the image is to be watermarked;

disp("select the rectangle in which you have to watermark the image");
% rect = [ymin, xmin, width, height]
rect = getrect(figure(1));
rec_x1 = uint16(rect(2));               rec_y1 = uint16(rect(1));
rec_x2 = uint16(rect(2) + rect(4)-1);   rec_y2 = uint16(rect(1) + rect(3)-1);

% resizing the watermarking image: 
im_wmrk2 = imresize(im_wmrk, [uint16(rect(4)),uint16(rect(3))]);  %height,widht


% according to the selected rectangle watermark the image;
transperancy_level = input('select the transperancy level (from 0 to 1) ');
alpha = 1-transperancy_level;
disp("the transperancy coefficient is " + alpha);

im_final = im_ast;
for i=rec_x1:rec_x2
    for j=rec_y1:rec_y2
        pxl_add = im_wmrk2(i-rec_x1+1,j-rec_y1+1);
        
        % removing the white background so as to make it look more classy
        if(pxl_add ~= 255)
            im_final(i, j) = im_final(i,j) + alpha*pxl_add;
        end
    end
end

%im_final(rec_x1:rec_x2, rec_y1:rec_y2) = im_final(rec_x1:rec_x2, rec_y1:rec_y2) + alpha.*im_wmrk2;


% just for lame cheking;
%im_ast2 = im_ast;
%im_ast2(1:m_wmrk,1:n_wmrk) = im_ast2(1:m_wmrk,1:n_wmrk) + (0.1).*im_wmrk;

figure(3)
imshow(im_wmrk2);
title("resized image according to selected is ");

figure(4);
imshow(im_final);
title('watermarked image');

