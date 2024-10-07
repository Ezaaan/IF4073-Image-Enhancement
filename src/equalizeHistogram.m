i = imread('na.jpg');

imshow(i);
displayHistogram(i);

equalizeHistogram(i);


function equalizeHistogram(image)
    if size(image, 3) == 1
        equalizeGrayscaleHistogram(image);
    else
        equalizeRGBHistogram(image);
    end
end


function equalizeGrayscaleHistogram(image)
    image_vector = double(image(:));
    pixel_count = zeros(1, 256, 'double');
    n = length(image_vector);

    % Count the pixel frequency
    for i = 1:n
        intensity = image_vector(i) + 1;
        pixel_count(intensity) = pixel_count(intensity) + 1;
    end
    
    % Divide each pixel with the total pixel to normalize    
    pixel_count = pixel_count / n;

    % Sum the pixel
    pixel_count = cumsum(pixel_count);

    % Multiply each pixel_count element with 255
    pixel_count = floor(pixel_count * 255);

    % Map the new pixel to the image
    new_image = uint8(pixel_count(image + 1));

    figure, imshow(new_image), title('Equalized grayscale image');
    displayHistogram(new_image);
end


function equalizeRGBHistogram(image)
    % Split the image into Red, Green, and Blue channels
    red_channel = double(image(:,:,1));
    green_channel = double(image(:,:,2));
    blue_channel = double(image(:,:,3));

    red_count = zeros(1, 256, 'double');
    green_count = zeros(1, 256, 'double');
    blue_count = zeros(1, 256, 'double');
    n = numel(red_channel);

    % Count the pixel of each RGB channels for histogram
    for i = 1:n
        red_count(red_channel(i) + 1) = red_count(red_channel(i) + 1) + 1;
        green_count(green_channel(i) + 1) = green_count(green_channel(i) + 1) + 1;
        blue_count(blue_channel(i) + 1) = blue_count(blue_channel(i) + 1) + 1;
    end

    % Divide each pixel with the total pixel to normalize    
    red_count = red_count / n;
    green_count = green_count / n;
    blue_count = blue_count / n;

    % Sum the pixel
    red_count = cumsum(red_count);
    green_count = cumsum(green_count);
    blue_count = cumsum(blue_count);

    % Multiply each pixel_count element with 255
    red_count = floor(red_count * 255);
    green_count = floor(green_count * 255);
    blue_count = floor(blue_count * 255);

    % Map the new pixel to each RGB channel
    new_red_channel = uint8(red_count(red_channel + 1));
    new_green_channel = uint8(green_count(green_channel + 1));
    new_blue_channel = uint8(blue_count(blue_channel + 1));

    % Recombine the RGB channel
    new_image = cat(3, new_red_channel, new_green_channel, new_blue_channel);

    figure, imshow(new_image), title('Equalized RGB image');
    displayHistogram(new_image);
end