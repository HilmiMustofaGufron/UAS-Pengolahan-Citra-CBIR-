%UTS Pengolahan Citra
% 1.a.	Hasil pengerjaan di octave mengenai citra biner, grayscale, rgb
% Membaca dan menampilkan citra RGB
img_rgb = imread('D:\Tugas Cooding\image\image\kece.jpg');
figure, imshow(img_rgb), title('Citra RGB');

red_channel = img_rgb(:, :, 1);
green_channel = img_rgb(:, :, 2);
blue_channel = img_rgb(:, :, 3);

figure, imshow(red_channel), title('Channel Merah');
figure, imshow(green_channel), title('Channel Hijau');
figure, imshow(blue_channel), title('Channel Biru');

% Mengubah citra RGB ke grayscale
img_gray = rgb2gray(img_rgb);
figure, imshow(img_gray), title('Citra Grayscale');

imwrite(img_gray, 'gambar_grayscale.jpg');

% Mengubah citra grayscale ke biner
threshold = 0.5;
img_binary = img_gray > threshold * 255;

figure, imshow(img_binary), title('Citra Biner');

imwrite(uint8(img_binary) * 255, 'gambar_biner.jpg');


% 2.a.	Hasil kuantisasi
% Membaca citra grayscale
img_gray = imread('D:\Tugas Cooding\image\image\kece.jpg');
if size(img_gray, 3) == 3
  img_gray = rgb2gray(img_gray);
endif

pkg load image

img_double = double(img_gray);

% Fungsi kuantisasi
function img_quant = quantize_gray(img, levels)
  step = 256 / levels;
  img_quant = floor(img / step) * step;
  img_quant = uint8(img_quant);
endfunction

% Kuantisasi ke 2, 4, dan 8 tingkat keabuan
img_q2 = quantize_gray(img_double, 2);
img_q4 = quantize_gray(img_double, 4);
img_q8 = quantize_gray(img_double, 8);

% Tampilkan hasil
figure, imshow(img_q2), title('Kuantisasi 2 Tingkat');
figure, imshow(img_q4), title('Kuantisasi 4 Tingkat');
figure, imshow(img_q8), title('Kuantisasi 8 Tingkat');

imwrite(img_q2, 'quant_2.jpg');
imwrite(img_q4, 'quant_4.jpg');
imwrite(img_q8, 'quant_8.jpg');

% 3.a.	Tingkat kecerahan citra dengan penyesuaian nilai piksel
% 3.b.	Tamppilkan histogram sebelum sesudah
% Baca citra grayscale
img = imread('D:\Tugas Cooding\image\image\gelap.jpg');
if size(img, 3) == 3
  img = rgb2gray(img);
endif

img_double = double(img);

% Penyesuaian kecerahan
brightness_offset = 50;  % positif = terang, negatif = gelap

img_bright = img_double + brightness_offset;
img_bright = max(min(img_bright, 255), 0);

img_bright = uint8(img_bright);

% Tampilkan citra asli dan hasil penyesuaian
figure, imshow(img), title('Citra Asli');
figure, imshow(img_bright), title('Citra Setelah Penyesuaian Kecerahan');

% Tampilkan histogram sebelum dan sesudah
figure,
subplot(1, 2, 1), imhist(img), title('Histogram Asli');
subplot(1, 2, 2), imhist(img_bright), title('Histogram Setelah Penyesuaian');

imwrite(img_bright, 'gambar_terang.jpg');


% 4.a.	Tampilkan citra sebelum dan sesudah
% Baca citra wajah
img = imread('D:\Tugas Cooding\image\image\kaji.jpg');
if size(img, 3) == 3
  img = rgb2gray(img);
endif

% Lakukan ekualisasi histogram
img_eq = histeq(img);

figure(1);
imshow(img);
title('Citra Asli');

figure(2);
imshow(img_eq);
title('Citra Setelah Ekualisasi Histogram');

imwrite(img_eq, 'wajah_ekualisasi.jpg');


% 5.a.	Terapkan filter median menggunakan kernel 3x3
% 5.b.	Bandingkan hasil dengan filter mean
% Baca gambar
img = imread('D:\Tugas Cooding\image\image\scoopy.jpg');

if size(img, 3) == 3
  img = rgb2gray(img);
endif

% Terapkan filter median 3x3
img_median = medfilt2(img, [3 3]);

% Tampilkan hasil
figure(1);
imshow(img);
title('Citra Asli');

figure(2);
imshow(img_median);
title('Citra Setelah Filter Median 3x3');

imwrite(img_median, 'gambar_median.jpg');

%filter mean
% Baca gambar
img = imread('D:\Tugas Cooding\image\image\scoopy.jpg');

if size(img, 3) == 3
  img = rgb2gray(img);
endif

% kernel mean 3x3
kernel = ones(3, 3) / 9;

% filter mean menggunakan konvolusi 2D
img_mean = imfilter(img, kernel, 'replicate');

% Tampilkan hasil
figure(1);
imshow(img);
title('Citra Asli');

figure(2);
imshow(img_mean);
title('Citra Setelah Filter Mean 3x3');

imwrite(img_mean, 'gambar_mean.jpg');


% 6.a.	Terapkan fikter high-boost
% 6.b.	Tampilkan sebelum sesudah
% Baca citra grayscale
img = imread('D:\Tugas Cooding\image\image\tekstur.jpg');
if size(img, 3) == 3
  img = rgb2gray(img);
endif
img = im2double(img);

% Blur citra dengan filter rata-rata 3x3
kernel = ones(3, 3) / 9;
img_blur = imfilter(img, kernel, 'replicate');

% Hitung mask high-pass
mask = img - img_blur;

% Faktor penguatan k
k = 1.5;

% Filter High Boost
img_highboost = img + k * mask;
img_highboost = max(min(img_highboost, 1), 0); % Normalisasi ke [0,1]

% Tampilkan hasil di 3 figure
figure(1);
imshow(img);
title('Figure 1: Citra Asli');

figure(2);
imshow(img_blur);
title('Figure 2: Citra Blur (Low-pass)');

figure(3);
imshow(img_highboost);
title('Figure 3: Citra High Boost');


% 7.a.	Rotasikan gambar agar tegak lurus dengan interpolasi bilinear.
pkg load image;  % Pastikan package image aktif

% Baca gambar
img = imread('D:\Tugas Cooding\image\image\poster.jpg');  % Pastikan file ini ada di folder yang sama

% Ubah ke grayscale jika berwarna
if ndims(img) == 3
  img_gray = rgb2gray(img);
else
  img_gray = img;
endif

% Rotasi bilinear -15 derajat
sudut_rotasi = -15;
img_rotated = imrotate(img_gray, sudut_rotasi, 'bilinear', 'crop');

% Perbesar gambar 2x
scale_factor = 2.0;
img_scaled = imresize(img_rotated, scale_factor, 'bilinear');

% Tampilkan hasil
figure(1); imshow(img_gray); title('Citra Asli');
figure(2); imshow(img_rotated); title('Setelah Rotasi Bilinear');
figure(3); imshow(img_scaled); title('Setelah Diperbesar');


% 7.b.	Perbesar citra agar teks mudah dibaca

% 8.a.	Bandingkan dengan citra aslinya.
% Baca dan ubah ke grayscale
img = imread('D:/Tugas Cooding/image/image/kucing.jpg');
if size(img,3) == 3
  img = rgb2gray(img);
endif
img = im2double(img);

% Ukuran gambar
[rows, cols] = size(img);
cx = cols / 2;
cy = rows / 2;
R = min(cx, cy); % radius maksimum
k = 5;           % kekuatan pusaran

% Buat grid koordinat
[x, y] = meshgrid(1:cols, 1:rows);
dx = x - cx;
dy = y - cy;
r = sqrt(dx.^2 + dy.^2);
theta = atan2(dy, dx) + k * (1 - r/R); % tambah rotasi sesuai jarak dari pusat

% Koordinat baru
x_new = cx + r .* cos(theta);
y_new = cy + r .* sin(theta);

% Interpolasi bilinear manual
twirl_img = interp2(x, y, img, x_new, y_new, 'linear', 0);

% Tampilkan hasil
figure, imshow(img), title('Citra Asli');
figure, imshow(twirl_img), title('Efek Twirl');

% Gunakan kembali img dari atas

% Parameter ripple
A = 10;    % amplitudo
T = 40;    % panjang gelombang

[x, y] = meshgrid(1:cols, 1:rows);
x_new = x + A * sin(2 * pi * y / T);
y_new = y;

ripple_img = interp2(x, y, img, x_new, y_new, 'linear', 0);

% Tampilkan hasil
figure, imshow(ripple_img), title('Efek Ripple Horizontal');

% 9.a.	Terapkan filter Gaussian untuk mengaburkan citra.
% Baca citra grayscale
img = imread('D:/Tugas Cooding/image/image/parkiran.jpg');
if size(img, 3) == 3
  img = rgb2gray(img);
endif
img = im2double(img);

% Buat filter Gaussian 5x5 dengan sigma = 1
sigma = 1;
kernel_size = 5;
[x, y] = meshgrid(-floor(kernel_size/2):floor(kernel_size/2));
gauss_kernel = exp(-(x.^2 + y.^2) / (2 * sigma^2));
gauss_kernel = gauss_kernel / sum(gauss_kernel(:)); % Normalisasi

% Terapkan filter Gaussian
img_gauss = imfilter(img, gauss_kernel, 'replicate');

% Tampilkan hasil
figure, imshow(img), title('Citra Asli');
figure, imshow(img_gauss), title('Citra Setelah Gaussian Filter');

% 10.a.	Tampilkan hasil transformasi.
pkg load image;

% Baca gambar
img = imread('D:/Tugas Cooding/image/image/rumah.jpg');
if size(img,3) == 3
  img = rgb2gray(img);
endif
img = im2double(img);

% Ukuran gambar
[rows, cols] = size(img);

% Buat grid koordinat
[x, y] = meshgrid(1:cols, 1:rows);

% Titik pusat (untuk rotasi/scaling)
cx = cols / 2;
cy = rows / 2;

% Parameter transformasi
theta = pi/6; % rotasi 30 derajat
s = 1.2;      % skala
shx = 0.2;    % shear horizontal

% Matriks transformasi affine manual
T = [s*cos(theta), -sin(theta)+shx;
     sin(theta), s*cos(theta)];

% Koordinat relatif terhadap pusat
dx = x - cx;
dy = y - cy;

% Hitung koordinat baru
xy_new = T * [dx(:)'; dy(:)'];
x_new = reshape(xy_new(1,:) + cx, size(x));
y_new = reshape(xy_new(2,:) + cy, size(y));

% Interpolasi
img_affine = interp2(x, y, img, x_new, y_new, 'linear', 0);

% Tampilkan
figure, imshow(img), title('Citra Asli');
figure, imshow(img_affine), title('Transformasi Affine');


