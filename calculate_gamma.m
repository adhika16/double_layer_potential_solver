function [gama,cp] = calculate_gamma(xb,yb,x,y,s,theta,sine,cosine,rhs,m,mp1,alpha)
  
  for i=1:m
    for j = 1:m
      if i==j
        % representing Kutta condition
        cn1(i,j) = -1.0;
        cn2(i,j) =  1.0;
        ct1(i,j) = pi/2;
        ct2(i,j) = pi/2;
      else
        a = -(x(i)-xb(j))*cosine(j) - (y(i)-yb(j))*sine(j);
        b = (x(i)-xb(j))^2 + (y(i)-yb(j))^2;
        c = sin(theta(i)-theta(j));
        d = cos(theta(i)-theta(j));
        e = (x(i)-xb(j))*sine(j) - (y(i)-yb(j))*cosine(j);
        f = log (1+s(j)*(s(j)+2*a)/b);
        g = atan2(e*s(j),b+a*s(j)); 
        p = (x(i)-xb(j))*sin(theta(i)-2*theta(j)) + (y(i)-yb(j))*cos(theta(i)-2*theta(j));            
        q = (x(i)-xb(j))*cos(theta(i)-2*theta(j)) - (y(i)-yb(j))*sin(theta(i)-2*theta(j));
        cn2(i,j) = d+0.5*q*f/s(j) - (a*c+d*e)*g/s(j);
        cn1(i,j) = 0.5*d*f +c*g -cn2(i,j);
        ct2(i,j) = c+0.5*p*f/s(j) + (a*d-c*e)*g/s(j);
        ct1(i,j) = 0.5*c*f-d*g-ct2(i,j);
      end
    end
  end
  % compute influence coefficients in eq (5.47) and (5.49).
  for i=1:m;
    an(i,1) = cn1(i,1);
    an(i,mp1) = cn2(i,m);
    at(i,1) = ct1(i,1);
    at(i,mp1) = ct2(i,m);
    for j=2:m
      an(i,j) = cn1(i,j) + cn2(i,(j-1));
      at(i,j) = ct1(i,j) + ct2(i,(j-1));
    end
  end
  an(mp1,1)=1.0;
  an(mp1,mp1)=1.0;
  for j=2:m
    an(mp1,j)=0.0;
  end
  rhs(mp1)=0.0;
  % solve eq.(5.47) for dimensionless strength gama using cramer's rule. then
  % compute and print dimensionless velocity and pressure coefficient at
  % control points
  gama=an\rhs';
  % gama=gauss_seidel2(an,rhs,mp1,1e-2);
  % gama=gaussEl(an,rhs);    
  % gama=LUsol(LUdec(an),rhs);

  for i=1:m
    v(i) = cos(theta(i)-alpha);
    for j=1:mp1
        v(i) = v(i) +at(i,j)*gama(j) ;
        cp(i) = -(1- v(i)^2); % to flip the plot. thus, the actual value for Cp is the negative of this value. 
    end
  end
  % this subroutine solves a set of algebraic equations c(i,j)*x(j) = a(i),
  % i=1,2,...,N. it is taken from p.114 of chow (1979)
  figure; plot(x,cp,'-o');
  axis([0 1 min(cp) max(cp)]);
  xlabel('x/c'); ylabel('c_p'); title('c_p distribution'); 

end
