function K = assembler(type, K_e)
%ASSEMBLER Assembles the global coefficient matrix
%   References the 'elements' array (which should be an array of elements
%   from the Element class. These each have the parameters specified.
switch type
    case 1 %for linear case
        K=zeros(length(K_e)+1,length(K_e)+1);
            for i=1:length(K_e)
                %assemble elemental matrix
                K(i:i+1,i:i+1)=K(i:i+1,i:i+1)+K_e{i};
            end
    
    case 2 %for quadratic case
     K=zeros(2*length(K_e)+1,2*length(K_e)+1);
     m=1;
        for i=1:1:length(K_e)
            %assemble elemental matrix
            K(m:m+2,m:m+2)=K(m:m+2,m:m+2)+K_e{i};
            m=m+2;
        end  
end
