% Created by Malcolm D. Forbes
% Spring 2017

clc
clear
close all

% Script: 1D Finite Element Model

% Define domain
RES = 999; %resolution of approximation
xA = 0; %global starting value
xB = 1; %global ending value
omega = xA: 1/RES: xB;
length = xB - xA;

f_0 = 50; %Pa
mu_water = 1.12;
mu_lubricant = 0.3;

%Discretize domain
N = 50; %number of elements
    % Define Elemental properties for each partition
    %If there are extra partitions, create new elemental properties.
    
    %Partition 1 - the water in lower region
    a1 = mu_water;
    c1 = 0;
    h1 = length/N;
    type1 = 1; %1 for linear, 2 for quadratic
    %Construct sample element for each partition
    element1 = Element(type1, a1, c1, h1);
    % Fill partition matrix with partition's sample element
    for i = 1:(N/2)
        elements(i) = element1;
    end
    
    %Partition 2
    a2 = mu_lubricant;
    c2 = 0;
    h2 = length/N;
    type2 = 1; %1 for linear, 2 for quadratic
    %Construct sample element for each partition
    element2 = Element(type2, a2, c2, h2);
    % Fill partition matrix with partition's sample element
    for i = N/2:N
        elements(i) = element2;
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

if (element1.type_e ~= element2.type_e)
    error('Element types do not match. Please revise.')
else
    K = assembler(element1.type_e,K_e);
end

% Apply boundary conditions from the problem statement.
Q = zeros(N+1,1);
%Q(1) = f_0/length;
%Q(2*N+1) = -f_0/(length;

% Elemental force vector 
F_e = cell(1,N+1);
for i = 1:N+1
    F_e{i} = f_0*h1/2.*[1;1];
end

%Assembling the global force vector
F = zeros(N+1,1);
F(1) = F_e{1}(1);
F(N+1) = F_e{N}(2);
e = 1;
for i = 2:N
    F(i) = F_e{e}(2)+F_e{e+1}(1);
    e = e+1;
end

% Solve for unknowns
U = solver(element1, Q, F, K, N);

% Post-processing - change answer into relevant quatities.
x_e = zeros(1, N+1);
for i = 2:N+1
    x_e(i) = x_e(i-1)+h1;
end

for i = 1:500
    if N == 1
        u1(i) = quadratic_shape(omega(i),x_e(1),x_e(2), x_e(3), U(1), U(2), U(3));
    else
        for j = 2:N
            u1(i) = quadratic_shape(omega(i),x_e(j-1),x_e(j), x_e(j+1),U(j-1), U(j), U(j+1));
        end
    end
end 
for i = 1:500
    if N == 1
        u2(i) = quadratic_shape(omega(i),x_e(3),x_e(4), x_e(5), U(3), U(4), U(5));
    else
        for j = 2:N
            u2(i) = quadratic_shape(omega(i),x_e(j+1),x_e(j), x_e(j-1),U(j+1), U(j), U(j-1));
        end
    end
end 

    %Plotting data
    figure
    hold on
    %plot(omega(1:500), u1, '-b')
    %plot(omega(501:1000), u2, '-b')
    title('Velocity profile of two fluids')
    xlabel('y')
    ylabel('u(y)')
    plot (x_e, U, '-ob')
    hold off
