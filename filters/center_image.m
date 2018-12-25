% centring the image:
function im_centered = center_image(im);
[h,w] = size(im);
im_centered=zeros(h,w);
for x=1:h
    for y=1:w
        im_centered(x,y) = im(x,y);
        im_centered(x,y) = im_centered(x,y)*((-1)^(x+y));
    end
end
end
