function [ deltaH ] = energyChange_Paul(new_spin_config, indices_to_flip, trotter_slices, J_orth, slice, H_params)

    ediff = 0;
    n = length(new_spin_config(1,:));
    
    ediff = ConfEnergy_Paul( H_params, new_spin_config ) - ConfEnergy_Paul( ( H_params, new_spin_config ) );
    
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
%         for spin_index = 1:length(indices_to_flip);
%             ediff = ediff + -2.0*J_orth*new_spin_config(slice, indices_to_flip(spin_index))*new_spin_config(left, indices_to_flip(spin_index));
%             ediff = ediff + -2.0*J_orth*new_spin_config(slice, indices_to_flip(spin_index))*new_spin_config(right, indices_to_flip(spin_index));
%         end
        ediff = sum(-2.0*J_orth*new_spin_config(slice, indices_to_flip).*new_spin_config(left, indices_to_flip));
        ediff = ediff + sum(-2.0*J_orth*new_spin_config(slice, indices_to_flip).*new_spin_config(right, indices_to_flip));

    end
    
    deltaH = ediff;
end
    
        
        