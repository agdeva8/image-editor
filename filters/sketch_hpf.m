function im3 = sketch_hpf(im,mono_thresh)
    [h,w] = size(im);
    im2 = 255-im;
    for i=1:h
        for j=1:w
            if im2(i,j)>mono_thresh
                im3(i,j) = 255;
            else
                im3(i,j) = 0;
            end
        end
    end
hAxes = axes(figure);
hImage = imshow( im3, 'Parent', hAxes );
title( hAxes, 'sketch of the original image' );
end
