function [xb,yb,m,mp1,Uinf,alpha] = read_data()
  % specify coordinates (xb,yb) of boundary points on airfoil surface. the
  % last point coincides with the first
  load naca2308_111p.txt;
  xy = naca2308_111p;

  % making coordinate to be column-wise
  xb0=xy(:,1)'; yb0=xy(:,2)';

  % calculating total panel point 
  m   = length(xb0)-1; % total point with TE & LE is treated as 1 point 
  mp1 = m+1; % total point including TE and LE
  % reverse point index, so the indexing is started from TE and goes on through lower surface first 
  for i=1:mp1
      xb(i)=xb0(mp1+1-i);
      yb(i)=yb0(mp1+1-i);
  end

  fprintf('input parameter:\n');
  % setting freestream velocity
  Uinf = input('freestream velocity (1-100m/s) : ');
  while (Uinf<=0) || (Uinf>100)
    Uinf = input('incorrect input, freestream velocity (1-100m/s) : ');
  end
  % setting up the angle of attack(AoA) in [radian]
  alphaDeg = input('angle of attack (-5 < AoA < 10deg) : ');
  while (alphaDeg>10) || (alphaDeg<-4)
    alphaDeg = input('incorrect input, angle of attack (-5 < AoA < 10deg) : ');
  end
  % alphaDeg = 4; % AoA in [degree]
  alpha = alphaDeg*pi/180; % AoA in [radian]

end