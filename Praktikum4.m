% Praktikum 4
% Pergeseran citra

F = imread('D:\Tugas Cooding\image\image\kece.jpg');
if size(F, 3) == 3
    F = rgb2gray(F); % Ubah ke grayscale jika gambar RGB
end

[tinggi, lebar] = size(F);

% Translasi
sx = 45; % Penggeseran arah horizontal
sy = -35; % Penggeseran arah vertikal
F2 = double(F);
G = zeros(size(F2));
for y = 1 : tinggi
    for x = 1 : lebar
        xlama = x - sx;
        ylama = y - sy;
        if (xlama >= 1) && (xlama <= lebar) && ...
           (ylama >= 1) && (ylama <= tinggi)
            G(y, x) = F2(ylama, xlama);
        else
            G(y, x) = 0;
        end
    end
end

G = uint8(G);

% Tampilkan gambar asli dan hasil translasi
figure;
subplot(2,2,1);
imshow(F);
title('Gambar Asli');

subplot(2,2,2);
imshow(G);
title('Gambar Setelah Translasi');

% Histogram gambar asli dan hasil translasi
subplot(2,2,3);
imhist(F);
title('Histogram Gambar Asli');

subplot(2,2,4);
imhist(G);
title('Histogram Gambar Setelah Translasi');


