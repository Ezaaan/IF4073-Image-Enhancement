function img = logTransformation(image, c)
    r = im2double(image);
    img = c * log(1 + r);
    img = im2uint8(img);
end