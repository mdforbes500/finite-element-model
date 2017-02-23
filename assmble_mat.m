%assemble elemental stiffness matrix to the global stifness matrix
%written by Zhihao Liao
%for group project

function K=assmble_mat

question='what is h?\n';
h=input(question);
n=1/h;
%input the number of elements

K=zeros(n+1,n+1);

m=1;
para=input_para;

for i=1:1:n;
    ke=generate_mat(para.a,para.c,para.h);
    K(m:m+1,m:m+1)=K(m:m+1,m:m+1)+ke;
    %put the elemental matrix into the right place of the global matrix
    m=m+1;
end