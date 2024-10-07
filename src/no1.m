grayscaleImage = imread('boat.bmp');
rgbImage = imread('s.tif');
g = imread('cof.tif');

histogram(rgbImage);


function histogram(image)
    if size(image, 3) == 1
        displayGrayscaleHistogram(image);
    else
        displayRGBHistogram(image);
    end
end


function displayGrayscaleHistogram(image)
    image_vector = double(image(:));
    pixel_count = zeros(1, 256);

    % Count the pixel for histogram
    for i = 1:length(image_vector)
        intensity = image_vector(i) + 1;
        pixel_count(intensity) = pixel_count(intensity) + 1;
    end

    % Plot and show the histogram
    figure;
    bar(0:255, pixel_count, 'k');
    title('Histogram (Grayscale Image)');
    xlabel('Intensity');
    ylabel('Frequency');
end


function displayRGBHistogram(image)    
    % Split the image into Red, Green, and Blue channels
    red_channel = double(image(:,:,1));
    green_channel = double(image(:,:,2));
    blue_channel = double(image(:,:,3));

    red_count = zeros(1, 256);
    green_count = zeros(1, 256);
    blue_count = zeros(1, 256);

    % Count the pixel of each RGB channels for histogram
    for i = 1:numel(red_channel)
        red_count(red_channel(i) + 1) = red_count(red_channel(i) + 1) + 1;
        green_count(green_channel(i) + 1) = green_count(green_channel(i) + 1) + 1;
        blue_count(blue_channel(i) + 1) = blue_count(blue_channel(i) + 1) + 1;
    end

    % Plot and show the histograms
    % Red channel histogram
    figure;
    bar(0:255, red_count, 'r');
    title('Histogram (Red Channel)');
    xlabel('Intensity');
    ylabel('Frequency');

    % Green channel histogram
    figure;
    bar(0:255, green_count, 'g');  
    title('Histogram (Green Channel)');
    xlabel('Intensity');
    ylabel('Frequency');

    % Blue channel histogram
    figure;
    bar(0:255, blue_count, 'b');
    title('Histogram (Blue Channel)');
    xlabel('Intensity');
    ylabel('Frequency');
end