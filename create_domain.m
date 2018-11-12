function [xt,yt,thetat,nPoint] = create_domain()
  % creating grid points
  x_mindom = -1.0d0; % x minimum
  x_maxdom =  2.0d0; % x maximum 
  y_mindom = -1.0d0; % y minimum 
  y_maxdom =  1.0d0; % y maximum
  nx = 50; % grid points in x direction
  ny = 50; % grid points in y direction
  dx = (x_maxdom-x_mindom)/nx; % grid spacing in x direction
  dy = (y_maxdom-y_mindom)/ny; % grid spacing in y direction

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
