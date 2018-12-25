function H2 = help_plotH(H)
[h,w] = size(H);
H2 = zeros(uint8(h/10),uint8(w/10));
for i=1:10:h
    for j=1:10:w
         H2(uint8(i/10+1),uint8(j/10+1)) = H(i,j);
    end
end
end
