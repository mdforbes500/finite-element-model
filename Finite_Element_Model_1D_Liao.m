% Created by Malcolm D. Forbes
% Spring 2017

clc
clear
close all

% Script: 1D Finite Element Model

% Torsion

xA = 0; %global starting value
xB = 10; %global ending value
omega = linspace(xA, xB);
length = xB - xA;


%Discretize domain
N = 1000; %number of elements
    % Define Elemental properties for each partition
    %If there are extra partitions, create new elemental properties.
        
    %Partition 1
    for i=1:N
    d1=1;d2=2;
    d=(2*i-1)/(2*N)*d1+(2*N-2*i+1)/(2*N)*d2;    %the area of the beam changes
    %d=2;                                         %the area of the beam doesn't change
    G=79.3; 
    J=pi*d^4/32;
    a = G*J;
    c = 0;
    h = length/N;
    type = 1; %1 for linear, 2 for quadratic
    %Construct sample element for each partition
    element1 = Element(type, a, c, h);
    % Fill partition matrix with partition's sample element
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



T=10;

% Solve for unknowns
switch type
    case 1 
        % Apply boundary conditions from the problem statement.
        Q = zeros(N+1,1);Q(N+1)=T;
        F = zeros(N+1,1); 
        
        U = zeros(N+1,1); 
        U(2:N+1) = K(2:N+1,2:N+1)\(F(2:N+1) + Q(2:N+1)); 
    case 2 
        % Apply boundary conditions from the problem statement.
        Q = zeros(2*N+1,1);Q(2*N+1)=T;
        F = zeros(2*N+1,1);
        h=h/2;
        
        U = zeros(2*N+1,1); 
        U(2:2*N+1) = K(2:2*N+1,2:2*N+1)\(F(2:2*N+1) + Q(2:2*N+1)); 
end 
% Post-processing - change answer into relevant quatities.

    %Plotting data
    figure
    X=0:h:length;
    plot(X, U)
