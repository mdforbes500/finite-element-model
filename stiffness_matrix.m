function K_e = stiffness_matrix(type, a_e, c_e, h_e)
%STIFFNESS_MATRIX Generates an elemental coefficient matrix, K_e
% For linear approximation functions, use type 1.
% For quadratic approximation functions, use type 2.
 
 switch type
 case 1
  K_e = a_e/h_e.*[1 -1; -1 1] + c_e*h_e/6.*[2 1; 1 2];
 case 2
  K_e = a_e/(3*h_e).*[7 -8 1; -8 16 -8; 1 -8 7] + c_e*h_e/30.*[4 2 -1; 2 16 2; -1 2 4];
 end

end
