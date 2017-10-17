function [ Mout ] = symmetrize4local( Mout )
%SYMMETRIZE3LOCAL Sets diagonals to zero and keeps upper right
%tetrahedron of nxnxn matrix

sizeJzzzz = size(Mout);

%Self-interaction terms to 0
for i=1:sizeJzzzz(1)
    for j=1:sizeJzzzz(2)
        for k=1:sizeJzzzz(3)
            for l=1:1:sizeJzzzz(4)
                if i==j || j==k || k==l || i==l || i==k || j==l
                    Mout(i,j,k,l)=0;
                end
            end
        end
    end
end

%%Triangularize
for i = 1:sizeJzzzz(1)
    for j=i:sizeJzzzz(2)
        for k=j:sizeJzzzz(3)
            for l=k:sizeJzzzz(4)
                perm=perms([i,j,k,l]);
                m=1;
                while Mout(i,j,k,l)==0 && m<length(perm)
                    w=perm(m,1);
                    x=perm(m,2);
                    y=perm(m,3);
                    z=perm(m,4);
                    Mout(i,j,k,l)=Mout(w,x,y,z);
                    m=m+1;
                end
            end
        end
    end
end

for i = 1:sizeJzzzz(1)
    for j=i:sizeJzzzz(2)
        for k=j:sizeJzzzz(3)
            for l=k:sizeJzzzz(4)
                Mout(i,j,l,k)=Mout(i,j,k,l);
                Mout(i,k,j,l)=Mout(i,j,k,l);
                Mout(i,k,l,j)=Mout(i,j,k,l);
                Mout(i,l,k,j)=Mout(i,j,k,l);
                Mout(i,l,j,k)=Mout(i,j,k,l);
                
                Mout(j,k,l,i)=Mout(i,j,k,l);
                Mout(j,l,k,i)=Mout(i,j,k,l);
                Mout(k,j,l,i)=Mout(i,j,k,l);
                Mout(k,l,j,i)=Mout(i,j,k,l);
                Mout(l,k,j,i)=Mout(i,j,k,l);
                Mout(l,j,k,i)=Mout(i,j,k,l);
                
                Mout(k,l,i,j)=Mout(i,j,k,l);
                Mout(l,k,i,j)=Mout(i,j,k,l);
                Mout(j,l,i,k)=Mout(i,j,k,l);
                Mout(l,j,i,k)=Mout(i,j,k,l);
                Mout(k,j,i,l)=Mout(i,j,k,l);
                Mout(j,k,i,l)=Mout(i,j,k,l);
                
                Mout(l,i,j,k)=Mout(i,j,k,l);
                Mout(k,i,j,l)=Mout(i,j,k,l);
                Mout(l,i,k,j)=Mout(i,j,k,l);
                Mout(j,i,k,l)=Mout(i,j,k,l);
                Mout(j,i,l,k)=Mout(i,j,k,l);
                Mout(k,i,l,j)=Mout(i,j,k,l);
            end
        end
    end
end

end