%At cutoff frequency H = 0.5 i.e 50% of its maximum value of 1
function H = butterworth_lpf(h,w,thresh,n)
    H = ones(h,w);
    for x=1:h
        for y=1:w
            dist = sqrt((h/2-x)^2+(w/2-y)^2);
            D = dist;                       %just for the sake of notation
            D0 = thresh;                    %just for the sake of notation
            H(x,y) = 1/(1+(D/D0)^(2*n));
        end
    end
end
