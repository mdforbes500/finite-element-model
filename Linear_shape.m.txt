function y = Linear_shape(x, x1, x2, y1, y2)
%LINEAR_SHAPE The linear shape function for FEA.
%   Creates two local variables, phi1 and phi2, that represent the shape
%   functions used in the Galerkin method of approximation. 
%   These are then used to define a line, y.
phi_1 = 1 - (x- x1)/(x2 - x1);
phi_2 = (x - x1)/(x2 - x1);

y = phi_1*y1 + phi_2*y2;
end

