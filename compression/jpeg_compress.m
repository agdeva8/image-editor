% clearing the init
function [overall_seq,len] = jpeg_compress(im_orig, file_name, quality)

    zig_zag_ind = reshape(1:64, [8 8]);
    zig_zag_ind = fliplr( spdiags( fliplr(zig_zag_ind) ) );     %# get the anti-diagonals
    zig_zag_ind(:,1:2:end) = flipud( zig_zag_ind(:,1:2:end) );  %# reverse order of odd columns
    zig_zag_ind(zig_zag_ind==0) = [];

%     im_orig = imread('peppers.png');

    I = im_orig(:,:);

    [row coln]= size(I);
    I= double(I);

    I = I - (128*ones(row,coln));

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
     
    overall_seq = [];
    len = 0;
    for i1=[1:8:row]
        for i2=[1:8:coln]
            block=I(i1:i1+7,i2:i2+7);

            dct_block = dct2(block);
            dct_quantized_block = round(dct_block./QX);

            zig_zagged = dct_quantized_block(zig_zag_ind);

            new_seq = [];
            i = 1;
            while i <= 64
                if zig_zagged(i) ~= 0
                    new_seq = [new_seq zig_zagged(i)];
                     i = i + 1;
                else
                    new_seq = [new_seq 0];
                    count = 0;
                    while(i<=64 && zig_zagged(i) == 0)
                        count = count + 1;
                        i = i+1;
                    end
                    new_seq = [new_seq count];
                end
            end

            new_seq = [length(new_seq) new_seq];
            overall_seq = [overall_seq new_seq];
            length(new_seq);
            len = len + length(new_seq);      
        end
    end


    save(file_name,'overall_seq','row','coln','quality');
    % figure(1);imshow(im_orig);title('original image');
end

