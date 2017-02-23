classdef Element
%ELEMENT   An element in finite element analysis.

 properties
  a_e
  c_e
  h_e
  type_e
 end %independent properties

 properties (Dependent)
  K_e
 end %dependent properties

 methods
    function element = Element(type, a, c, h)
    %ELEMENT The constructor for the element class
        if type == 1 || type == 2 
            element.type_e = type;
        else
            error('Type must be a 1 or 2')
        end
    element.a_e = a;
    element.c_e = c;
    element.h_e = h;
    end %Element constructor

    function K_e = stiffness_matrix(element)
    %STIFFNESS_MATRIX Generates an elemental coefficient matrix, K_e
    % For linear approximation functions, use type 1.
    % For quadratic approximation functions, use type 2.
        switch element.type_e
            case 1
                K_e = element.a_e/element.h_e.*[1 -1; -1 1] + element.c_e*element.h_e/6.*[2 1; 1 2];
            case 2
                K_e = element.a_e/(3*element.h_e).*[7 -8 1; -8 16 -8; 1 -8 7] + element.c_e*element.h_e/30.*[4 2 -1; 2 16 2; -1 2 4];
        end
    end %stiffness_matrix
 end %methods block
end %Element class
