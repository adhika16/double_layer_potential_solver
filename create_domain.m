function [xt,yt,thetat,nPoint] = create_domain()
  %% calculating potential function in the domain
  % creating grid points
  x_mindom = -1.0d0;
  x_maxdom =  2.0d0;
  y_mindom = -1.0d0;
  y_maxdom =  1.0d0;
  nx = 50;
  ny = 50;
  dx = (x_maxdom-x_mindom)/nx;
  dy = (y_maxdom-y_mindom)/ny;

  % creating the domain
  nPoint=0;
  for i = 1:nx
    for j = 1:ny
      nPoint= nPoint + 1; % index
      xt(nPoint) = (i - 0.5) * dx + x_mindom; % x corrdinate 
      yt(nPoint) = (j - 0.5) * dy + y_mindom; % y coordinate
      thetat(nPoint) = 0.0d0; % panel's orientation wrt x direction
    end
  end

end

  % for i = 1:nx
  %   for j = 1:ny
  %     xt(i,j) = (i - 0.5) * dx + x_mindom; 
  %     yt(i,j) = (j - 0.5) * dy + y_mindom;    
  %   end
  % end

  % for i1 = 1:nx
  %   for i2 = 1:ny
  %     temp = 0.0d0;
  %     for j = 1:m
  %       a = -(x(i)-xb(j))*cosine(j) - (y(i)-yb(j))*sine(j);
  %       b = (x(i)-xb(j))^2 + (y(i)-yb(j))^2;
  %       c = sin(theta(i)-theta(j));
  %       d = cos(theta(i)-theta(j));
  %       e = (x(i)-xb(j))*sine(j) - (y(i)-yb(j))*cosine(j);
  %       f = log (1+s(j)*(s(j)+2*a)/b);
  %       g = atan2(e*s(j),b+a*s(j)); 
  %       p = (x(i)-xb(j))*sin(theta(i)-2*theta(j)) + (y(i)-yb(j))*cos(theta(i)-2*theta(j));            
  %       q = (x(i)-xb(j))*cos(theta(i)-2*theta(j)) - (y(i)-yb(j))*sin(theta(i)-2*theta(j));
  %       cn2(i,j) = d+0.5*q*f/s(j) - (a*c+d*e)*g/s(j);
  %       cn1(i,j) = 0.5*d*f +c*g -cn2(i,j);
  %       ct2(i,j) = c+0.5*p*f/s(j) + (a*d-c*e)*g/s(j);
  %       ct1(i,j) = 0.5*c*f-d*g-ct2(i,j);
  %       % gamasj = gama(j)+ (gama(j+1)-gama(j))*(0.5*s(j)/s(j));
  %       % tanInv = atan2((yt(i1,i2)-y(j)),(xt(i1,i2)-x(j)));
  %       % temp   = temp + gamasj*tanInv*s(j)/(2*pi);

  %     end
  %     Phi1(i1,i2) = temp;
  %     Phi2(i1,i2) = Uinf*(xt(i)*cos(alpha) + yt(i)*sin(alpha));
  %   end
  % end
  % surf(xt,yt,Phi2-Phi1);
