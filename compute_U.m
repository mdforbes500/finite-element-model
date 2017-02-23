%compute U
%written by Zhihao Liao
%for group project

function U=compute_U

question='what is h?\n';
h=input(question);
n=1/h;

K=zeros(n+1,n+1);
f=zeros(n+1,1);
U=zeros(n+1,1);

m=1;
para=input_para;
for i=1:1:n;
    ke=generate_mat(para.a,para.c,para.h);
    f(m:m+1)=f(m:m+1)+para.f*[1; 1];
    K(m:m+1,m:m+1)=K(m:m+1,m:m+1)+ke;
    m=m+1;
end

question='what is Q1\n';
Q1=input(question);
question='what is Qn\n';
Qn=input(question);

f(2)=f(2)+Q1;
f(n+1)=f(n+1)+Qn;
U(2:n+1)=(K(2:n+1,2:n+1))\f(2:n+1);
U(1)=100;


K
f
end

