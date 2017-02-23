function [x_e, y_e] = discretize( N )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
length = 1;
x_e = zeros(1, 2*N+1);
    for i = [2:2*N+1]
        x_e(i+1) = x_e(i) + 0.5*(length/N);
    end
y_e = zeros(1, 2*N+1);
    for i = [2:2*N+1]
        y_e = sin(pi*x_e);
    end
end

