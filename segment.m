function varargout = segment(IM,options)
% SEGMENT function provide a manually segment method in Matlab.It's working
% based on Matlab built-in function DRAWFREEHAND and CREATEMASK.
%
% [Mask] = segment(Image,___) show input image at left side. Enable user to
% segment on image manually and generate the mask as output.Input image
% data must with format X*Y*frame. Or if input image is RGB image, the
% format must be X*Y*RGB*frame.
% 
% [Mask,Edge] = segment(Image,___) not only output the segmentation area
% but also output the edge.
% 
% If not satiftied with previous segmentation, enter 'Y' or 'y' to redraw
% the segmentation.Otherwise, press enter to do the next frame.
%
% optional input arguments including CM, RGB, SAVEPOINT and SAVE:
%       CM : double. Change the display colormap in image, default as gray(256)
%       RGB : logical. If the input image is 3-dimensional(x*y*frame) it will 
%             default as False.Or it will be True and display image as RGB
%             image. But if input image is RGB image and only have 1 frame
%             please change RGB as True to prevent SEGMENT mistaken input
%             image as 3 frames gray-scaled image.
%       SAVEPOINT : double. Save segmentation as mat file with interval of 
%                   SAVEPOINT, default as 0 means don't save.
%       SAVE : logical. Save all output as mat file, default as False(not
%              save.)
    arguments
        IM 
        options.CM (:,3) double = gray(256)
        options.RGB (1,1) logical = 0
        options.savepoint (1,1) int8 = 0
        options.save (1,1) logical = 0
    end
    if size(IM,4) ~= 1
        options.RGB = 1;
    end
    if options.RGB == 1 && (size(IM,3) ~= 3)
        error('Input is not RGB image(3rd dimension of input is not 3)')
    end
    varargout = cell(1,nargout);
    F = figure;
    set(F,'position',[0,0,800,800]);
    switch options.RGB
        case 1
            Mask = zeros(size(IM,1),size(IM,2),size(IM,4));
            for i=1:size(IM,4)
                figure(F)
                image(IM(:,:,:,i),'CDataMapping','scaled')
                axis equal
                Mask(:,:,i) = draw;
                if mod(i,5)==0
                    fprintf('%i done, %i left\n',i,size(IM,4)-i)
                end
                if options.savepoint ~=0 && mod(i,options.savepoint)==0
                    save('savepoint.mat','Mask','-v7.3')
                end
            end            
        case 0
            Mask = zeros(size(IM,1),size(IM,2),size(IM,3));
            for i=1:size(IM,3)
                figure(F)
                image(IM(:,:,i),'CDataMapping','scaled')
                colormap(options.CM)
                axis equal
                Mask(:,:,i) = draw;
                if mod(i,5)==0
                    fprintf('%i done, %i left.\n',i,size(IM,3)-i)
                end
                if options.savepoint ~=0 && mod(i,options.savepoint)==0
                    save('savepoint.mat','Mask','-v7.3')
                    fprintf('Save %i.\n',i)
                end
            end
    end
    if options.save == 1
        save('Segmentation.mat','Mask','-v7.3')
        fprintf('End and Saved! \n')
    end
    if nargout == 2
        Edge = zeros(size(Mask,1),size(Mask,2),size(Mask,3));
        for i=1:size(Mask,3)
            Edge(:,:,i) = edge(Mask(:,:,i));
        end
        if options.save == 1
            save('Segmentation.mat','Edge','-append','-v7.3')
        end
        varargout{2} = Edge;
    end
    varargout{1} = Mask;
    
function redraw
    global h
    x = input('redraw? (enter y or Y to redraw)','s');
    if isempty(x) == 0 && (x == 'Y' || x == 'y')
        figure(F)
        h.draw
        redraw
    end
end
function W = draw
    global h
    h = drawfreehand;
    redraw
    h.Closed;
    W = createMask(h);
end
end
