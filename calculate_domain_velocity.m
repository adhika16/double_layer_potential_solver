function [Vn,Vt] = calculate_domain_velocity(nPoint,m,x,y,xt,yt,xb,yb,theta,thetat,sine,cosine,s,gama,alpha,Uinf)
  %% this function is to calculate velocity in the domain. this function consists of two steps
  % 1st step : calculating potential function in the domain using double layer potential relation
  % 2nd step : calculating velocity in the domain from corresponding potential function 
  %% 
  
  % calculating potential function in order to calculate velocity in the domain
  for i = 1:nPoint
    % 1st step
    tempn = 0.0d0;
    tempt = 0.0d0;
    for j = 1:m
      tempn1 = 0.0d0;
      tempt1 = 0.0d0;
      tempn2 = 0.0d0;
      tempt2 = 0.0d0;
      a = -(xt(i)-xb(j))*cosine(j) - (yt(i)-yb(j))*sine(j);
      b = (xt(i)-xb(j))^2 + (yt(i)-yb(j))^2;
      c = sin(thetat(i)-theta(j));
      d = cos(thetat(i)-theta(j));
      e = (xt(i)-xb(j))*sine(j) - (yt(i)-yb(j))*cosine(j);
      f = log (1+s(j)*(s(j)+2*a)/b);
      g = atan2(e*s(j),b+a*s(j)); 
      p = (xt(i)-xb(j))*sin(thetat(i)-2*theta(j)) + (yt(i)-yb(j))*cos(thetat(i)-2*theta(j));            
      q = (xt(i)-xb(j))*cos(thetat(i)-2*theta(j)) - (yt(i)-yb(j))*sin(thetat(i)-2*theta(j));
      tempn2 = tempn2 + d+0.5*q*f/s(j) - (a*c+d*e)*g/s(j);
      tempn1 = tempn1 + 0.5*d*f +c*g -tempn2;
      tempt2 = tempt2 + c+0.5*p*f/s(j) + (a*d-c*e)*g/s(j);
      tempt1 = tempt1 + 0.5*c*f-d*g-tempt2;
      tempt = tempt + tempt1*gama(j) + tempt2*gama(j+1);
      tempn = tempn + tempn1*gama(j) + tempn2*gama(j+1);
    end
    % 2nd step
    Vt_gama(i) = tempt; % tangential velocity induced by vortex sheet
    Vn_gama(i) = tempn; % normal velocity indoced by vortex sheet
    Vt_inf(i) =  cos(thetat(i)-alpha); % tangential velocity induced by freestrem
    Vn_inf(i) = -sin(thetat(i)-alpha); % normal velocity induced by freestrem
    Vn(i) = Uinf*(Vn_inf(i)+Vn_gama(i)); % normal velocity
    Vt(i) = Uinf*(Vt_inf(i)+Vt_gama(i)); % tangential velocity
  end
  % displaying velocity vectors
  figure; quiver(xt,yt,Vt,Vn); hold on; plot(x,y);
  set(get(gca, 'XLabel'), 'String', 'x');
  set(get(gca, 'YLabel'), 'String', 'y');
  set(get(gca, 'Title'), 'String', 'velocity vector plot');

  % starty = -1.0:0.1:1.0;
  % startx = zeros(size(starty));
  % streamline(xt,yt,Vt,Vn,startx,starty)
end
