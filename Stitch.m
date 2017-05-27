function [] = Stitch(Img1, descPartOfKeyPointsImg1, positionOfKeyPointsImg1, Img2, descPartOfKeyPointsImg2, positionOfKeyPointsImg2, threshold)
      
      [imgRow, imgCol] = size(Img1);
      [r, c] = size(descPartOfKeyPointsImg1);
      
      sameKeyPoints = zeros(r, 4);
      
      mini = threshold;
      for iFirstDesc = 1: r
          arrayRes = zeros(r, 1);
          x = 0;
          for iSecondDesc = 1: r
              resultEuc = 0;
              for jBoth = 1: c
                  resultEuc = resultEuc + (descPartOfKeyPointsImg1(iFirstDesc, jBoth) - descPartOfKeyPointsImg2(iSecondDesc, jBoth))^2;
              end
              if resultEuc < threshold
                  arrayRes(iSecondDesc, 1) = resultEuc;
              end
          end
          
          for triI = 1: r
              if mini > arrayRes(triI, 1) && arrayRes(triI, 1) ~= 0
                  mini = arrayRes(triI, 1);
                  x = triI;
              end
          end
          
          if(x ~= 0)
              sameKeyPoints(iFirstDesc, 1:4) = [positionOfKeyPointsImg1(iFirstDesc, 1:2) positionOfKeyPointsImg2(x, 1:2)];
          end
      end
      
       yOfFirstImg = sameKeyPoints(1, 2);
       firstImage = Img1(:, 1:yOfFirstImg);
       yOfSecondImg = sameKeyPoints(1, 4);
       xOfFirstImg = sameKeyPoints(1, 1);
       xOfSecondImg = sameKeyPoints(1, 3);
%        display(xOfSecondImg);
%        display(xOfFirstImg);
       secondImage = zeros(imgRow, imgCol-yOfSecondImg);
%        display(sum());
       xOfImage = (xOfFirstImg - xOfSecondImg + 1);
       secondImage(xOfImage:imgRow, 1:imgCol-yOfSecondImg+1) = Img2(1:(imgRow - xOfImage + 1), yOfSecondImg:imgCol);
%        secondImage = Img2(:, yOfSecondImg:imgCol);
%        figure;
%        imshow(Img1);
%        figure;
%        imshow(Img2);
%        figure;
%        imshow(firstImage);
%        figure;
%        imshow(secondImage);
       outputImg = cat(2, firstImage, secondImage);
       figure;
       imshow(outputImg);
      
      
%       figure;
%       imshow(Img1);
%       x1 = sameKeyPoints(1, 1);
%       y1 = sameKeyPoints(1, 2);
%       rectangle('Position',[y1 x1 2 2],'Curvature',[1,1], 'EdgeColor', 'b');
%       
%       
%       figure;
%       imshow(Img2);
%       x2 = sameKeyPoints(1, 3);
%       y2 = sameKeyPoints(1, 4);
%       rectangle('Position',[y2 x2 2 2],'Curvature',[1,1], 'EdgeColor', 'b');

% sameKeyPoints

end