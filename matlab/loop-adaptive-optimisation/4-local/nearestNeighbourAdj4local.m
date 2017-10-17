function [ adj_mat ] = nearestNeighbourAdj4local( m,n )
%NEARESTNEIGHBOURADJ3LOCAL Creates the adjacency matrix for a 
%mxn grid of qubits with 4-local nearest
%neighbour interactions.

num_qubits = m * n;
adj_mat = zeros(num_qubits, num_qubits, num_qubits,num_qubits);

for i = 1:num_qubits
    if mod(i,n)==0
        trip = sort([i-n, i-1, i+n]);
        tripls = {trip};
    elseif mod(i,n)==1
        trip = sort([i-n, i+1, i+n]);
        tripls = {trip};
    else
        % Find the 4 triplets of qubits which, along with i, constitute a valid plaquette.
        trip1 = sort([i-1, i+1, i-n]);
        trip2 = sort([i-n, i-1,i+n]);
        trip3 = sort([i-1, i+n, i+1]);
        trip4 = sort([i+n, i+1, i-n]);
    
        tripls = {trip1, trip2, trip3, trip4};
    end
        good_tripls = {};
    
    for j = 1:length(tripls)
    
        tripl = tripls{j};
        conditions = [1 <= tripl(1); ...
                      tripl(1) <= num_qubits; ...
                      1 <= tripl(3); ...
                      tripl(3) <= num_qubits];
                  
        if all(conditions)
        
            good_tripls{end+1} = tripl;
        
        end
        
    end
    
    % Add to adjacency matrix
    for j = 1:length(good_tripls)
        
        tripl = good_tripls{j};
        adj_mat(i, tripl(1), tripl(2), tripl(3)) = 1;
        
    end
    
end

% Make invariant under perms

adj_mat = symmetrize_4local_couplings(adj_mat);

end

