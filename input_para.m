%input parameters for government equation '-a*(d^2*u/dx^2)-c*u-f=0'
%written by Zhihao Liao
%for group project


function para=input_para

question='what is ae\n';
para.a=input(question);

question='what is ce\n';
para.c=input(question);

question='what is he\n';
para.h=input(question);

question='what is fe\n';
para.f=input(question);

end