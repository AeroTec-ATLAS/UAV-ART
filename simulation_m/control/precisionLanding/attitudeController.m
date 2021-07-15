% UAV-ART // Aerotéc - Núcleo de estudantes de Engenharia Aeroespacial
% Attitude controller


G=[sin(alpha) 0 -cos(alpha);-cos(alpha)*tan(beta) 1 -sin(alpha)*tan(beta);cos(alpha)/cos(beta) 0 sin(alpha)/cos(beta)];

W=[W1;W2;W3];

W1=-D*tan(beta)-C+mass*g*(sin(miu)*cos(gamma)-sin(gamma)*tan(beta));

W2=(-D*tan(alpha)-L*cos(beta)+mass*g*(cos(miu)*cos(gamma)*cos(beta)-sin(gamma)*tan(alpha)))/(cos^2(beta));

W3=L*(tan(beta)+tan(gamma)*sin(miu))-C*tan(gamma)*cos(miu)+D*(((tan(alpha)*sin(miu)*tan(gamma)+tan(alpha)*tan(beta))/(cos(beta)))-tan(beta)*cos(miu)*tan(gamma))+mass*g*(((tan(alpha)*sin(miu)*tan(gamma)*sin(gamma)+tan(alpha)*tan(beta)*sin(gamma))/(cos(beta)))-((tan(beta)*cos(miu))/cos(gamma)));


