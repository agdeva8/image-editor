% This is do to the filtering at frequency domain:

% clearing the init
clear all; close all; clc;

% importing the image.. 
% take function from tushar after completing

im = imread('lena.pgm');
[h,w] = size(im); 

% centring the image.
im_centered = center_image(im);
max_freq = sqrt((h/2)^2+(w/2)^2);

disp("going into filters ... ");

%%%%%%%%%%%%%%%%%%%%%%%%%%%% low pass filters %%%%%%%%%%%%%%%%%%%%%%%%%%%
disp("enter any key for ideal low pass filters ");
pause;

% building the IDEAL low pass filter;
figure(1);
% plotting original image: 
invoke_plot_filter(ones(h,w),im_centered,2,4,1,5,100);

per_thresh = 5; thresh = (per_thresh/100)*max_freq;
H = ideal_lpf(h,w,thresh); invoke_plot_filter(H,im_centered,2,4,2,6,per_thresh);

per_thresh = 10; thresh = (per_thresh/100)*max_freq;
H = ideal_lpf(h,w,thresh); invoke_plot_filter(H,im_centered,2,4,3,7,per_thresh);

per_thresh = 30; thresh = (per_thresh/100)*max_freq;
H = ideal_lpf(h,w,thresh); invoke_plot_filter(H,im_centered,2,4,4,8,per_thresh);

disp("enter any key to continue to butterworth low pass filters ");
pause;

% for the 	BUTTERWORTH low pass filter;
figure(2);
% plotting original image: 
invoke_plot_filter(ones(h,w),im_centered,2,4,1,5,100);

% first doing for different thresh;
n = 2;
per_thresh = 5; thresh = (per_thresh/100)*max_freq;
H = butterworth_lpf(h,w,thresh,n); invoke_plot_filter(H,im_centered,2,4,2,6,per_thresh);

n = 2;
per_thresh = 10; thresh = (per_thresh/100)*max_freq;
H = butterworth_lpf(h,w,thresh,n); invoke_plot_filter(H,im_centered,2,4,3,7,per_thresh);

n = 2;
per_thresh = 30; thresh = (per_thresh/100)*max_freq;
H = butterworth_lpf(h,w,thresh,n); invoke_plot_filter(H,im_centered,2,4,4,8,per_thresh);

% now changing the orders and keeping the per_thresh to be constant
figure(3);
% plotting original image: 
invoke_plot_order(ones(h,w),im_centered,2,4,1,5,0);

per_thresh = 10;
n=1 ; thresh = (per_thresh/100)*max_freq;
H = butterworth_lpf(h,w,thresh,n); invoke_plot_order(H,im_centered,2,4,2,6,n);

n = 2; thresh = (per_thresh/100)*max_freq;
H = butterworth_lpf(h,w,thresh,n); invoke_plot_order(H,im_centered,2,4,3,7,n);

n = 10; thresh = (per_thresh/100)*max_freq;
H = butterworth_lpf(h,w,thresh,n); invoke_plot_order(H,im_centered,2,4,4,8,n);

disp("enter any key to continue to gaussian low pass filters ");
pause;

% building the GAUSSIAN low pass filter;
figure(4);
% plotting original image: 
invoke_plot_filter(ones(h,w),im_centered,2,4,1,5,100);

per_thresh = 5; thresh = (per_thresh/100)*max_freq;
H = gaussian_lpf(h,w,thresh); invoke_plot_filter(H,im_centered,2,4,2,6,per_thresh);

per_thresh = 10; thresh = (per_thresh/100)*max_freq;
H = gaussian_lpf(h,w,thresh); invoke_plot_filter(H,im_centered,2,4,3,7,per_thresh);

per_thresh = 30; thresh = (per_thresh/100)*max_freq;
H = gaussian_lpf(h,w,thresh); invoke_plot_filter(H,im_centered,2,4,4,8,per_thresh);

% for the gaussian low pass filter:
% per_thresh = 20;
% H = gaussian_lpf(h,w,thresh);

disp("enter any key to compare all low pass filters ");
pause;

%%% putting best ones in one figure: 
figure(9);
subplot(2,2,1); imshow(im); title("original image");

per_thresh = 10; thresh = (per_thresh/100)*max_freq;
H = ideal_lpf(h,w,thresh);
im_filtered = filter_image(H,im_centered);
subplot(2,2,2); imshow(im_filtered); title("ideal low pass");

per_thresh = 10; thresh = (per_thresh/100)*max_freq;
n = 2;
H = butterworth_lpf(h,w,thresh,n);
im_filtered = filter_image(H,im_centered);
subplot(2,2,3); imshow(im_filtered); title("butterworth low pass");

per_thresh = 10; thresh = (per_thresh/100)*max_freq;
H = gaussian_lpf(h,w,thresh);
im_filtered = filter_image(H,im_centered);
subplot(2,2,4); imshow(im_filtered); title("gaussian low pass");


%%%%%%%%%%%%%%%%%%%%%%%%%% HIGH PASS FILTERS %%%%%%%%%%%%%%%%%%%%%%%%%%%
disp("enter any key to continue to ideal high pass filters ");
pause;

% building the IDEAL high pass filter;
figure(5);
% plotting original image: 
invoke_plot_filter(ones(h,w),im_centered,2,4,1,5,0);

per_thresh = 2; thresh = (per_thresh/100)*max_freq;
H = ideal_hpf(h,w,thresh); invoke_plot_filter(H,im_centered,2,4,2,6,per_thresh);

per_thresh = 4; thresh = (per_thresh/100)*max_freq;
H = ideal_hpf(h,w,thresh); invoke_plot_filter(H,im_centered,2,4,3,7,per_thresh);

per_thresh = 15; thresh = (per_thresh/100)*max_freq;
H = ideal_hpf(h,w,thresh); invoke_plot_filter(H,im_centered,2,4,4,8,per_thresh);

disp("enter any key to continue to butterworth high pass filters ");
pause;


% for the 	BUTTERWORTH high pass filter;
figure(6);
% plotting original image: 
invoke_plot_filter(ones(h,w),im_centered,2,4,1,5,0);

% first doing for different thresh;
n = 2;
per_thresh = 1; thresh = (per_thresh/100)*max_freq;
H = butterworth_hpf(h,w,thresh,n); invoke_plot_filter(H,im_centered,2,4,2,6,per_thresh);

n = 2;
per_thresh = 5; thresh = (per_thresh/100)*max_freq;
H = butterworth_hpf(h,w,thresh,n); invoke_plot_filter(H,im_centered,2,4,3,7,per_thresh);

n = 2;
per_thresh = 15; thresh = (per_thresh/100)*max_freq;
H = butterworth_hpf(h,w,thresh,n); invoke_plot_filter(H,im_centered,2,4,4,8,per_thresh);
% 
% now changing the orders and keeping the per_thresh to be constant
figure(7);
% plotting original image: 
invoke_plot_order(ones(h,w),im_centered,2,4,1,5,0);

per_thresh = 5;
n=1 ; thresh = (per_thresh/100)*max_freq;
H = butterworth_hpf(h,w,thresh,n); invoke_plot_order(H,im_centered,2,4,2,6,n);

n = 2; thresh = (per_thresh/100)*max_freq;
H = butterworth_hpf(h,w,thresh,n); invoke_plot_order(H,im_centered,2,4,3,7,n);

n = 10; thresh = (per_thresh/100)*max_freq;
H = butterworth_hpf(h,w,thresh,n); invoke_plot_order(H,im_centered,2,4,4,8,n);

disp("enter any key to continue to gaussian high pass filters ");
pause;


% building the GAUSSIAN high pass filter;
figure(8);
% plotting original image: 
invoke_plot_filter(ones(h,w),im_centered,2,4,1,5,100);

per_thresh = 1; thresh = (per_thresh/100)*max_freq;
H = gaussian_hpf(h,w,thresh); invoke_plot_filter(H,im_centered,2,4,2,6,per_thresh);

per_thresh = 4; thresh = (per_thresh/100)*max_freq;
H = gaussian_hpf(h,w,thresh); invoke_plot_filter(H,im_centered,2,4,3,7,per_thresh);

per_thresh = 12; thresh = (per_thresh/100)*max_freq;
H = gaussian_hpf(h,w,thresh); invoke_plot_filter(H,im_centered,2,4,4,8,per_thresh);

disp("enter any key to compare all high pass filters ");
pause;


%%% taking the best ones out in the single plot 
figure(10);
subplot(2,2,1); imshow(im); title("original image");

per_thresh = 4; thresh = (per_thresh/100)*max_freq;
H = ideal_hpf(h,w,thresh);
im_filtered = filter_image(H,im_centered);
subplot(2,2,2); imshow(im_filtered); title("ideal high pass");

per_thresh = 5; thresh = (per_thresh/100)*max_freq;
n = 2;
H = butterworth_hpf(h,w,thresh,n);
im_filtered = filter_image(H,im_centered);
subplot(2,2,3); imshow(im_filtered); title("butterworth high pass");

per_thresh = 4; thresh = (per_thresh/100)*max_freq;
H = gaussian_hpf(h,w,thresh);
im_filtered = filter_image(H,im_centered);
subplot(2,2,4); imshow(im_filtered); title("gaussian high pass");

disp("enter any key to sketch the image");
pause;


%%%%% nowing plotting the sketch for the gaussian high pass filter%%%%%%%
per_thresh = 7; thresh = (per_thresh/100)*max_freq;
H = gaussian_hpf(h,w,thresh);
im_filtered = filter_image(H,im_centered);
mono_thresh = 239;
sketch_hpf(im_filtered,mono_thresh);

%%% mapping figure numbers to their titles:
disp("figure 1  -------> ideal low pass filters");
disp("figure 2  -------> butterworth low pass filters (thresh variation");
disp("figure 3  -------> butterworth low pass filters (order variation");
disp("figure 4  -------> gaussian low pass filters");
disp("figure 5  -------> compare all low pass filters");
disp("figure 6  -------> ideal high pass filters");
disp("figure 7  -------> butterworth high pass filters (thresh variation");
disp("figure 8  -------> butterworth high pass filters (order variation");
disp("figure 9  -------> gaussian high pass filters");
disp("figure 10 -------> compare all high pass filters");
disp("figure 11 -------> sketch");


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% using the value of H %%%%%%%%%%%%%%%%%%%%%%%
% im_filtered = filter_image(thresh,H,im_centered);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% plotting the graphs %%%%%%%%%%%%%%%%%%%
% 
% disp("plotting the images..");
% % plotting the graphs
% subplot(1,2,1);
% imshow(im);
% title("original image");
% 
% subplot(1,2,2);
% imshow(im_filtered);
% title("filtered image");
% 
% figure(2);
% plotH(H);
% title("plot of transformation function");
% 
% disp("plotting the sketch");
% mono_thresh = 235;
% disp("going for sketch");
% sketch_hpf(im_filtered,mono_thresh);
