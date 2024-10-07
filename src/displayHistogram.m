function displayHistogram(image, axesHandle)
    % Check if the image is grayscale or RGB
    if size(image, 3) == 1
        % Call the grayscale histogram function with the UIAxes
        displayGrayscaleHistogram(image, axesHandle);
    else
        % Call the RGB histogram function (to be implemented similarly)
        displayRGBHistogram(image, axesHandle);  % Assuming you have this function defined
    end
end

function displayGrayscaleHistogram(image, axesHandle)
    % Convert the image to a vector and initialize a pixel count array
    image_vector = double(image(:));
    pixel_count = zeros(1, 256);

    % Count the pixel intensities for the histogram
    for i = 1:length(image_vector)
        intensity = image_vector(i) + 1;  % Adjust for 1-based indexing
        pixel_count(intensity) = pixel_count(intensity) + 1;
    end

    % Plot the histogram on the given UIAxes instead of using a new figure
    bar(axesHandle, 0:255, pixel_count, 'k');  % Plot on the provided UIAxes
    title(axesHandle, 'Histogram (Grayscale Image)');
    xlabel(axesHandle, 'Intensity');
    ylabel(axesHandle, 'Frequency');
end


function displayRGBHistogram(image, axesHandlers)    
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
    cla(axesHandlers(1));  % Clear previous plots
    bar(axesHandlers(1), red_count, 'r');
    title(axesHandlers(1), 'Histogram (Red Channel)');
    xlabel(axesHandlers(1), 'Intensity');
    ylabel(axesHandlers(1), 'Frequency');

    % Green channel histogram
    cla(axesHandlers(2));  % Clear previous plots
    bar(axesHandlers(2), green_count, 'g');  
    title(axesHandlers(2), 'Histogram (Green Channel)');
    xlabel(axesHandlers(2), 'Intensity');
    ylabel(axesHandlers(2), 'Frequency');

    % Blue channel histogram
    cla(axesHandlers(3));  % Clear previous plots
    bar(axesHandlers(3), blue_count, 'b');
    title(axesHandlers(3), 'Histogram (Blue Channel)');
    xlabel(axesHandlers(3), 'Intensity');
    ylabel(axesHandlers(3), 'Frequency');
end