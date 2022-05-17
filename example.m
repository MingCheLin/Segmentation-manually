% example 
I = imread('coins.png');
[Mask,Edge] = segment(I);
figure;imagesc(double(I)+128*Mask+256*Edge)
colormap gray

I = repmat(I,[1,1,3]);
Mask = segment(I,'CM',summer,'savepoint',2,'save',true);
figure;imagesc(double(I(:,:,3))+128*Mask(:,:,3))

I = imread('ngc6543a.jpg');
IM = repmat(I,[1,1,1,3]);
Mask = segment(IM,'savepoint',2,'save',true);
figure;imagesc(double(I(:,:,2))+128*Mask(:,:,2))

% Wrong example (Without set 'RGB' to true and only 1 frame. So SEGMENT 
% mistaken input image as 3 frames gray-scaled image.)
Mask = segment(I);

% corrected
Mask = segment(I,'RGB',true);

