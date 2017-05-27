function [descPartOfKeyPoints, positionOfKeyPoints] = Get_Descriptor(inputImage, sigmaAndKeyPoints)

        [r, c, ~] = size(inputImage);
        counter=0;
        
        for kpX = 1: r
            for kpY = 1: c
                if sigmaAndKeyPoints(kpX, kpY) ~= 0
                    counter = counter + 1;
                end
            end
        end
        
        descPartOfKeyPoints = zeros(counter,128);  
        descPartI = 1;
        positionOfKeyPoints = zeros(counter, 2);
        for i = 9: r-8
            for j = 9: c-8
                sigma = sigmaAndKeyPoints(i,j);
                if(sigma ~= 0)
                    matrixGVGH = zeros(16, 16);
                    sizeFilt = 2*ceil(3*sigma)+1;
                    filt = fspecial('gaussian', sizeFilt, sigma);
                    filtImg = imfilter(inputImage, filt, 'same');
                    [~, ~, GV, GH] = edge(filtImg, 'Prewitt');
                    posX = i;
                    posY = j;
                    windowGV = GV(posX-8:posX+7, posY-8:posY+7);
                    windowGH = GH(posX-8:posX+7, posY-8:posY+7);
                    
                    for Gi = 1: 16
                        for Gj = 1: 16
                            matrixGVGH(Gi, Gj) = atand(windowGV(Gi, Gj) / windowGH(Gi, Gj));
                        end
                    end
                    
                    descPartJ = 0;
                    
                    for gResX = 1: 4: 13
                        for gResY = 1: 4: 13 
%                             descPart = zeros(1,8);
                            gResWindow = matrixGVGH(gResX:gResX+3, gResY:gResY+3);
                            reshapedRes = reshape(gResWindow', 1, 16);
                            [bincounts, ~] = histc(reshapedRes, [0, 45, 90, 135, 180, 225, 270, 315, 360]);
                            
                            for binJ = 1: 8
                               
                                descPartOfKeyPoints(descPartI, binJ + descPartJ) = bincounts(1, binJ);
                            end
                            descPartJ = descPartJ + 8;
                        end
                    end
                    
                    positionOfKeyPoints(descPartI, 1:2) = [i j];
                    descPartI = descPartI + 1;
                end
            end
        end
            
                    display('got the decriptor xD');
  
end