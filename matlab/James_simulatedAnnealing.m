function[ solution ] = James_simulatedAnnealing(hamParams, spinConfig, initialTemp,...
    finalTemp, spinStepSize, iterations, scheduleType, flipsPerTemp, energy_limit)
%SIMULATED ANNEALING Runs the Simulated Annealing Algorithm given some 
%Hamiltonian parameters, an initial spin configuration, an initial
%temperature, a spin step Size (number of spins flipped at once), a number
%of iterations, a temperature schedule (either linear or exponential
%decrease) and a number of flips to do per temperature

temp = initialTemp;
kB = 1.38064852e-23;
tempStep = (initialTemp-finalTemp)/iterations;
[h, Jzz, ~, Jzzz, ~] = deal(hamParams{:});

temp_energy = [];
temp_energy(1) = Conf_energy(spinConfig, hamParams);
count = 1;

%Perform metropolis steps whilst lowering the temperature linearly
%according to the tempStep parameter
tic;
for step=1:iterations
    if toc > 1
        fprintf('%d:%d\n',step,iterations);
        tic;
    end
    for flip=1:flipsPerTemp
        newSpinConfig = spinConfig;
        indices_to_flip = randperm(length(spinConfig), spinStepSize).';
       break
%         for i = 1:length(indices_to_flip)
%             flip_index = indices_to_flip(i);
%             newSpinConfig(flip_index) = - spinConfig(flip_index);
%         end 
        
        newSpinConfig(indices_to_flip)=- spinConfig(indices_to_flip);
        
        beta = 1/(kB * temp);
        deltaH = energyChange(newSpinConfig, indices_to_flip, 1, 1, 1, h, Jzz, Jzzz);
        if deltaH <= 0
            prob = 1;
        else
            prob = 1 * exp(-deltaH * beta);
        end
        if prob >= rand(1)
            spinConfig = newSpinConfig;
            count = count + 1;
            temp_energy(count) = Conf_energy(spinConfig, hamParams);
            
            if temp_energy(count) <= energy_limit
                solution = {temp_energy(count), spinConfig);
                return 
            end
        end
    end
    temp = anneal_schedule(scheduleType, temp, step, tempStep);
end

energy = Conf_energy(spinConfig, hamParams);
solution = {energy, spinConfig};

end