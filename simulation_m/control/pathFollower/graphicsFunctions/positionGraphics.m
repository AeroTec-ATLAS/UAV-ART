% Saves graphics of the positions of the aircraft in NED north vs east, 
% -down vs north and -down vs east
% Arguments
% pos - positions matrix, different lines correspond to different time
%       instants in NED
% path - includes all the information on the path created in the
%        pathManager, structure with fields flag, r, q, c, rho and lambda

function positionGraphics(pos,path,folder)
    if path.flag == 1    
        e = 50;
        bounds = [min(pos(:,1))-e, max(pos(:,1))+e;
            min(pos(:,2))-e, max(pos(:,2))+e;
            min(pos(:,3))-e, max(pos(:,3))+e;];
        ints = getIntersections3D(path.r,path.q,bounds);
        
        nn = ints(1,:);
        ee = ints(2,:);
        dd = -ints(3,:);
    else
        N = 100;
        th = 0:2*pi/N:2*pi;
        nn = path.c(1)+path.rho*cos(th);
        ee = path.c(2)+path.rho*sin(th);
        dd = -ones(1,length(th))*path.c(3);
    end

    figure();
    set(gcf,'visible','off')
    plot(nn,ee,'r')
    hold on
    plot(pos(:,1), pos(:,2),'b')
    title('North vs East','Interpreter','latex')
    xlabel('North [m]','Interpreter','latex')
    ylabel('East [m]','Interpreter','latex')
    legend('Desired','Observed','Interpreter','latex','location','best')
    hold off
    saveFigAsPDF(gcf,folder+"/north_east")
    
    figure();
    set(gcf,'visible','off')
    plot(nn,dd,'r')
    hold on
    plot(pos(:,1), -pos(:,3),'b')
    title('Altitude vs North','Interpreter','latex')
    xlabel('North [m]','Interpreter','latex')
    ylabel('Altitude [m]','Interpreter','latex')
    legend('Desired','Observed','Interpreter','latex','location','best')
    hold off
    saveFigAsPDF(gcf,folder+"/north_altitude")
    
    figure();
    set(gcf,'visible','off')
    plot(ee,dd,'r')
    hold on
    plot(pos(:,2), -pos(:,3),'b')
    title('Altitude vs East','Interpreter','latex')
    xlabel('East [m]','Interpreter','latex')
    ylabel('Altitude [m]','Interpreter','latex')
    legend('Desired','Observed','Interpreter','latex','location','best')
    hold off
    saveFigAsPDF(gcf,folder+"/east_altitude")
end
