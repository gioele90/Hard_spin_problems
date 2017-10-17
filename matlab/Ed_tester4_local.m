clear all

rng('default');
rng(1);


n=100;
indices_to_flip=[64];
Jzzzz=randn(n,n,n,n);
new_spin_config=((rand(1,n)>0.5).*2)-1;
ediff=0;
slice=1;
cc=0;
for spin_index = 1:length(indices_to_flip);
    for i = 1:n;
        if i ~= indices_to_flip(spin_index)
            for j = (i+1):n;
                if j~=indices_to_flip(spin_index)
                    for k = (j+1):n
                        if k~=indices_to_flip(spin_index)
                        ediff = ediff + 2.0*Jzzzz(indices_to_flip(spin_index), i, j,k)...
                            *new_spin_config(slice,indices_to_flip(spin_index))...
                            *new_spin_config(slice,i)...
                            *new_spin_config(slice,j)...
                            *new_spin_config(slice,k);
                        cc=cc+1;
                        end
                    end
                end
            end
        end
    end
end

ediff
ediff2=0;
c=0;
for spin_index = 1:length(indices_to_flip)
    combs=VChooseK([1:(indices_to_flip(spin_index) -1), (indices_to_flip(spin_index) +1):n],3);
    for i =1:size(combs,1)
        ediff2 = ediff2 + 2.0*Jzzzz(indices_to_flip(spin_index), combs(i,1), combs(i,2), combs(i,3))...
            *new_spin_config(slice,indices_to_flip(spin_index))...
            *new_spin_config(slice,combs(i,1))...
            *new_spin_config(slice,combs(i,2))...
            *new_spin_config(slice,combs(i,3));
        c=c+1;
    end
end

ediff2