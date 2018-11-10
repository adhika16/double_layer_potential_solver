%% DOUBLE LAYER POTENTIAL SOLVER FOR 2D AIRFOIL
% name    : DLPS_2D 
% author  : 
% date    : 10 November 2018
% version : 1.0

%% clearing display and variables 
clc; clear all; 
% fprintf('\t \t Starting program...\n')
fprintf('\t \t Double layer potential solver for 2D airfoil\n')
fprintf('\t \t \t \t version 1.0\n\n')
%% main program
[xb,yb,m,mp1,Uinf,alpha] = read_data();
[x,y,s,theta,sine,cosine,rhs] = geom_parameter(xb,yb,m,alpha);
[gama,cp] = calculate_gamma(xb,yb,x,y,s,theta,sine,cosine,rhs,m,mp1,alpha);
[xt,yt,thetat,nPoint] = create_domain();
[vx,vy] = calculate_domain_velocity(nPoint,m,x,y,xt,yt,xb,yb,theta,thetat,sine,cosine,s,gama,alpha,Uinf);
fprintf('... done!\n');