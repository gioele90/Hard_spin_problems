function [ p ] = transition_probability(sindifferences, oldspin, newspin, Hparams, beta, Gamma, Monty)
%TRANSITION_PROBABILITY Calculates transition probability between two spins
%for some hamiltonian at a temperature T.

%Probability for a transition to an higher energy config

switch Monty
    case 'VecMetropolis'
        [h, Jzz, ~, Jzzz, ~,Jzzzz,~] = deal(Hparams{:});
        indeces_to_flip = oldspin;
        sdiff=sindifferences;
        deltaH = energyChangeVec(newspin,sdiff, 1, 1, 1, h, Jzz, Jzzz,Jzzzz);
        if deltaH <= 0
            p = Gamma;
        else
            p = Gamma * exp(-deltaH * beta);
        end

    otherwise
        disp('Monty must be a VecMetropolis')
end

