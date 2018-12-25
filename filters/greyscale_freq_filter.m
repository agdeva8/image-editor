% This is do to the filtering at frequency domain:

% clearing the init
clear all; close all; clc;

% importing the image.. 
% take function from tushar after completing

im = imread('lena.pgm');
[h,w] = size(im); 

% centring the image:
im_centered=zeros(h,w);
for x=1:h
    for y=1:w
        im_centered(x,y) = im(x,y);
        im_centered(x,y) = im_centered(x,y)*((-1)^(x+y));
    end
end

% computing the DFT of image:
im_fft = fft2(im_centered);

% building the filter function: H(u,v);
% making the average value of image to be 0;
%H = ones(h,w);
%H(h/2,w/2) = 0;

percent_thresh = 1;
max_freq = sqrt((h/2)^2+(w/2)^2);

% disp("max freq cell distance is "+max_freq);
% % per_thresh means after this values frequency will be zero..
% % per_thresh = 15;
% % n = 2;
% % thresh = (per_thresh/100)*max_freq;
% disp("thresh value is " + thresh);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% low pass filters %%%%%%%%%%%%%%%%%%%%%%%%%%%

% building the ideal low pass filter;
% per_thresh = 9.5
% thresh = (per_thresh/100)*max_freq;
% H = ideal_lpf(h,w,thresh);

% for the butterworth low pass filter;
% per_thresh = 20;
% thresh = (per_thresh/100)*max_freq;
% n = 2;
% H = butterworth_lpf(h,w,thresh,n);

% for the gaussian low pass filter:
per_thresh = 20;
thresh = (per_thresh/100)*max_freq;
H = gaussian_lpf(h,w,thresh);

%%%%%%%%%%%%%%%%%%%%%%%%%%% high pass filters %%%%%%%%%%%%%%%%%%%%%%%%%%%

% building the ideal high pass filter;
% per_thresh = 10;
% thresh = (per_thresh/100)*max_freq;
% H = ideal_hpf(h,w,thresh);

% for the gaussian high pass filter:
% per_thresh = 8;
% thresh = (per_thresh/100)*max_freq;
% H = gaussian_hpf(h,w,thresh);

% for the butterworth high pass filter;
% per_thresh = 8;
% thresh = (per_thresh/100)*max_freq;
% n = 2;
% H = butterworth_hpf(h,w,thresh,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% using the value of H %%%%%%%%%%%%%%%%%%%%%%%

disp("max freq cell distance is "+max_freq);
disp("thresh value is " + thresh);

% multiplying transformed image with H;
%HxF = H.*im_fft;
for x=1:h
    for y=1:w
        HxF(x,y) = im_fft(x,y)*H(x,y);
    end
end

% taking the inverse transform;
im_invFFt = ifft2(HxF);

% getting back to the original position from center;
im_abs = zeros(h,w);
for x=1:h
    for y=1:w
            im_abs(x,y) = im_invFFt(x,y)*((-1)^(x+y));
    end
end
im_filtered = real(im_abs);
im_filtered = uint8(im_filtered);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% plotting the graphs %%%%%%%%%%%%%%%%%%%

disp("plotting the images..");
% plotting the graphs
subplot(1,2,1);
imshow(im);
title("original image");

subplot(1,2,2);
imshow(im_filtered);
title("filtered image");

figure(2);
surf(H);
title("plot of transformation function");

disp("plotting the sketch");
mono_thresh = 240;
disp("going for sketch");
sketch_hpf(im_filtered,mono_thresh);