function K = jpeg_decompress(file_name)
    
    load(file_name);

    zig_zag_ind = reshape(1:64, [8 8]);
    zig_zag_ind = fliplr( spdiags( fliplr(zig_zag_ind) ) );     %# get the anti-diagonals
    zig_zag_ind(:,1:2:end) = flipud( zig_zag_ind(:,1:2:end) );  %# reverse order of odd columns
    zig_zag_ind(zig_zag_ind==0) = [];


    Q50 = [ 16 11 10 16 24 40 51 61;
         12 12 14 19 26 58 60 55;
         14 13 16 24 40 57 69 56;
         14 17 22 29 51 87 80 62; 
         18 22 37 56 68 109 103 77;
         24 35 55 64 81 104 113 92;
         49 64 78 87 103 121 120 101;
         72 92 95 98 112 100 103 99];
     
    if quality > 50
         QX = round(Q50.*(ones(8)*((100-quality)/50)));
         QX = double(QX);
     elseif quality < 50
         QX = round(Q50.*(ones(8)*(50/quality)));
         QX = double(QX);
     elseif quality == 50
         QX = Q50;
     end

    % 
    % row = 384;
    % coln = 512;

    dct_quantized = zeros(row,coln);
    len_overall = length(overall_seq);

    i1 = 1;
    i2 = 1;

    k = 1;
    while k <= len_overall
        new_seq = overall_seq(k+1:k+overall_seq(k));

        orig_seq = zeros(1,64);

        i = 1;
        j = 1;
        while i <= 64
            if(new_seq(j) ~= 0)
                orig_seq(i) = new_seq(j);
                i = i + 1;
                j = j + 1;
            else
                i = i + new_seq(j+1);
                j = j + 2;
            end
        end

        orig_block = zeros(8);

        for i = 1:64
            orig_block(zig_zag_ind(i)) = orig_seq(i);
        end

        dct_quantized(i1:i1+7,i2:i2+7) = orig_block;
        if i2 > coln-8
            i2 = 1;
            i1 = i1+8;
        else
            i2 = i2 + 8;
        end
        k = k+overall_seq(k)+1;
    end



    for i1=[1:8:row]
        for i2=[1:8:coln]
            quantised_block = dct_quantized(i1:i1+7,i2:i2+7);
            dct_block = quantised_block.*QX;        
            orig_block = idct2(dct_block);
            dct_restored(i1:i1+7,i2:i2+7)=orig_block;
        end
    end

    I2=dct_restored;

    K=mat2gray(I2);

%     imshow(K);
end