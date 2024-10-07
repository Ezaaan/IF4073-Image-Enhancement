i = imread('cof.tif');
% figure, histogram(i);
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
    figure, histogram(s);
end


function negative(image)
    s = 255 - image;
    
    figure, imshow(s), title("Negative image");
    figure, histogram(s);
end


function logTransformation(image, c)
    r = im2double(image);
    s = c * log(1 + r);
    
    figure, imshow(s), title ('Log transformation image');
    figure, histogram(s);
end


function powerTransformation(image, c, gamma)
    r = im2double(image);
    s = c * r .^ gamma;

    figure, imshow(s), title ('Power transformation image');
    figure, histogram(s);
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
        
        % Stretch RGB channel
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
    figure, histogram(s);
end
