function [ solution ] = H_param_generator( matrix, no_of_minuses)

no_couplers = length( matrix(1,:) );

%Randomly generate a number of coupling terms to become minus.
couplers_to_flip = randi([1 no_couplers],1, no_of_minuses);

%Now set these terms to be minus in the H_params matrix.
for i= 1:no_couplers
    if any(i == couplers_to_flip)
        index_to_flip = find(matrix(:, i), 1 );
        matrix( index_to_flip, i ) = -1;
    end
end

solution = matrix;
end