% % Example for displaying histogram
% % Grayscale image
% gray_image = imread('boat.bmp');
% displayHistogram(gray);
% 
% % RGB image
% rgb_image = imread('s.tif');
% displayHistogram(rgb_image);


% % Example for histogram equalization
% i = imread('cof.tif');
% 
% imshow(i);
% displayHistogram(i);
% 
% equalizeHistogram(i);


% Example for histogram specification
% Grayscale image
% ori = imread('../test_images/4/girl.bmp');
% ref = imread('../test_images/4/goldhill.bmp');

% % RGB image
ori = imread('girl.bmp');
ref = imread('peppers.bmp');

figure, imshow(ori), title('Original image');
displayHistogram(ori);

figure, imshow(ref), title('Reference image');
displayHistogram(ref);

% specificateHistogram(ori, ref);