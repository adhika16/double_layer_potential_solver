function [Vn,Vt] = calculate_domain_velocity(nPoint,m,x,y,xt,yt,xb,yb,theta,thetat,sine,cosine,s,gama,alpha,Uinf)
  % calculating potential function in order to calculate velocity in the domain
  for i = 1:nPoint
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
      % cn2(i,j) = d+0.5*q*f/s(j) - (a*c+d*e)*g/s(j);
      % cn1(i,j) = 0.5*d*f +c*g -cn2(i,j);
      % ct2(i,j) = c+0.5*p*f/s(j) + (a*d-c*e)*g/s(j);
      % ct1(i,j) = 0.5*c*f-d*g-ct2(i,j);
      tempt = tempt + tempt1*gama(j) + tempt2*gama(j+1);
      tempn = tempn + tempn1*gama(j) + tempn2*gama(j+1);
    end
    Vt_gama(i) = tempt;
    Vn_gama(i) = tempn;
    Vt_inf(i) =  cos(thetat(i)-alpha);
    Vn_inf(i) = -sin(thetat(i)-alpha);
    Vn(i) = Uinf*(Vn_inf(i)+Vn_gama(i));
    Vt(i) = Uinf*(Vt_inf(i)+Vt_gama(i));
  end
  % scatter3(xt,yt,Vn,1); hold on; plot(x,y);
  quiver(xt,yt,Vt,Vn,Uinf*0.1); hold on; plot(x,y);
  set(get(gca, 'XLabel'), 'String', 'x');
  set(get(gca, 'YLabel'), 'String', 'y');
  set(get(gca, 'Title'), 'String', 'velocity vector plot');
end