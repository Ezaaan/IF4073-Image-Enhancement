function img = powerTransformation(image, c, gamma)
    r = im2double(image);
    img = c * r .^ gamma;
    img = im2uint8(img);
end