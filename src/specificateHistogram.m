function img = specificateHistogram(image, ref_image)
    if size(image, 3) == 1
        img = specificateGrayscaleHistogram(image, ref_image);
    else
        img = specificateRGBHistogram(image, ref_image);
    end
end


function img = specificateGrayscaleHistogram(image, ref_image)
    [~, oriRoundedMappingList] = equalizeGrayscaleHistogram(image);
    [refMappingList, ~] = equalizeGrayscaleHistogram(ref_image);

    newMappingList = zeros(1, 256, 'double');

    % Find the closest value of original rounded mapping list
    for i = 1:length(oriRoundedMappingList)
        [~, idx] = min(abs(refMappingList - oriRoundedMappingList(i)));
        newMappingList(i) = idx-1;
    end

    % Map the new pixel to the image
    img = uint8(newMappingList(image + 1));
end


function img = specificateRGBHistogram(image, ref_image)
    % Split the image into Red, Green, and Blue channels
    red_channel = double(image(:,:,1));
    green_channel = double(image(:,:,2));
    blue_channel = double(image(:,:,3));

    [~, ~, ~, oriRoundedRMaps, oriRoundedGMaps, oriRoundedBMaps] = equalizeRGBHistogram(image);
    [refRMaps, refGMaps, refBMaps, ~, ~, ~] = equalizeRGBHistogram(ref_image);

    newRMaps = zeros(1, 256, 'double');
    newGMaps = zeros(1, 256, 'double');
    newBMaps = zeros(1, 256, 'double');

    % Find the closest value of original rounded mapping list
    for i = 1:length(oriRoundedRMaps)
        % For red channel
        [~, rIdx] = min(abs(refRMaps - oriRoundedRMaps(i)));
        newRMaps(i) = rIdx-1;

        % For green channel
        [~, gIdx] = min(abs(refGMaps - oriRoundedGMaps(i)));
        newGMaps(i) = gIdx-1;

        % For blue channel
         [~, bIdx] = min(abs(refBMaps - oriRoundedBMaps(i)));
        newBMaps(i) = bIdx-1;
    end

    % Map the new RGB channels
    new_red_channel = uint8(newRMaps(red_channel + 1));
    new_green_channel = uint8(newGMaps(green_channel + 1));
    new_blue_channel = uint8(newBMaps(blue_channel + 1));

    % Recombine the RGB channel
    img = cat(3, new_red_channel, new_green_channel, new_blue_channel);
end


function [mappingList, roundedMappingList] = equalizeGrayscaleHistogram(image)
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
    mappingList = pixel_count * 255;
    roundedMappingList = floor(mappingList);
end


function [rMaps, gMaps, bMaps, roundedRMaps, roundedGMaps, roundedBMaps] = equalizeRGBHistogram(image)
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
    rMaps = red_count * 255;
    gMaps = green_count * 255;
    bMaps = blue_count * 255;

    roundedRMaps = floor(rMaps);
    roundedGMaps = floor(gMaps);
    roundedBMaps = floor(bMaps);
end