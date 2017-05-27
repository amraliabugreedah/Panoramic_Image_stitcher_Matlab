
Img1 = imread('Louvre1.jpg');
sigmaAndKeyPointsImg1 = SIFT(Img1, 20, 0.1);
[descPartOfKeyPointsImg1, positionOfKeyPointsImg1] = Get_Descriptor(imread('Louvre1.jpg'), sigmaAndKeyPointsImg1);

Img2 = imread('Louvre2.jpg');
sigmaAndKeyPointsImg2 = SIFT(Img2, 20, 0.1);
[descPartOfKeyPointsImg2, positionOfKeyPointsImg2] = Get_Descriptor(imread('Louvre2.jpg'), sigmaAndKeyPointsImg2);

threshold = 1000;
Stitch(Img1, descPartOfKeyPointsImg1, positionOfKeyPointsImg1, Img2, descPartOfKeyPointsImg2, positionOfKeyPointsImg2, threshold);