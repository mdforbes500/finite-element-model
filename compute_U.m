%compute U
%written by Zhihao Liao
%for group project

function U=compute_U

K=assmble_mat;
n=length(K)-1;
f=zeros(n+1,1);
U=zeros(n+1,1);

m=1;
para=input_para;
for i=1:1:n;
    f(m:m+1)=f(m:m+1)+para.f*[1; 1];
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


end

