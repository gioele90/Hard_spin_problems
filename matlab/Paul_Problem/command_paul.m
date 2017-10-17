% Command file to run Paul's problem.

no_qubits = 20;
order = 5;
rank = 7;
no_couplers = rank*no_qubits/order;

% Initially generate matrix to specify Hamiltonian.
order_rank_matrix = order_rank_matrix_generator(no_qubits, order, rank);
no_of_minuses = floor(length(order_rank_matrix(1,:))/2);
H_params = H_param_generator( order_rank_matrix, no_of_minuses);

%% Generate a random spin configuration and then solve. 

loop_length = 5;
solutions = {};
energies  = zeros([loop_length 1]);
configs = {};

for i =1:loop_length
    disorder = round(no_qubits/2);
    spinConfig = generate_spins(no_qubits, disorder);
    temp_solution = Solver_Paul( spinConfig, H_params, 'SimulatedAnnealing' );
    energies(i) = temp_solution{1};
    configs{i} = temp_solution{2};
end
