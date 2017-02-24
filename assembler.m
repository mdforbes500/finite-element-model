function K = assembler(type,a,c,h)
%ASSEMBLER Assembles the global coefficient matrix

element = Element(type, a, c, h);
K_e=stiffness_matrix(element);

n=1/element.h_e;%n is the number of elements

if(element.type_e==1)%for linear case
    K=zeros(n+1,n+1);
    for i=1:n
        K(i:i+1,i:i+1)=K(i:i+1,i:i+1)+K_e;
    end   
    
elseif(element.type_e==2)%for quadratic case
    n=2*n;
    K=zeros(n+1,n+1);
    for i=1:2:n-1
        K(i:i+2,i:i+2)=K(i:i+2,i:i+2)+K_e;
    end   
    
end
