function [ solution ] = ConfEnergy_Paul( H_params, Spin_Config )

% Calculates the energy of the configuration using Paul's matrix
% construction.

no_couplers = length( H_params(1,:) );
energy = 0;

for i = 1:no_couplers
    energy = energy + prod( nonzeros(H_params(:, i).*(Spin_Config.')) );
end

solution = energy;
end