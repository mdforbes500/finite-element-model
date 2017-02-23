function y = approximate( N, x_e, y_e, RES )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
x= 0:1/RES:1;
node = 2;
if 1 < node < 2*N+1
    for i = 1:RES+1
        y(i) = quadratic_shape(x(i), x_e(node-1), x_e(node), x_e(node+1), y_e(node-1), y_e(node), y_e(node+1));
    end
    node = node +1;
else
    y(1) = 0;
    y(2*N+1) = 0;
end

end

