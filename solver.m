function U = solver(Q, F, K)
%SOLVER Solves the matrix equation
% Adds boundary condition vector, Q,to force vector, F, and performs matrix multiplication on it.
switch element1.type_e
    case 1
        U = zeros(1,N+1);
        U(2:N) = (F(2:N) + Q(2:N))/K(2:N, 2:N);
    case 2
        U = zeros(1,2*N+1);
        U(2:2*N) = (F(2:2*N) + Q(2:2*N))/K(2:2*N, 2:2*N);
end
