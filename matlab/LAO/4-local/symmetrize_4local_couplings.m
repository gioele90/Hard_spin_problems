function [ Mout ] = symmetrize_4local_couplings( Jzzz )
%SYMMETRIZE_3LOCAL_COUPLINGS Sets diagonals to zero and keeps upper right
%tetrahedron of nxnxn matrix

sizeJzzz = size(Jzzz);
Mout = Jzzz;

% Pairwise terms to zero
for i = 1:sizeJzzz(1)   
    Mout(i,i,:,:)=0;
    Mout(:,i,i,:)=0;
    Mout(:,:,i,i)=0;
    Mout(i,:,i,:)=0;
    Mout(:,i,:,i)=0;
    Mout(i,:,:,i)=0;
%      for j = 1:sizeJzzz(2)
%          for k = 1:sizeJzzz(3)
%              for l = 1:sizeJzzz(4)
%                 if i == j || j == k || k == l || i == k || i == l || j == l
%                      Mout(i,j,k,l) = 0;
%                 end
%              end
%          end      
%      end
end

% Permutation symmetry
for i = 1:sizeJzzz(1)
    for j = 1:sizeJzzz(2)
        for k = 1:sizeJzzz(3)
            for l = 1:sizeJzzz(4)
                if Mout(i,j,k,l) ~= 0
                    perm=perms([i,j,k,l]);
                    for m=1:length(perm)
                        w=perm(m,1);
                        x=perm(m,2);
                        y=perm(m,3);
                        z=perm(m,4);
                        Mout(w,x,y,z) = Mout(i,j,k,l);
                    end
                end
            end    
        end        
    end
end
            
end

