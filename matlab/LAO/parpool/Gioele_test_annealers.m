function [timetoepsilon_SA,timetoepsilon_PIQMC] = Gioele_test_annealers()
num_spins=49;
num_loops=12;
num_problems=1000;
epsilon=4/num_spins;
lattice_length=round(sqrt(num_spins));
adj=nearestNeighbourAdj3local(lattice_length,lattice_length);
% adj=chimeraAdj(2,3);
loops=cell(1,num_loops);
timetoepsilon_SA=zeros(1,num_problems);
timetoepsilon_PIQMC=zeros(1,num_problems);

%% Annealing parameters
%2-local
init_temp_SA_2local=1e25;
final_temp_SA_2local=0;
spin_StepSize_SA_2local=1;
iterations_SA_2local=100;
flipsPerTemp_SA_2local=5;

iterations_PIQMC_2local=100;
trotterSlices_2local=30;
Ginitial_2local=1.5;
temperature_PIQMC_2local=0.05;
step_flips_PIQMC_2local=1;

%3-local
init_temp_SA_3local=1e25;
final_temp_SA_3local=0;
spin_StepSize_SA_3local=1;
iterations_SA_3local=100;
flipsPerTemp_SA_3local=5;

iterations_PIQMC_3local=100;
trotterSlices_3local=30;
Ginitial_3local=1.5;
temperature_PIQMC_3local=0.05;
step_flips_PIQMC_3local=1;

%4-local
init_temp_SA_4local=1e25;
final_temp_SA_4local=0;
spin_StepSize_SA_4local=1;
iterations_SA_4local=100;
flipsPerTemp_SA_4local=5;

iterations_PIQMC_4local=100;
trotterSlices_4local=30;
Ginitial_4local=1.5;
temperature_PIQMC_4local=0.05;
step_flips_PIQMC_4local=1;

%%

for k=1:num_problems
if mod(k,100)==0
disp(strcat('Problem ',int2str(k)));
end
counter_SA=zeros(1,100);
counter_PIQMC=zeros(1,100);
for i=1:num_loops
    loops{i}=random_walk_loop_3(adj);
end
spinconfig=(round(rand(1,num_spins)).*2-1);
h=-spinconfig.*4./num_spins;
[J,gs_energy]=planted_hamiltonian_3(spinconfig,loops);
hParams={h,0,0,J,0,0,0};
gs_energy=Conf_energy(spinconfig,hParams);
starting_conf=(round(rand(1,num_spins)).*2-1);
parfor i=1:100
solution_SA=simulatedAnnealing(hParams, starting_conf, init_temp_SA_3local, final_temp_SA_3local, ...
    spin_StepSize_SA_3local, iterations_SA_3local, 'exponential', flipsPerTemp_SA_3local);
if (solution_SA{1}-gs_energy)<epsilon
    counter_SA(i)=1;
end
solution_PIQMC=piqmc(starting_conf, hParams, iterations_PIQMC_3local, trotterSlices_3local,...
    Ginitial_3local, temperature_PIQMC_3local, step_flips_PIQMC_3local);
if (solution_PIQMC{1}-gs_energy)<epsilon
    counter_PIQMC(i)=1;
end
end
timetoepsilon_SA(k)=100*100/sum(counter_SA);
timetoepsilon_PIQMC(k)=100*100/sum(counter_PIQMC);
end
% filename=strcat(int2str(num_problems),'_problems_',int2str(num_spins),'_spins_','chimera',datestr(now,30),'.m');
% save(filename,'timetoepsilon_SA','timetoepsilon_PIQMC')
end