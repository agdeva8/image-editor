% This is do to the filtering at frequency domain:

% clearing the init
clear all; close all; clc;

% importing the image.. 
% take function from tushar after completing

im = imread('/home/deva/Downloads/SampleJPGImage_500kbmb.jpg');
[h,w,dim] = size(im); 

% centring the image:
im_centered=zeros(h,w,dim);
for x=1:h
    for y=1:w
        for i=1:3;
            im_centered(x,y,i) = im(x,y,i);
            im_centered(x,y,i) = im_centered(x,y,i)*((-1)^(h-x+w-y+2));
        end
    end
end

% computing the DFT of image:
im_fft = fftn(im_centered);

% building the filter function: H(u,v);
% making the average value of image to be 0;
H = ones(h,w,dim);
H(h/2,w/2,:) = 0;

% multiplying transformed image with H;
HxF = H.*im_fft;

% taking the inverse transform;
im_invFFt = ifft(HxF);

% obtaining the real part of inverse fft:
im_real_invFFt = int8(real(im_invFFt));

% getting back to the original position from center;
im_filtered = zeros(h,w,dim);
for x=1:h
    for y=1:w
        for i=1:3
            im_filtered(x,y,i) = abs(im_real_invFFt(x,y,i));
        end
    end
end
im_filtered = uint8(im_filtered);

