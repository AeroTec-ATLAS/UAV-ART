clear video
video = VideoWriter('sim_demo_plots','MPEG-4');
video.FrameRate = 21;
open(video)
writeVideo(video,frames);
close(video)