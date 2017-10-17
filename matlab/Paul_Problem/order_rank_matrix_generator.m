function[ solution ] = order_rank_matrix_generator(no_qubits, order, rank)
%Create the matrix that defines the Hamiltonian. The rows represent the
%qubits and the columns the couplers. We want every qubit to have a fix
%number of interactions and each coupler a fixed order (i.e. k-locality).


no_couplers = rank*no_qubits/order;

if ~isequal(fix(no_couplers), no_couplers)
    error( 'The number of couplers is not an integer. Please input valid values.' )
end

% Initially generate a matrix at least size n x r (this will almost
% certainly need to be extended.
matrix = zeros([no_qubits, ceil(no_couplers)]);

%% Now fill in the matrix iteratively.
%Need to make sure that the same element is not selected twice. Still get
%columns with all zero values -- not sure why...
for k = 1:no_couplers
    logical_assign = randi([1 no_qubits],1,order);                  %Randomly choose rows to make non-zero.
    while length(logical_assign) ~= length(unique(logical_assign))
        logical_assign = randi([1 no_qubits],1,order);  
    end
    %if length(logical_assign) == length(unique(logical_assign));    %Ensure indices are not repeated.
    for i = 1:no_qubits
        if any(i == logical_assign)
            matrix( i, k ) = 1; 
        end
    end
    %else
    %    k = k -1;  %Go back a loop.
    %end
end


% Now redistribute the values so that no row has a rank that is too high.
%Maybe write a function for this.

%First check that the matrix does not have all rows summing up to the
%required rank.

while ~is_valid_matrix( matrix, rank , order )
    matrix = matrix_row_distribution( matrix, rank , order );
end

solution = matrix;

end