% At cutoff freq, it is 0.607 of its maximum value. 
function H = gaussian_lpf(h,w,thresh)
    H = ones(h,w);
    for x=1:h
        for y=1:w
            dist = sqrt((h/2-x)^2+(w/2-y)^2);
            D = dist;                       %just for the sake of notation
            D0 = thresh;                    %just for the sake of notation
            H(x,y) = 1-exp(-(D^2)/(2*(D0^2)));
        end
    end
end
