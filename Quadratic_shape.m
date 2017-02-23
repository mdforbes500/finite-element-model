function y = Quadratic_shape(x, x1, x2, x3, y1, y2, y3)
%QUADRATIC_SHAPE The quadratic shape function for FEA.
%	Creates three local variables- phi1, ph2, and phi3- that represent the shape
%	functions usedin the Galerkin method of approximation.
%	These are used to define a function, y.
phi_1 = 
phi_2 =
phi_3 =

y = phi_1*y1 + phi_2*y2 + phi_3*y3;
end