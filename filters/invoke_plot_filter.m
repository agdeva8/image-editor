function im_filtered = invoke_plot_filter(H,im_centered,x,y,z1,z2,per_thresh)
    im_filtered = filter_image(H,im_centered);  
    subplot(x,y,z1);
    imshow(im_filtered); title("thresh = "+string(per_thresh)+"%");
    subplot(x,y,z2);
    surf(help_plotH(H)); title("thresh = " + string(per_thresh)+"%");
end