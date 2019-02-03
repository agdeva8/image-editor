clear all; close all; clc;

% im_orig = imread('lena.jpeg');
[fname pthname]=uigetfile('*.jpg;*.png;*.tif;*.pgm;*bmp','Select the Asset Image'); %select image

im_orig = imread([pthname fname]);

quality = [50];

lq = length(quality);

for qi = 1:lq
    [row1 coln1 channels] = size(im_orig);

    row = floor(row1/8)*8;
    coln = floor(coln1/8)*8;

    I = zeros(row,coln,channels);
    I = im_orig(1:row,1:coln,:);
    
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