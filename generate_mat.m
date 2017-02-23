%generate elemental stiffness matrix
%written by Zhihao Liao
%for group project

function ke=generate_mat(ae,ce,he)

ke=ae/he*[1 -1; -1 1]+ce*he/6*[2 1; 1 2];

end