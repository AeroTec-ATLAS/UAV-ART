% Saves wind components speeds and Va graphics
% Inputs
% t:        time
% ang_v:    angular velocities: roll rate, pitch rate and yaw rate
% folder:   what to append to the figure filename to describe it

function angularVelocitiesGraphics(t,ang_v,folder)
    handle=figure();
    set(handle,'visible','off')
    plot(t,ang_v(:,1)*180/pi)
    title('Roll rate','Interpreter','latex')
    xlabel('t [s]','Interpreter','latex')
    ylabel('p [º/s]','Interpreter','tex')
    saveFigAsPDF(handle,folder+"/p")
    
    plot(t,ang_v(:,2)*180/pi)
    title('Pitch rate','Interpreter','latex')
    xlabel('t [s]','Interpreter','latex')
    ylabel('q [º/s]','Interpreter','tex')
    saveFigAsPDF(handle,folder+"/q")
    
    plot(t,ang_v(:,3)*180/pi)
    title('Yaw rate','Interpreter','latex')
    xlabel('t [s]','Interpreter','latex')
    ylabel('r [º/s]','Interpreter','tex')
    saveFigAsPDF(handle,folder+"/r")
end