% Saves deltas graphics over time
% Inputs
% t:        time
% dd:       struct whose fields are vertical vectors of the deltas in t
% folder:   what to append to the figure filename to describe it

function deltaGraphics(t,dd,folder)
    handle=figure();
    set(handle,'visible','off')
    plot(t,dd.e*180/pi)
    title('Elevator','Interpreter','latex')
    xlabel('t [s]','Interpreter','latex')
    ylabel('\delta_e [º]','Interpreter','tex')
    saveFigAsPDF(handle,folder+"/dde")
    
    plot(t,dd.a*180/pi)
    title('Ailerons','Interpreter','latex')
    xlabel('t [s]','Interpreter','latex')
    ylabel('\delta_a [º]','Interpreter','tex')
    saveFigAsPDF(handle,folder+"/dda")
    
    plot(t,dd.t)
    title('Thrust','Interpreter','latex')
    xlabel('t [s]','Interpreter','latex')
    ylabel('\delta_t','Interpreter','tex')
    saveFigAsPDF(handle,folder+"/ddt")
end