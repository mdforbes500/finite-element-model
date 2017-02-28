% Created by Malcolm D. Forbes
% Spring 2017

clc
clear
close all

% Script: 1D Finite Element Model

% Define domain
xA = 0; %global starting value
xB = 1; %global ending value
omega = linspace(xA, xB);
length = xB - xA;

%Discretize domain
N = 10; %number of elements
    % Define Elemental properties for each partition
    %If there are extra partitions, create new elemental properties.
    
    %Partition 1
    a = 1;
    c = 1;
    h = 1;
    type = 1; %1 for linear, 2 for quadratic
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
%Q = [];
%F = [];

% Solve for unknowns
%U = solver(Q, F, K);

% Post-processing - change answer into relevant quatities.

    %Plotting data
    %figure
    %plot(X, U, '-ob')
