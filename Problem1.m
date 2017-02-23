% Malcolm D. Forbes
% Created 2017 for C. Clahoun
% Homework 3

clear
clc
close all

% Problem 1
% Setup domain
RES = 10^3;
x = 0:1/RES:1;
f = sin(pi*x);
L = 1;

%Discretize domain
N1 = 1;
N2 = 2;
N3 = 3;
N10 = 10;

[x_e1, y_e1] = discretize(N1);
[x_e2, y_e2] = discretize(N2);
[x_e3, y_e3] = discretize(N3);
[x_e10, y_e10] = discretize(N10);

% Approximate y-values with quadratic shape function
y1 = approximate(N1, x_e1, y_e1, RES);
y2 = approximate(N2, x_e2, y_e2, RES);
y3 = approximate(N3, x_e3, y_e3, RES);
y10 = approximate(N10, x_e10, y_e10, RES);

% Post_processing
%x1 = 0:L/(2*N1):1;
%x2 = 0:L/(2*N2):1;
%x3 = 0:L/(2*N3):1;
%x10 = 0:L/(2*N10):1;

figure
hold on
plot(x, f)
plot(x, y1, '-o')
plot(x, y2, '-o')
plot(x, y3, '-o')
plot(x, y10, '-o')
%label('f(x)=sin(pi*x)', '1 element case', '2 element case', '3 element case', '10 element case') 
hold off