function [ deltaH ] = energyChange_gpu(new_spin_config, indices_to_flip, trotter_slices, J_orth, slice, h, Jzz, Jzzz, Jzzzz)

ediff = gpuArray(0);
n = gpuArray(length(new_spin_config(1,:)));

if h ~= 0
    ediff = sum( 2.0*h(indices_to_flip).*new_spin_config(slice,indices_to_flip)');
end

% 2 Local
if ~isempty(Jzz) && any(Jzz(:))
    for spin_index = 1:length(indices_to_flip)
        for neib_1 = 1:n
            if neib_1 ~= indices_to_flip(spin_index)
                ediff = ediff + 2.0*Jzz(indices_to_flip(spin_index), neib_1)*new_spin_config(slice,indices_to_flip(spin_index))*new_spin_config(slice,neib_1);
            end
        end
    end  
end

% 3 Local
if ~isempty(Jzzz) && any(Jzzz(:))
    qbts=1:n;
    for k = 1:length(indices_to_flip)
        for i =qbts(qbts~=indices_to_flip(k))
            for j = i+1:n
                ediff= ediff + sum(sum(2.0*Jzzz(indices_to_flip(k), i, j)...
                    .*new_spin_config(slice,indices_to_flip(k))...
                    .*new_spin_config(slice,i)...
                    .*new_spin_config(slice,j)));
            end
        end
    end
end

%4 Local
if ~isempty(Jzzzz) && any(Jzzzz(:))
    for spin_index = 1:length(indices_to_flip)
        for i = 1:n
            if i ~= indices_to_flip(spin_index)
                for j = (i+1):n
                    if j~=indices_to_flip(spin_index)
                        for k = (j+1):n
                            if k~=indices_to_flip(spin_index)
                            ediff = ediff + 2.0*Jzzzz(indices_to_flip(spin_index), i, j, k)...
                                *new_spin_config(slice,indices_to_flip(spin_index))...
                                *new_spin_config(slice,i)...
                                *new_spin_config(slice,j)...
                                *new_spin_config(slice,k);
                            end
                        end
                    end
                end
            end
        end
    end
end

if trotter_slices ~= 1
    if slice == 1;
        left = trotter_slices;
        right = 2;
    elseif slice == trotter_slices;
        left = trotter_slices - 1;
        right = 1;
    else
        left = slice - 1;
        right = slice +1;
    end
    
    ediff = ediff + sum(-2.0*J_orth*new_spin_config(slice, indices_to_flip).*new_spin_config(left, indices_to_flip));
    ediff = ediff + sum(-2.0*J_orth*new_spin_config(slice, indices_to_flip).*new_spin_config(right, indices_to_flip));
    
end

deltaH = ediff;
end


