function displayHistogram(image, histogram_ref)
    % Check if the image is grayscale or RGB
    if size(image, 3) == 1
        % Call the grayscale histogram function with the UIAxes
        displayGrayscaleHistogram(image, histogram_ref);
    else
        % Call the RGB histogram function (to be implemented similarly)
        displayRGBHistogram(image, histogram_ref);  % Assuming you have this function defined
    end
end

function displayGrayscaleHistogram(image, histogram_ref)
    % Convert the image to a vector and initialize a pixel count array
    image_vector = double(image(:));
    pixel_count = zeros(1, 256);

    % Count the pixel intensities for the histogram
    for i = 1:length(image_vector)
        intensity = image_vector(i) + 1;  % Adjust for 1-based indexing
        pixel_count(intensity) = pixel_count(intensity) + 1;
    end

    % Plot the histogram on the given UIAxes instead of using a new figure
    bar(histogram_ref, 0:255, pixel_count, 'k');  % Plot on the provided UIAxes
    title(histogram_ref, 'Histogram (Grayscale Image)');
    xlabel(histogram_ref, 'Intensity');
    ylabel(histogram_ref, 'Frequency');
end


function displayRGBHistogram(image, histogram_refs)    
    % Split the image into Red, Green, and Blue channels
    red_channel = double(image(:,:,1));
    green_channel = double(image(:,:,2));
    blue_channel = double(image(:,:,3));

    % Initialize count arrays
    red_count = zeros(1, 256);
    green_count = zeros(1, 256);
    blue_count = zeros(1, 256);

    % Count the pixel of each RGB channel for histogram
    for i = 1:numel(red_channel)
        red_count(red_channel(i) + 1) = red_count(red_channel(i) + 1) + 1;
        green_count(green_channel(i) + 1) = green_count(green_channel(i) + 1) + 1;
        blue_count(blue_channel(i) + 1) = blue_count(blue_channel(i) + 1) + 1;
    end

    % Plot and show the histograms
    % Red channel histogram
    cla(histogram_refs(1));  % Clear previous plots
    bar(histogram_refs(1), red_count, 'r');
    title(histogram_refs(1), 'Histogram (Red Channel)');
    xlabel(histogram_refs(1), 'Intensity');
    ylabel(histogram_refs(1), 'Frequency');

    % Green channel histogram
    cla(histogram_refs(2));  % Clear previous plots
    bar(histogram_refs(2), green_count, 'g');  
    title(histogram_refs(2), 'Histogram (Green Channel)');
    xlabel(histogram_refs(2), 'Intensity');
    ylabel(histogram_refs(2), 'Frequency');

    % Blue channel histogram
    cla(histogram_refs(3));  % Clear previous plots
    bar(histogram_refs(3), blue_count, 'b');
    title(histogram_refs(3), 'Histogram (Blue Channel)');
    xlabel(histogram_refs(3), 'Intensity');
    ylabel(histogram_refs(3), 'Frequency');
end