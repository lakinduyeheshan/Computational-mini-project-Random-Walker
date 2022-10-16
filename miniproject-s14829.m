%miniproject ECL S14829 

clear all;
close all;
clc;
 
P=0;
 
for k= 1:100
  
h=0.0025;
t0=0;  %starting t value
tf=5;  %ending t value
x0=1;   %initial value for x
y0=1;   %initial value for y

n= (tf-t0)/h;  %number of step
f1=@(t,y) y*t;  %define f1
f2=@(t,x) 0.9*x*t;  %define f2 

%initial condition
t(1)=t0;
x(1)=x0;
y(1)=y0;



%plot(t,y,"r-"); %f1 graph 
hold on;
%plot(t,x,"b-");;%f2 graph 
hold off;
%legend("f1","f2");



%Random Walk 

mx0=100;  %initial condition for walker x values 
my0=100;  %initial condition for walker y value 

p1=0.2;   % probability to move towards west and southwest 
p2=0.1;   %Its probability to move other direction
d1=0.2;   %step size for WEST and WESTSOUTH
d2=0.1;   %step size for othe direction

mx=mx0; my=my0;


function N= Tnorth(my,fac);
  my=my+fac;
  N=my;
end

function S= Tsouth(my,fac);
  my=my-fac;
  S=my;
end

function E= Teast(mx,fac);
  mx=mx+fac;
  E=mx;
end

function W= Twest(mx,fac);
  mx=mx-fac;
  W=mx;
end

for i= 1:n
  
 
  mr=rand;
  if (0<=mr) && (mr<p1) %probability goes to 0 to 0.2
    mx=Twest(mx,d1);
   
     elseif (p1<=mr)&& (mr<2*p1)   %probability goes to 0.2 to 0.4
    mx=Twest(mx,d1);
    my=Tsouth(my,d1);

     elseif (2*p1<=mr)&& (mr<2*p1+p2)  %probability goes to 0.4 to 0.5
    my=Tsouth(my,d2);
    
     elseif (2*p1+p2<=mr)&& (mr<2*p2+2*p1)  %probability goes to 0.5 to 0.6
    mx=Teast(mx,d2);
    my=Tsouth(my,d2);
    
     elseif ((2*p2+2*p1)<=mr)&& (mr<3*p1+p2)  %probability goes to 0.6 to 0.7
    mx=Teast(mx,d2);
    
     elseif ((3*p1+p2)<=mr)&& (mr<3*p1+2*p2)  %probability goes to 0.7 to 0.8
    mx=Teast(mx,d2);
    my=Tnorth(my,d2);
    
     elseif ((3*p1+2*p2)<=mr)&& (mr<3*p1+3*p2)  %probability goes to 0.8 to 0.9
    my=Tnorth(my,d2);
    
   
     elseif ((3*p1+3*p2)<=mr)&& (mr<3*p1+4*p2)  %probability goes to 0.9 to 1
    mx=Twest(mx,d2);
    my=Tnorth(my,d2);
    
  endif
  
  k1= h* f1(t(i),y(i));
  k2= h* f1(t(i)+ h,y(i)+k1);  
  
  k3= h* f2(t(i),x(i));
  k4= h* f2(t(i)+ h,x(i)+k3);
  
  y(i+1)= y(i) + (1/2)*(k1+k2);
  x(i+1)=x(i) + (1/2)*(k3+k4);
  t(i+1)= t(i)+ h;
  
  if (x(i+1)>100|| y(i+1)>100)
    break
  endif
  
plot(mx,my,"gs");
hold on;


endfor

hold on;
plot(x,y,"bs");
hold off;
grid on;
  
% Question 5 ---------------------------------------------------------

for  i=1:length(x)
  
var_x(i)= mx;
var_y(i)= my;



%euclidean equation for calculate the minimum distance 

dist= abs(sqrt((var_x(i)-x(i))^2 + (var_y(i)-y(i))^2));
distance(i)=dist;

endfor



% Question 7-----------------------------------------------------------

if min(distance)<=20
  P=P+1;
endif


minimum_distance=min(distance);
minimum_distance_array(k)=min(distance);

m1=mean(minimum_distance_array);
s1=std(minimum_distance_array);

endfor


