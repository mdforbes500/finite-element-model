function K = assembler(type,n)
%ASSEMBLER Assembles the global coefficient matrix

if(type==1)%for linear case
    K=zeros(n+1,n+1);
        for i=1:n
            question='please input ae\n';
            a(i)=input(question);
            question='please input ce\n';
            c(i)=input(question);
            question='please input he\n';
            h(i)=input(question);
            %input parameters, in case a,c,h for each element is different
            element(i)= Element(type, a(i), c(i), h(i));
            K_e=stiffness_matrix(element(i));
            K(i:i+1,i:i+1)=K(i:i+1,i:i+1)+K_e;
            %assemble elemental matrix
        end
    
elseif(type==2)%for quadratic case
     n=2*n;
     K=zeros(n+1,n+1);
        for i=1:2:(n-1)
            k=(i+1)/2;
            question='please input ae\n';
            a(k)=input(question);
            question='please input ce\n';
            c(k)=input(question);
            question='please input he\n';
            h(k)=input(question);
            %input parameters, in case a,c,h for each element is different
            element(k)= Element(type, a(k), c(k), h(k));
            K_e=stiffness_matrix(element(k));
            K(i:i+2,i:i+2)=K(i:i+2,i:i+2)+K_e;
            %assemble elemental matrix
        end  
    
end
