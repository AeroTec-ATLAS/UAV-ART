% Saves wind components speeds and Va graphics
% Inputs
% t:        time
% att:      attitude angles: roll and pitch
% folder:   what to append to the figure filename to describe it

function attitudeGraphics(t,att,folder)
    handle=figure();
    set(handle,'visible','off')
    plot(t,att(:,1)*180/pi)
    title('Roll','Interpreter','latex')
    xlabel('t [s]','Interpreter','latex')
    ylabel('\phi [º]','Interpreter','tex')
    saveFigAsPDF(handle,folder+"/pp")
    
    plot(t,att(:,2)*180/pi)
    title('Pitch','Interpreter','latex')
    xlabel('t [s]','Interpreter','latex')
    ylabel('\theta [º]','Interpreter','tex')
    saveFigAsPDF(handle,folder+"/tt")
end