function [ solution ] = Solver( spinConfig, Hparams, SolverType )
%SOLVER Solves some Hamiltonian given an initial input spin configuration,
%Hamiltonian parameters and solution algorithm.

%% DEFAULT PARAMETERS

% Metropolis
beta_M = 100000;
timesteps_M = 100;
num_flips_M = 3;
Gamma_M = 1;

% Heat Bath
beta_HB = 10000;
timesteps_HB = 5000;
Gamma_HB = 1;

%Simulated Annealing
initialTemp_SA = 1e10;
spinStepSize_SA = 5;
iterations_SA = 10;
scheduleType_SA = 'linear';
flipsPerTemp_SA = length(spinConfig)/4;
finalTemp_SA = 0;

% ParallelTempering
betas_PT = choose_betas_PT(1, 1e20, 10);
totalRuns_PT = 100;
backendMonty_PT = 'Metropolis';
sweepsMonty_PT = 1;
Gamma_PT = 1;
num_flips_PT = 1;

% Path Integral Quantum Monte Carlo
monte_steps = 10;
trotter_slices = 30;
G_start = 1.5;
Temperature = 0.1;
step_flips = 5;

%% SOLVE

switch SolverType
    case 'Metropolis'
        solution_config = Metropolis(spinConfig, Hparams, beta_M, timesteps_M, num_flips_M, Gamma_M);
        solution_energy = Conf_energy(solution_config, Hparams);
        solution = {solution_energy, solution_config};
    case 'HeatBath'
        solution_config = HeatBath(spinConfig, Hparams, beta_HB, timesteps_HB, Gamma_HB);
        solution_energy = Conf_energy(solution_config, Hparams);
        solution = {solution_energy, solution_config};
    case 'SimulatedAnnealing'
        solution = simulatedAnnealing(Hparams, spinConfig, initialTemp_SA, finalTemp_SA,...
            spinStepSize_SA, iterations_SA, scheduleType_SA, flipsPerTemp_SA);
    case 'ParallelTempering'
        solution = ParallelTempering(spinConfig, Hparams, betas_PT, totalRuns_PT, ...
                                        backendMonty_PT, sweepsMonty_PT, Gamma_PT, num_flips_PT);
    case 'PIQMC'
        solution = piqmc(spinConfig, Hparams, monte_steps, trotter_slices, G_start, Temperature, step_flips);
    otherwise
        disp('Enter valid Monte Carlo Algorithm')


end

