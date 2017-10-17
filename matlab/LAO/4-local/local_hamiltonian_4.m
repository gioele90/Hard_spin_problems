function [J_local] = local_hamiltonian_4( solution, loop )
    % Given a loop (sequence of node triples), and solution (and spin configuration)
    % Calculate couplings, J that minimise the loop energy

    % Number of spins
    num_spins = length(solution);

    % Initialise local couplings matrix with zeros
    J_local = zeros(num_spins, num_spins, num_spins,num_spins);
    
    % Loop through triplets of nodes in loop
    for i = 1:length(loop)
        % Get node quartet
        quartet = sort(loop{i});
        % Set coupling to J = -s_1 s_2
        J_local(quartet(1),quartet(2),quartet(3),quartet(4)) = ...
            -solution(quartet(1))*solution(quartet(2))*solution(quartet(3))*solution(quartet(4));
    end
    
    % Flip one random coupling
    coupling_indicies = find(J_local);
    random_coupling = coupling_indicies(randi(length(coupling_indicies)));
    J_local(random_coupling) = -J_local(random_coupling);
    
end