%Author: Gilgal Ansah
% The program tracks a green marker across video frames and plots the displacement, velocity, and acceleration.


%input video file
videoSource = VideoReader('free-fall2.mp4');
%video frames are shown at 30fps.

%videoSource.CurrentTime=30;
videoPlayer = vision.VideoPlayer();
T=[];
W=[];
C1=[];
C2=[];
CC=[];

%track marker for each frame
while hasFrame(videoSource)
     x  = readFrame(videoSource);
     frame=x;
     %making all pixels white except for green pixels. 
     if size(x,3)<3
        for e=size(x)+1:3
            x(:,:,e)=zeros(size(x,1),size(x,2));
        end
     end
     for i=1:size(x,1)
         for j=1:size(x,2)
             if x(i,j,1)>90|| x(i,j,2)<70 || x(i,j,3)>50
                 x(i,j,:)=[255 255 255];
             end
         end
     end
     
     %subtracting the grayscale image from the green channel
     x2 = imsubtract(x(:,:,2), rgb2gray(x));
     
     %Use a median filter to filter out noise
%      x2 = medfilt2(x2, [3 3]);

     %removing small objects. 
     x2 = bwareaopen(x2,500);
     
     %converting image to black and white
%      x2 = im2bw(x2,0.18)

     %labeling objects
     bw = bwlabel(x2);
     
     %finding the boundaries and centroids of objects
     stats = regionprops(bw, 'BoundingBox','Centroid');
 
     imshow(frame);
     %drawing bounding box
for object = 1:length(stats)
    bb = stats(object).BoundingBox;
    cc=stats(object).Centroid;
    rectangle('Position',bb,'EdgeColor','b','LineWidth',1)
    disp('next bb')
    disp(bb);
    
end
    T=[T,bb(1)]; %x-coordinate of bounding box
    W=[W,bb(3)]; %width of bounding box
    CC=[CC,cc]; %centroid (x,y)
    C1=[C1,cc(1)]; %x-coordinate of centroid
    C2=[C1,cc(2)]; %y-coordinate of centroid
    
    disp(length(T));
%      videoPlayer(out);
     pause(0.1);
end
release(videoPlayer);
%save('VidAcc_variables')

%calculating velocity and acceleration
Vt=diff(T)*30;
At=diff(Vt)*30;
