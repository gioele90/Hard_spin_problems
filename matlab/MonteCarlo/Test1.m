% Hparams=generate_random_3local_hamiltonian(40,1,[-1 1],[-1 1]);
% spinConfig=generate_spins(40,0);
% betas=1:10;
% totalRuns=100;
% Gamma=1;
% num_flips=1;
[solution]=ParallelTempering( spinConfig, Hparams, betas, totalRuns, 'HeatBath', 100, Gamma, num_flips );