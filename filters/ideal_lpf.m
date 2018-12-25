function H = ideal_lpf(h,w,thresh)
    H = ones(h,w);
    for x=1:h
        for y=1:w
            dist = sqrt((h/2-x)^2+(w/2-y)^2);
            if dist>thresh
                H(x,y) = 0;
            end
        end
    end
end
