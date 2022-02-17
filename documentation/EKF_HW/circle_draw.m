function circle_draw(center,radius,color)
% axis([0 5 0 5]);
% hold on;
 THETA=linspace(0,2*pi,360);
 rho=ones(1,360)*radius;
 [x,y]=pol2cart(THETA,rho);
 x=x+center(1);
 y=y+center(2);
 plot(x,y,color);
 axis square;
 box on;
 grid on;
 
 