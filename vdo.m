clc;
clear all;
vd=VideoReader('D:\downloads\Videos\Nallamothu_Nagamahalaxmi_30_female_right.avi');
frames=vd.NumberOfFrames;
video = vd.read();
for f=1:frames
    
Im=video(:,:,:,f);    %read frame  
agray=rgb2gray(Im);      %rgb2gray
[m,n]=size(agray);      
for i=1:m
    for j=1:n
        agray1(i,j)=255-agray(i,j);
    end
end
agray2=medfilt2(agray1);        %filtered and negative of image

for i=1:m
    for j=1:n
        if( agray2(i,j)>=170)       %thresholding
            z1(i,j)=255;
        else
            z1(i,j)=0;
        end
        
    end
end

se = strel('disk', 1, 4);
z2 = imdilate(z1,se);
cc = bwconncomp(z2);
numPixels = cellfun(@numel,cc.PixelIdxList);
[biggest,idx] = max(numPixels);
BW2 = ismember(labelmatrix(cc), idx);   %largest connected component
BW3 = imfill(BW2,'holes');
cc1 = bwconncomp(BW3);
numPixels = cellfun(@numel,cc1.PixelIdxList);
stats = regionprops(cc1, 'All');
% cnt1=edge(BW3);
% se2=strel('disk', 1, 4);
% cnt2 = imdilate(cnt1,se2);
% for i=1:m
%     for j=1:n
%         if(cnt2(i,j)>0)
%             a4(i,j)=255;
%         else
%             a4(i,j)=agray(i,j);
%         end
%         
%     end
% end
% figure,imshow(a4);
Area(f)=stats.Area;
end
plot(Area);