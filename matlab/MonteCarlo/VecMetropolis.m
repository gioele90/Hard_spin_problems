function [ solution ] = VecMetropolis(spins, Hparams, beta, timesteps, num_flips, Gamma, sigma ) 
%METROPOLIS Does Metropolis algorithm 
spinVecs = spins*pi/2;
    
for time = 1:timesteps
    newspins = spinVecs;
    indices_to_flip = randperm(length(spinVecs), num_flips).';
    s1=sin(newspins);
    %%PICK ONE OF THE BELOW
    
    % (1) Normally distributed angle choosing ---------------------------
    %newspins(indices_to_flip)=wrapToPi(normrnd(spinVecs(indices_to_flip).'+pi,sigma,num_flips,1));%DONT FORGET NEWSPINS ARE IN RADIANS!!!!
    
    %(2) Completely random new angle --------------------------------
    newspins(indices_to_flip)=((rand(num_flips,1)*2)-1)*pi/2;
    
    %DONT FORGET NEWSPINS ARE IN RADIANS!!!!
    sdiff=-s1+sin(newspins);
    p = transition_probability_vec(sdiff, indices_to_flip, newspins, Hparams, beta, Gamma, 'VecMetropolis'); %supposed to parse indices to flip, but can get that quickly from find(cdiff~=0)
    
    x = rand;
       
    if p > x
        spinVecs = newspins;
    end
solution = sign(spinVecs);
end