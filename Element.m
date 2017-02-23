classdef Element()
%ELEMENT   An element in finite element analysis.

properties
a_e
c_e
h_e
type_e
end

properties (dependent)
K_e
end

function element = Element(type, a, c, h)
%ELEMENT The constructor for the element class
type_e.element = type;
a_e.element = a;
c_e.element = c;
h_e.element = h;
end

function K_e = stiffness_matrix(element)
%STIFFNESS_MATRIX Generates an elemental coefficient matrix, K_e
% For linear approximation functions, use type 1.
% For quadratic approximation functions, use type 2.
 switch element.type_e
 case 1
  K_e = element.a_e/element.h_e*.[1 -1; -1 1] + element.c_e*element.h_e/6*.[2 1; 1 2];
 case 2
  K_e = element.a_e/(3*element.h_e)*.[7 -8 1; -8 16 -8; 1 -8 7] + element.c_e*element.h_e/30*.[4 2 -1; 2 16 2; -1 2 4];
 end
end
