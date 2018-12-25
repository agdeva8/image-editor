function im_filtered = invoke_plot_order(H,im_centered,x,y,z1,z2,n)
    im_filtered = filter_image(H,im_centered);  
    subplot(x,y,z1);
    imshow(im_filtered); title("order = "+string(n));
    subplot(x,y,z2);
    surf(help_plotH(H)); title("order = " + string(n));
end
