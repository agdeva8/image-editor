clear all; close all; clc;

% im_orig = imread('lena.jpeg');
[fname pthname]=uigetfile('*.jpg;*.png;*.tif;*.pgm;*bmp','Select the Asset Image'); %select image

im_orig = imread([pthname fname]);

quality = [50];

lq = length(quality);

for qi = 1:lq
    [row coln channels] = size(im_orig);

    row = ceil(row/8)*8;
    coln = ceil(coln/8)*8;

    I = im_orig(row,coln,channels);
    I(1:row,1:coln,1:channels) = im_orig;


    total_new_len = 0;
    for ch_itr = 1:channels
        file_name = 'compressed_image_'+string(ch_itr)+'.mat';
        [overall_seq len] = jpeg_compress(I(:,:,ch_itr),file_name,quality(qi));
        total_new_len = total_new_len + len;
    end

    disp('overall compressed percent (quality = ' + string(quality(qi)) + ') = ');
    disp((row*coln*channels-total_new_len)/(row*coln*channels)*100);

    % decompressing the image:
    restored_image = zeros(row,coln,channels);

    for ch_itr = 1:channels
        file_name = 'compressed_image_'+string(ch_itr)+'.mat';
        restored_image(:,:,ch_itr) = jpeg_decompress(file_name);
    end

    subplot(lq,2,2*qi-1);
    imshow(I);
    title('original image');

    subplot(lq,2,2*qi);
    imshow(restored_image);
    title('restored image (quality = ' + string(quality(qi)));
end