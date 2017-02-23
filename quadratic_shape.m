function y = quadratic_shape(x, x1, x2, x3, y1, y2, y3)
%QUADRATIC_SHAPE The quadratic shape function for FEA.
%	Creates three local variables- phi1, ph2, and phi3- that represent the shape
%	functions usedin the Galerkin method of approximation.
%	These are used to define a function, y.
phi_1 = ((x2 - x)*(x3 - x))/((x2 - x1)*(x3 - x1));
phi_2 = ((x1 - x)*(x3 - x))/((x1 - x2)*(x3 - x2));
phi_3 = ((x1 - x)*(x2 - x))/((x1 - x3)*(x2 - x3));

y = phi_1*y1 + phi_2*y2 + phi_3*y3;
end
