function [sigmaAndKeyPoints] = SIFT(inputImage, maximumSigma, threshold)


[r, c, ~] = size(inputImage);

%              display(r);
%              display(c);
sigmaAndKeyPoints = zeros(r, c);

filtImgArray = {maximumSigma};

for sigma = 1: maximumSigma
    
    log_mask = log_filt(sigma);
%                  [row1, col1, ~] = size(log_mask);
%                  display(row1);
%                  display(col1);
 imgDiv = double(inputImage)/255;
    convResult = conv2(imgDiv, double(log_mask), 'same'); % divide image by 255
%               [row1, col1, ~] = size(convResult);
%                display(row1);
%                display(col1);
    filtImgArray{sigma} = convResult;
    
end

for filtImg = 2: maximumSigma-1
    
    topImg = filtImgArray{filtImg-1};
    currentImg = filtImgArray{filtImg};
    botImg = filtImgArray{filtImg+1};
    
    for i = 2: r-1
        for j = 2: c-1
            
            topImgWindow = topImg(i-1:i+1, j-1:j+1);
            botImgWindow = botImg(i-1:i+1, j-1:j+1);
            currPix = currentImg(i, j);
            
            maxT = max(max(topImgWindow));
            maxB = max(max(botImgWindow));
            maxCurrent = max([currentImg(i-1,j-1:j+1),currentImg(i+1,j-1:j+1),currentImg(i,j-1),currentImg(i,j+1)]);
            
            if (currPix >= maxT && currPix >= maxB && currPix >= maxCurrent && currPix >= threshold) %max([currPix, maxT, maxB, maxCurrent]
                
                %if(sigmaAndKeyPoints(i, j) == 0)
                    sigmaAndKeyPoints(i, j) = filtImg;
                   %   display(filtImg);
               % end
            end
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% start of drawing blobs
figure;
imshow(inputImage);

for a = 2: r-1
    for b = 2: c-1
        if (sigmaAndKeyPoints(a, b) ~= 0)
            r = sqrt(2) * sigmaAndKeyPoints(a, b);
            d = r * 2;
            px = a - r;
            py = b - r;
            rectangle('Position',[py px d d],'Curvature',[1,1], 'EdgeColor', 'b');
            
           % display(sigmaAndKeyPoints(a, b)); 
        end
        
    end
end

display('finished sift');

end