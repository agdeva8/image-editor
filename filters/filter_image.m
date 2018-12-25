function im_filtered = filter_image(H,im_centered)
[h,w] = size(im_centered);
max_freq = sqrt((h/2)^2+(w/2)^2);

% computing the DFT of image:
im_fft = fft2(im_centered);

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
end
