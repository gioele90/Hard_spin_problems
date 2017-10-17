clear all

rng('default');
rng(1);


n=100;
indices_to_flip=[56];
Jzzz=randn(100,100,100);
new_spin_config=((rand(1,100)>0.5).*2)-1;
ediff=0;
slice=1;



qbts=1:n;
% for k = 1:length(indices_to_flip)
% for i =qbts(qbts~=indices_to_flip(k))
%     for j = i+1:n
%         ediff= ediff + sum(sum(2.0*Jzzz(indices_to_flip(k), i,j).*new_spin_config(slice,indices_to_flip(k)).*new_spin_config(slice,i).*new_spin_config(slice,j)));
%     end
% end
% end
% ediff


c=0;
% %
for spin_index = 1:length(indices_to_flip);
    for neib_1 = 1:n;
        if neib_1 ~= indices_to_flip(spin_index)
            for neib_2 = (neib_1+1):n;
                if neib_2~=indices_to_flip(spin_index) 
                    ediff = ediff + 2.0*Jzzz(indices_to_flip(spin_index), neib_1, neib_2)*new_spin_config(slice,indices_to_flip(spin_index))*new_spin_config(slice,neib_1)*new_spin_config(slice,neib_2);
                c=c+1;
                end
            end
        end
    end
end
ediff

ediff2=0;
for spin_index = 1:length(indices_to_flip)
    combs=nchoosek([1:(indices_to_flip(spin_index) -1), (indices_to_flip(spin_index) +1):n],2);
    for i =1:size(combs,1)
        ediff2 = ediff2 + 2.0*Jzzz(indices_to_flip(spin_index), combs(i,1), combs(i,2))...
            *new_spin_config(slice,indices_to_flip(spin_index))...
            *new_spin_config(slice,combs(i,1))...
            *new_spin_config(slice,combs(i,2));
    end
end
ediff2