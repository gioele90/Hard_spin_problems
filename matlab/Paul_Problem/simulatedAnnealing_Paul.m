function[ solution ] = simulatedAnnealing_Paul(hamParams, spinConfig, initialTemp,...
    finalTemp, spinStepSize, iterations, scheduleType, flipsPerTemp)
%SIMULATED ANNEALING Runs the Simulated Annealing Algorithm given some 
%Hamiltonian parameters, an initial spin configuration, an initial
%temperature, a spin step Size (number of spins flipped at once), a number
%of iterations, a temperature schedule (either linear or exponential
%decrease) and a number of flips to do per temperature

temp = initialTemp;
kB = 1.38064852e-23;
tempStep = (initialTemp-finalTemp)/iterations;


%Perform metropolis steps whilst lowering the temperature linearly
%according to the tempStep parameter
tic;
for step=1:iterations
    if toc > 1
        fprintf('%d:%d\n',step,iterations);
        tic;
    end
    for flip=1:flipsPerTemp
        energy = ConfEnergy_Paul(hamParams, spinConfig);
        newSpinConfig = spinConfig;
        indices_to_flip = randperm(length(spinConfig), spinStepSize).';
        
        newSpinConfig(indices_to_flip)=- spinConfig(indices_to_flip);
        
        new_energy = ConfEnergy_Paul(hamParams, newSpinConfig);
        beta = 1/(kB * temp);
        deltaH = new_energy - energy;
        
        if deltaH <= 0
            prob = 1;
        else
            prob = 1 * exp(-deltaH * beta);
        end
        if prob >= rand(1)
            spinConfig = newSpinConfig;
        end
    end
    temp = anneal_schedule(scheduleType, temp, step, tempStep);
end

energy = ConfEnergy_Paul(hamParams, spinConfig );
solution = {energy, spinConfig};
end