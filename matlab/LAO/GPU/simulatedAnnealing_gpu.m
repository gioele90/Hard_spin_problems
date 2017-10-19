function[ solution ] = simulatedAnnealing_gpu(hamParams, spinConfig, initialTemp,...
    finalTemp, spinStepSize, iterations, scheduleType, flipsPerTemp)
%SIMULATED ANNEALING Runs the Simulated Annealing Algorithm given some 
%Hamiltonian parameters, an initial spin configuration, an initial
%temperature, a spin step Size (number of spins flipped at once), a number
%of iterations, a temperature schedule (either linear or exponential
%decrease) and a number of flips to do per temperature

temp = gpuArray(initialTemp);
kB = gpuArray(1.38064852e-23);
tempStep = gpuArray((initialTemp-finalTemp)/iterations);
[h, Jzz, ~, Jzzz, ~,Jzzzz,~] = deal(hamParams{:});

%Perform metropolis steps whilst lowering the temperature linearly
%according to the tempStep parameter
tic;
for step=1:iterations
%     if toc > 1
%         fprintf('%d:%d\n',step,iterations);
%         tic;
%     end
    for flip=1:flipsPerTemp
        newSpinConfig = spinConfig;
        indices_to_flip = gpuArray.randperm(length(spinConfig));
        indices_to_flip=indices_to_flip(1:2).';
       
%         for i = 1:length(indices_to_flip)
%             flip_index = indices_to_flip(i);
%             newSpinConfig(flip_index) = - spinConfig(flip_index);
%         end 
        
        newSpinConfig(indices_to_flip)=- spinConfig(indices_to_flip);
        
        beta = 1/(kB * temp);
        deltaH = energyChange_gpu(newSpinConfig, indices_to_flip, 1, 1, 1, h, Jzz, Jzzz,Jzzzz);
%         if deltaH <= 0
%             prob = 1;
%         else
%             prob = 1 * exp(-deltaH * beta);
%         end
        if gpuArray.rand(1)<= exp(- deltaH * beta)
            spinConfig = newSpinConfig;
%             if deltaH>0
%                 disp('Climbed');
%             end
        end
    end
    %disp(temp);
    temp = anneal_schedule(scheduleType, temp, step, tempStep);
end

energy = Conf_energy_gpu(spinConfig, hamParams);
solution = {energy, spinConfig};

end