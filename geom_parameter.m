function [x,y,s,theta,sine,cosine,rhs] = geom_parameter(xb,yb,m,alpha)
  % coordinates (x,y) of control point and panel length s are computed for each of the vortex panels.
  % rhs represents the right-hand side of eq.(15.47).
  for i=1:m;
    ip1       = i+1; % index of next panel
    x(i)      = 0.5*(xb(i)+xb(ip1)); % x coordinate of panel's midpoint
    y(i)      = 0.5*(yb(i)+yb(ip1)); % y coordinate of panel's midpoint
    s(i)      = sqrt( (xb(ip1)-xb(i))^2 + (yb(ip1)-yb(i))^2); % panel's length
    theta(i)  = atan2((yb(ip1)-yb(i)),(xb(ip1)-xb(i))); % the orientation angle of the ith panel measured from the x axis to the panel surface 
    sine(i)   = sin(theta(i)); % sin(tetha)
    cosine(i) = cos(theta(i)); % cos(tetha)
    rhs(i)    = sin(theta(i)-alpha);
    % thetaN(i) = pi/2 + theta(i); % the orientation of unit normal angle of the i-th panel measured from the x axis
    % betha(i)  = thetaN(i) - alpha; % the orientation angle between i-th panel's normal and freestream direction
    % g0(i)     = 0.0d0;
    % rhs1(i)   = g0(i) + Uinf*cos(betha(i));
  end

  % for i = 1:m
  %   for j = 1:m
  %     if (j==i)
  %       matA(i,j)=-0.5d0*s(i);
  %     else
  %       xi = x(i);
  %       yi = y(i);
  %       xj = x(j);
  %       yj = y(j);
  %       betha_i = betha(i);
  %       matA(i,j) = -1*dPhi_dn(xi,yi,xj,yj,betha_i)*s(j);
  %     end
  %   end
  % end
  % hx = matA\rhs1';
  % scatter3(x,y,hx,1);  
end

