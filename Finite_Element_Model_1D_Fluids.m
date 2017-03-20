% Created by Malcolm D. Forbes
% Spring 2017

clc
clear
close all

% Script: 1D Finite Element Model

% Define domain
RES = 999;
xA = 0; %global starting value
xB = 1; %global ending value
omega = xA: 1/RES: xB;
length = (xB - xA);

f_0 = 50; %Pa
mu = 1.12;

%Discretize domain
N = 1; %number of elements
    % Define Elemental properties for each partition
    %If there are extra partitions, create new elemental properties.
    
    %Partition 1
    a = mu;
    c = 0;
    h = length/N;
    type = 2; %1 for linear, 2 for quadratic
    %Construct sample element for each partition
    element1 = Element(type, a, c, h);
    % Fill partition matrix with partition's sample element
    for i = 1:N
        elements(i) = element1;
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

K = assembler(element1.type_e,K_e);

% Apply boundary conditions from the problem statement.
Q = zeros(2*N+1,1);
Q(1) = f_0/2;
Q(2*N+1) = -f_0/2;

% Elemental force vector 
F_e = cell(2*N+1,1);
for i = 1:2*N+1
    F_e{i} = f_0*h/6.*[1;4;1];
end

%Assembling the global force vector
F = zeros(1,2*N+1);
F(1) = F_e{1}(1);
F(2) = F_e{1}(2);
F(2*N) = F_e{N}(2);
F(2*N+1) = F_e{N}(3);
for i = 3:2*N-1
    for e = 2:N
        F(i) = F_e{e-1}(3)+F_e{e-1}(1);
    end
end

% Solve for unknowns
U = solver(element1, Q, F, K, N);

% Post-processing - change answer into relevant quatities.
x_e = zeros(1, 2*N+1);
for i = 2:2*N+1
    x_e(i) = x_e(i-1)+h/2;
end

for i = 1:1000
    if N == 1
        u(i) = quadratic_shape(omega(i),x_e(1),x_e(2), x_e(3), U(1), U(2), U(3));
    else
        for j = 2:N
            u(i) = quadratic_shape(omega(i),x_e(j-1),x_e(j), x_e(j+1),U(j-1), U(j), U(j+1));
        end
    end
end

    %Plotting data
    func = (f_0*(length/2)^2)/(2*mu)*(1-((omega-0.5).^2/(length/2)^2));
    
    figure
    hold on
    title('Velocity profile of a single fluid')
    xlabel('y')
    ylabel('u(y)')
    %plot(0, omega, '-b', 'LineWidth', 1.0)
    %plot(1, omega, '-b', 'LineWidth', 1.0)
    plot(omega, func, '-r')
    plot( omega, u, '-b')
    hold off
