% Created by Malcolm D. Forbes
% Spring 2017

clc
clear
close all

% Script: 1D Finite Element Model

% Define domain
RES = 999;
xA = 0; %global starting value
xB = 1; %meter %global ending value
omega = xA: 1/RES: xB;
length = xB - xA;

% Parameters
A = 1; %meteres squared
p = 4; %meters
beta = 10; % Watts/(meter squared - K)
k = 200*omega+50; %conductance as a function along the length of the wall
%k = 200./(1+exp(-1.*omega));
T_inf = 60+273.15; %Kelvins

%Discretize domain
N = 3; %number of elements
    % Define Elemental properties for each partition
    %If there are extra partitions, create new elemental properties.
    h = length/N;
    x_nodes = zeros(1,N+1);
    for i=2:N+1
        x_nodes(i) = x_nodes(i-1)+ h;
    end
    
    T = zeros(N+1,1);
    for i =1:N+1
        T(i) = 40*(x_nodes(i)^2)-90*(x_nodes(i))+ 250 + 273; 
        %quadratic equation generated using three points
    end    
    
    %Midpoints for each element
    for i = 2:N+1
        x_mid(i) = x_nodes(i-1) + h/2;
    end
    
    k_avg = 200*x_mid+50.2; %vector 
    %left the linear gradient alone
    
    %Partition 1 - Same material throughout
    a = k_avg*A; %vector
    %c = A*p*beta;
    c = 0;
    type = 1; %1 for linear, 2 for quadratic
    
    %Construct sample element for each partition
    % Fill partition matrix with partition's sample element
    for i = 1:N
        elements(i) = Element(type, a(i+1), c, h);
    end
    
% Build elemental stiffness matrices for all elements, and store it in a
% cell K_e for retreival in assembly.
% Run this algorithm for each partition.

    %Partition 1
    K_e = cell(1,N);
    for i = 1:N
        K_e{i} = stiffness_matrix(elements(i));
    end

% Build global stiffness matrix from elemental stiffness matrices.
%This process is independent of partitions, as all elements of the mesh
%must be included to approximate solution.

K = assembler(elements(1).type_e,K_e);

% Apply boundary conditions from the problem statement.

Q = zeros(N+1,1);
%T = zeros(N+1,1);
%T(1) = 250+273.15; %Kelvins
        
%Q(N+1,1) = beta*A*T_inf + Q(N+1,1); %Watts
       
% Solve for unknowns
switch elements(i).type_e
    case 1
        Q = K*T;
        %K(N+1,N+1) = K(N+1,N+1)+beta*A;
        %U(2:N+1) = inv(K(2:N+1, 2:N+1))*Q(2:N+1);
   % case 2
   %     U = zeros(1,2*N+1);
   %     U(2:2*N) = (Q(2:2*N))\K(2:2*N, 2:2*N);
end

% Post-processing - change answer into relevant quatities.
for i = 1:RES+1
    if N == 1
        u(i) = Linear_shape(omega(i), x_nodes(1), x_nodes(2), Q(1), Q(2));
    else
        for j = 2:N
            u(i) = Linear_shape(omega(i),x_nodes(j-1),x_nodes(j),Q(j-1), Q(j));
        end
    end
end

    %Plotting data
    figure
    plot(omega, u, '-b')
%END SCRIPT
