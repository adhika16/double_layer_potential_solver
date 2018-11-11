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
  end

end
