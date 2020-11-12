% Saves wind components speeds and Va graphics
% Inputs
% t:        time
% aa:       attack angle
% bb:       sideslip angle
% folder:   what to append to the figure filename to describe it

function aerodynamicAnglesGraphics(t,aa,bb,folder)
    handle=figure();
    set(handle,'visible','off')
    plot(t,aa*180/pi)
    title('Angle of attack','Interpreter','latex')
    xlabel('t [s]','Interpreter','latex')
    ylabel("\alpha [º]",'Interpreter','tex')
    saveFigAsPDF(handle,folder+"/aa")
    
    plot(t,bb*180/pi)
    title('Sideslip angle','Interpreter','latex')
    xlabel('t [s]','Interpreter','latex')
    ylabel('\beta [º]','Interpreter','tex')
    saveFigAsPDF(handle,folder+"/bb")
end