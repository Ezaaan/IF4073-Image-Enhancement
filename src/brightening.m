function img = brightening(image, a, b)
    img = a * image + b;
    % Clip values to [0, 255]
    img = min(max(img, 0), 255);

    %displayHistogram(s, histogram_ref);
end