%Praktikum 2%
pkg load image;
%gambar asli%
img = imread('D:\Tugas Cooding\image\image\kece.jpg');
%1. Menampilkan histogram%
figure;
subplot(1,2,1), imshow(img), title('Gambar Asli');
subplot(1,2,2), imhist(rgb2gray(img)), title('Histogram Asli');

ray = rgb2gray(img);

subplot(2,2,1), imshow(img), title('Asli');
subplot(2,2,2), imhist(rgb2gray(img)), title('Hist. Asli');
subplot(2,2,3), imshow(gray), title('Grayscale');
subplot(2,2,4), imhist(gray), title('Hist. Grayscale');
%2. Meningkatkan kecerahan%
figure;
bright = img + 120;

subplot(2,2,1), imshow(img), title('Asli');
subplot(2,2,2), imhist(rgb2gray(img)), title('Hist. Asli');
subplot(2,2,3), imshow(bright), title('Kecerahan +120');
subplot(2,2,4), imhist(rgb2gray(bright)), title('Hist. Kecerahan');
%3. Kombinasi kecerahan dan kontras%
figure;
contrast = img - 45;
contrast = contrast + 11;

subplot(2,2,1), imshow(img), title('Asli');
subplot(2,2,2), imhist(rgb2gray(img)), title('Hist. Asli');
subplot(2,2,3), imshow(contrast), title('Kontras Disesuaikan');
subplot(2,2,4), imhist(rgb2gray(contrast)), title('Hist. Kontras');
%4. Membalik citra%
figure;
inverse = 255 - img;

subplot(2,2,1), imshow(img), title('Asli');
subplot(2,2,2), imhist(rgb2gray(img)), title('Hist. Asli');
subplot(2,2,3), imshow(inverse), title('Inversi');
subplot(2,2,4), imhist(rgb2gray(inverse)), title('Hist. Inversi');
%5. Pemetaan nonlinear%
figure;
log_img = log(1 + double(img));
log_img = im2uint8(mat2gray(log_img));

subplot(2,2,1), imshow(img), title('Asli');
subplot(2,2,2), imhist(rgb2gray(img)), title('Hist. Asli');
subplot(2,2,3), imshow(log_img), title('Log Transform');
subplot(2,2,4), imhist(rgb2gray(log_img)), title('Hist. Log');
%6. Pemotongan aras keabuan%
figure;
gray_img = rgb2gray(img);
low = 100;
high = 160;
sliced_img = zeros(size(gray_img));
sliced_img(gray_img >= low & gray_img <= high) = 255;

subplot(2,2,1), imshow(gray_img), title('Grayscale');
subplot(2,2,2), imhist(gray_img), title('Hist. Grayscale');
subplot(2,2,3), imshow(uint8(sliced_img)), title('Sliced');
subplot(2,2,4), imhist(uint8(sliced_img)), title('Hist. Sliced');
%7. Ekualisasi histogram%
figure;
eq_img = histeq(gray_img);

subplot(2,2,1), imshow(gray_img), title('Grayscale');
subplot(2,2,2), imhist(gray_img), title('Hist. Grayscale');
subplot(2,2,3), imshow(eq_img), title('Hasil Ekualisasi');
subplot(2,2,4), imhist(eq_img), title('Hist. Ekualisasi');
