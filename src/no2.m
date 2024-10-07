i = imread('cof.tif');

imshow(i);
displayHistogram(i);

% brightening(i, 1, 100);
% negative(i);
% logTransformation(i, 3);
% powerTransformation(i, 1, 5);
contrastStretching(i);


function brightening(image, a, b)
    s = a * image + b;
    % Clip values to [0, 255]
    s = min(max(s, 0), 255);

    figure, imshow(s), title("Brightened image");
    displayHistogram(s);
end


function negative(image)
    s = 255 - image;
    
    figure, imshow(s), title("Negative image");
    displayHistogram(s);
end


function logTransformation(image, c)
    r = im2double(image);
    s = c * log(1 + r);
    s = im2uint8(s);

    figure, imshow(s), title ('Log transformation image');
    displayHistogram(s);
end


function powerTransformation(image, c, gamma)
    r = im2double(image);
    s = c * r .^ gamma;
    s = im2uint8(s);

    figure, imshow(s), title ('Power transformation image');
    displayHistogram(s);
end


function contrastStretching(image)
    if size(image, 3) == 3
        redChannel = image(:,:,1);
        greenChannel = image(:,:,2);
        blueChannel = image(:,:,3);

        rminR = double(min(redChannel(:)));
        rmaxR = double(max(redChannel(:)));
        rminG = double(min(greenChannel(:)));
        rmaxG = double(max(greenChannel(:)));
        rminB = double(min(blueChannel(:)));
        rmaxB = double(max(blueChannel(:)));
        
        % Stretch the RGB channel
        sR = (double(redChannel) - rminR) * (255 / (rmaxR - rminR));
        sG = (double(greenChannel) - rminG) * (255 / (rmaxG - rminG));
        sB = (double(blueChannel) - rminB) * (255 / (rmaxB - rminB));
        
        % Recombine the RGB channel
        s = cat(3, uint8(sR), uint8(sG), uint8(sB));
    else
        rmin = double(min(image(:)));
        rmax = double(max(image(:)));
        
        % Stretch the grayscale image
        s = (double(image) - rmin) * (255 / (rmax - rmin));
        s = uint8(s);
    end
    
    figure, imshow(s), title('Contrast Stretched Image');
    displayHistogram(s);
end
