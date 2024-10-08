function img = contrastStretching(image)
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
        img = cat(3, uint8(sR), uint8(sG), uint8(sB));
    else
        rmin = double(min(image(:)));
        rmax = double(max(image(:)));
        
        % Stretch the grayscale image
        img = (double(image) - rmin) * (255 / (rmax - rmin));
        img = uint8(img);
    end
end