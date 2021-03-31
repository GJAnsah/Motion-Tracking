
videoSource = VideoReader(''); %insert videofile name here with file extension. eg videoSource = VideoReader('my_vid.mp4')

videoSource.CurrentTime= ;  %video time (seconds) to start tracking from.
videoPlayer = vision.VideoPlayer();

T=[];
C1=[];
C2=[];
CC=[];

while hasFrame(videoSource)
    x  = readFrame(videoSource);
    frame=x;
    % Taking each picture element in the matrix across each row, we determine
    % if it has rbg value with red value less than Rmin or green value more than
    %  Gmax or blue value more than Bmax and make it white if its true
    if size(x,3)<3
        for e=size(x)+1:3
            x(:,:,e)=zeros(size(x,1),size(x,2));
        end
    end
    for i=1:size(x,1)
        for j=1:size(x,2)
            if x(i,j,1)>100|| x(i,j,2)<80 || x(i,j,3)>60
                x(i,j,:)=[255 255 255];
            end
        end
    end
    %subtracting the grayscale image from the red channel
    x2 = imsubtract(x(:,:,2), rgb2gray(x));
    %Use a median filter to filter out noise
    x2 = medfilt2(x2, [3 3]);
    
    %removing objects with few pixels
    x2 = bwareaopen(x2,20);
    
    %converting image to black and white
    %      x2 = im2bw(x2,0.18);
    bw = bwlabel(x2);
    
    %finding the boundaries of objects
    stats = regionprops(bw, 'BoundingBox','Centroid');
    
    imshow(frame);
    widths=[];
    for object = 1:length(stats)
        bb = stats(object).BoundingBox;
        widths=[widths,bb(3)];
    end
    for object = 1:length(stats)
        bb = stats(object).BoundingBox;
        if bb(3) == max(widths)
            cc=stats(object).Centroid;
            rectangle('Position',bb,'EdgeColor','b','LineWidth',1)
            disp('next bb')
            disp(bb);
            break
        end 
    end
    T=[T,bb(1)];
    CC=[CC,cc];
    C1=[C1,cc(1)];
    C2=[C1,cc(2)];
    disp(length(T));
    %      videoPlayer(out);
    pause(0.1);
end
release(videoPlayer);
%save('VidAcc_variables')
Vt=diff(T)*30;
At=diff(Vt)*30;
