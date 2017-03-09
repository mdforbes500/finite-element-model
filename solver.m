function U = solver(Q, F, K, N,type) 
%SOLVER Solves the matrix equation 
% Adds boundary condition vector, Q,to force vector, F, and performs matrix multiplication on it. 

switch type
    case 1 
        U = zeros(N+1,1); 
        U(2:N+1) = K(2:N+1,2:N+1)\(F(2:N+1) + Q(2:N+1)); 
    case 2 
        U = zeros(2*N+1,1); 
        U(2:2*N) = K(2:2*N+1,2:2*N+1)\(F(2:2*N+1) + Q(2:2*N+1)); 
end 
