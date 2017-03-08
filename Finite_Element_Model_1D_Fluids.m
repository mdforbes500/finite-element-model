% Created by Malcolm D. Forbes
% Spring 2017

clc
clear
close all

% Script: 1D Finite Element Model

% Define domain
xA = -0.5; %global starting value
xB = 0.5; %global ending value
omega = linspace(xA, xB);
length = xB - xA;

pressure_diff = 50*10^6; %Pa

%Discretize domain
N = 1; %number of elements
    % Define Elemental properties for each partition
    %If there are extra partitions, create new elemental properties.
    
    %Partition 1
    a = 1.12*10^-3;
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
Q = zeros(1,2*N+1);
Q(1) = pressure_diff/length;
Q(2*N+1) = -pressure_diff/length;

% Elemental force vector 
F_e = cell(1,2*N+1);
for i = 1:2*N+1
    F_e{i} = pressure_diff*h/6*.[1;4;1];
end

%Assembling the global force vector
F = zeros(1,2*N+1);
F(1) = F_e{1}(1);
F(2) = F_e{1}(2);
F(2*N) = F_e{N}(2);
F(2*N+1) = F_e{N}(3);
for i = 3:2*N-1
    F(i) = F_e{i-2}(i)+F_e{i-1}(i-2);
end

% Solve for unknowns
U = solver(Q, F, K);

% Post-processing - change answer into relevant quatities.

    %Plotting data
    figure
    plot(X, U, '-ob')
