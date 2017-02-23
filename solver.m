function U = solver(Q, F, K)
%SOLVER Solves the matrix equation
% Adds boundary condition vector, Q,to force vector, F, and performs matrix multiplication on it.
U = (F + Q)\K;
end
