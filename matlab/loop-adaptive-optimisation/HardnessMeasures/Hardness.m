function [ metric ] = Hardness(Hparams, gs_energy, epsilon, beta, timeOut, num_runs, percOrMet, num_spins)
%HARDNESS Calculates hardness metric of some problem H.
% Metric is time to epsilon
% Generated by running Metropolis until some specified epsilon


switch percOrMet;
    case 'Met'
        % Track best energy, time and solution
        best_energy = realmax;
        best_time = realmax;
        best_solution = [];

        % Run n times, recording best solution and time taken
        for run = 1: num_runs

            % GENERATE RANDOM SPIN CONFIGURATION
            n_qubits = max([length(Hparams{1}),length(Hparams{2}), ...
                length(Hparams{3}),length(Hparams{4}),length(Hparams{5})]);
            spinConfig = generate_spins(n_qubits, round(n_qubits/2));

            % Run metropolis algorithm
            solution = infiniteMetropolis(spinConfig, Hparams, beta, gs_energy, epsilon, timeOut);
            time_elapsed = solution{3};

            % If time of last run is faster than any other previous, then update
            if time_elapsed < best_time
                best_energy = solution{1}; 
                best_time = time_elapsed;
                best_solution = solution;
            end
        end       

        % Calculate energy deficit from ground state
        deficit = (best_energy-gs_energy);

        if strcmp(best_solution{4}, 'TIMEOUT')
            metric = {best_time, deficit, 'TIMEOUT'};
        else   
            metric = {best_time, deficit, 'TTS'};
        end
        
    case 'Perc'
        metric = {1 - laoPercFindGroundState(Hparams, num_spins, 'SimulatedAnnealing', 100, gs_energy, epsilon, 0), 0, 'TTS'};
end
end
