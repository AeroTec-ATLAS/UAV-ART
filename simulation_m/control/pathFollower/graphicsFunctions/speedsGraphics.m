% Saves wind components speeds and Va graphics
% Inputs
% t:        time
% Va:       airspeed in m/s
% vw:       vector of windspeeds: north, east and minus down
% folder:   what to append to the figure filename to describe it

function speedsGraphics(t,Va,v_w,folder)
    handle=figure();
    set(handle,'visible','off')
    plot(t,Va)
    title('Airspeed','Interpreter','latex')
    xlabel('t [s]','Interpreter','latex')
    ylabel('Va [m/s]','Interpreter','latex')
    saveFigAsPDF(handle,folder+"/Va")
    
    plot(t,v_w(:,1))
    title('North windspeed','Interpreter','latex')
    xlabel('t [s]','Interpreter','latex')
    ylabel('w_n [m/s]','Interpreter','tex')
    saveFigAsPDF(handle,folder+"/wn")
    
    plot(v_w(:,2),t)
    title('East windspeed','Interpreter','latex')
    xlabel('w_e [m/s]','Interpreter','tex')
    ylabel('t [s]','Interpreter','latex')
    saveFigAsPDF(handle,folder+"/we")
    
    plot(t,-v_w(:,3))
    title('-Down windspeed','Interpreter','latex')
    xlabel('t [s]','Interpreter','latex')
    ylabel('-w_d [m/s]','Interpreter','tex')
    saveFigAsPDF(handle,folder+"/-w_d")
end