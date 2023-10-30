function plot_animated_quivers(t, y, y_target)

myVideo = VideoWriter('quiver_video', 'MPEG-4'); %open video file
myVideo.FrameRate = 30;
open(myVideo)

fh = figure;

F(250) = struct('cdata', [], 'colormap', []);
for j = 1:250
    clf
    plot_quivers(t(j), y(:, j), y_target)
    title(sprintf("t = %.3f", t(j)))

    % Draw and get frame
    drawnow
    F(j) = getframe(fh);
    writeVideo(myVideo, F(j));
end

close(myVideo)
end