% Define block size
block_size = 6;
no_blocks = 3;
no_qubits =18;

field_str = zeros([no_blocks 1] );

field_str(1) = 1;
field_str(2) = 0.2;
field_str(3) = -0.05;

%% Define the local fields.

h = zeros( [no_qubits 1]);  %Generates local fields vector.

for k = 1:no_blocks
    for i = ((k-1)*block_size +1):k*block_size
        h(i) = field_str(k);
    end
end
    

%% Define the 2-local interactions.

% Initalise empty matrix.
Jzz = zeros( no_qubits );

for k = 0:(no_blocks-1) 
    for i= 1+k*block_size:(k+1)*block_size
        for j = 1+k*block_size:(k+1)*block_size
            if i == j
                Jzz(i,j) = 0;
            else    
                Jzz(i,j) = -1;
            end
        end
    end     
end

%Jzz = randn(18,18).*Jzz;
Jzz = symmetrize_2local_couplings( Jzz);


%% Now define the 3-local interactions.

% Need to automate this.
Jzzz = zeros( no_qubits, no_qubits, no_qubits);   % Create empty tensor.

Jzzz( 2, 8, 14) = 2;
Jzzz( 4, 10, 16) = 2;
Jzzz( 2, 8, 14) = 2;

Jzzz = symmetrize_3local_couplings( Jzzz );

% Now define the Hamiltonian parameters.
Hparams    = {};
Hparams{1} = h;
Hparams{2} = [];
Hparams{2} = Jzz;
Hparams{4} = Jzzz;
Hparams{5} = [];


%Hparams = generate_random_2local_hamiltonian( no_qubits, 0.5, [-1,1], [-1,1] )

%% Run the problem.


%spinConfig = -ones([1 no_qubits]);

loop_length = 10;
solutions = {};
energies  = zeros( [loop_length 1]);
configs = {};

for i =1:loop_length
    disorder = round(no_qubits/2);
    spinConfig = generate_spins(no_qubits, disorder);
    temp_solution = Solver( spinConfig, Hparams, 'Metropolis' );
    energies(i) = temp_solution{1};
    configs{i} = temp_solution{2};
end

% This *should* be the optimal solution (as per the problem design). 
testConfig = -ones([1 no_qubits]);

Conf_energy(testConfig, Hparams)