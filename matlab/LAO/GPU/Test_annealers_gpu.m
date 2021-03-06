function problems=Test_annealers_gpu(locality,nspins,nloops,nprobs)
t=tic();
%rng(1); %Seed random number generator
loc=locality;
num_spins=nspins;
num_loops=nloops;
num_problems=nprobs;
epsilon=4/num_spins;
loops=cell(1,num_loops);
problems.locality=loc;
problems.nloops=num_loops;
problems.nproblems=num_problems;
problems.hamiltonian=cell(1,num_problems);
problems.coupledspins=zeros(1,num_problems);
problems.gs=zeros(1,num_problems);
problems.timeSA=zeros(1,num_problems);
problems.timePIQMC=zeros(1,num_problems);
problems.probPIQMC=zeros(1,num_problems);
if loc==2
% Annealing parameters
init_temp_SA=1e29;
final_temp_SA=1000;
spin_StepSize_SA=1;
iterations_SA=100;
flipsPerTemp_SA=5;

iterations_PIQMC=400;
trotterSlices=30;
Ginitial=1.3;
temperature_PIQMC=0.05;
step_flips_PIQMC=1;

if mod(num_spins,8)
    disp('Use a number of spins which is a multiple of 8');
    return
end
chimera_blocks=num_spins/8;
if floor(sqrt(chimera_blocks))==sqrt(chimera_blocks)
    chimera_side=sqrt(chimera_blocks);
    adj=chimeraAdj(chimera_side,chimera_side);
    num_spins=chimera_side^2*8;
    problems.solution=zeros(num_problems,num_spins);
else
    chimera_side=floor(sqrt(chimera_blocks));
    adj=chimeraAdj(chimera_side+1,chimera_side);
    num_spins=(chimera_side^2+chimera_side)*8;
    problems.solution=zeros(num_problems,num_spins);
end
for k=1:num_problems
    counter_SA=zeros(1,100);
    counter_PIQMC=zeros(1,100);
    for i=1:num_loops
        loops{i}=random_walk_loop_2(adj);
    end
    spinconfig=(round(rand(1,num_spins)).*2-1);
    h=-spinconfig.*4./num_spins;
    [J,~]=planted_hamiltonian_2(spinconfig,loops);
    nonzeros=find(J);
    [sub,~]=ind2sub(size(J),nonzeros);
    problems.coupledspins(k)=length(unique(sub));
    hParams={h,J,0,0,0,0,0};
    gs_energy=Conf_energy(spinconfig,hParams);
    starting_conf=(round(rand(1,num_spins)).*2-1);
    parfor i=1:100
        solution_SA=simulatedAnnealing(hParams, starting_conf, init_temp_SA, final_temp_SA, ...
            spin_StepSize_SA, iterations_SA, 'exponential', flipsPerTemp_SA);
        if (solution_SA{1}-gs_energy)<epsilon
            counter_SA(i)=1;
        end
    end
    probSA=sum(counter_SA)/100;
    problems.timeSA(k)=iterations_SA*flipsPerTemp_SA*log(0.01)/log(1-min(0.99,probSA));
    parfor i=1:100
        solution_PIQMC=piqmc(starting_conf, hParams, iterations_PIQMC, trotterSlices,...
            Ginitial, temperature_PIQMC, step_flips_PIQMC);
        if (solution_PIQMC{1}-gs_energy)<epsilon
            counter_PIQMC(i)=1;
        end
    end
    probPIQMC=sum(counter_PIQMC)/100;
    problems.timePIQMC(k)=iterations_PIQMC*trotterSlices*log(0.01)/log(1-min(0.99,probPIQMC));
    problems.hamiltonian{k}=hParams;
    problems.solution(k,:)=spinconfig';
    problems.gs(k)=gs_energy;
    problems.probPIQMC(k)=probPIQMC;
    if mod(k,10)==0
        disp(strcat('Problem ',int2str(k)));
    end
end
elseif loc==3
% Annealing parameters

init_temp_SA=1e29;
final_temp_SA=0;
spin_StepSize_SA=1;
iterations_SA=100;
flipsPerTemp_SA=5;

iterations_PIQMC=350;
trotterSlices=30;
Ginitial=1.3;
temperature_PIQMC=0.05;
step_flips_PIQMC=1;

lattice_length=round(sqrt(num_spins));
adj=gpuArray(nearestNeighbourAdj3local(lattice_length,lattice_length));
num_spins=lattice_length^2;
problems.solution=zeros(num_problems,num_spins);

for k=1:num_problems
    counter_SA=zeros(1,100);
    counter_PIQMC=zeros(1,100);
    for i=1:num_loops
        loops{i}=random_walk_loop_3_gpu(adj);
    end
    spinconfig=2.*(gpuArray.randi(2,1,num_spins)-3/2);
    h=-spinconfig.*4./num_spins;
    [J,~]=planted_hamiltonian_3_gpu(spinconfig,loops);
    nonzeros=find(J);
    [sub,~,~]=ind2sub(size(J),nonzeros);
    problems.coupledspins(k)=length(unique(sub));
    hParams={h,0,0,J,0,0,0};
    gs_energy=Conf_energy_gpu(spinconfig,hParams);
    starting_conf=2.*(gpuArray.randi(2,1,num_spins)-3/2);
    for i=1:100
        solution_SA=simulatedAnnealing_gpu(hParams, starting_conf, init_temp_SA, final_temp_SA, ...
            spin_StepSize_SA, iterations_SA, 'exponential', flipsPerTemp_SA);
        if (solution_SA{1}-gs_energy)<epsilon
            counter_SA(i)=1;
        end
    end
    probSA=sum(counter_SA)/100;
    problems.timeSA(k)=iterations_SA*flipsPerTemp_SA*log(0.01)/log(1-min(0.99,probSA));
    for i=1:100
        solution_PIQMC=piqmc_gpu(starting_conf, hParams, iterations_PIQMC, trotterSlices,...
            Ginitial, temperature_PIQMC, step_flips_PIQMC);
        if (solution_PIQMC{1}-gs_energy)<epsilon
            counter_PIQMC(i)=1;
        end
    end
    probPIQMC=sum(counter_PIQMC)/100;
    problems.timePIQMC(k)=iterations_PIQMC*trotterSlices*log(0.01)/log(1-min(0.99,probPIQMC));
    problems.hamiltonian{k}=hParams;
    problems.solution(k,:)=spinconfig';
    problems.gs(k)=gs_energy;
    problems.probPIQMC(k)=probPIQMC;
    if mod(k,10)==0
        disp(strcat('Problem ',int2str(k)));
    end
end
elseif loc==4
% Annealing parameters

init_temp_SA=1e25;
final_temp_SA=0;
spin_StepSize_SA=1;
iterations_SA=100;
flipsPerTemp_SA=5;

iterations_PIQMC=100;
trotterSlices=30;
Ginitial=1.5;
temperature_PIQMC=0.05;
step_flips_PIQMC=1;

side=floor(sqrt(num_spins));
num_spins=side^2;
problems.solution=zeros(num_problems,num_spins);

for k=1:num_problems
    counter_SA=zeros(1,100);
    counter_PIQMC=zeros(1,100);
    spinconfig=(round(rand(1,num_spins)).*2-1);
    h=-spinconfig.*4./num_spins;
    [J,~]=planted_hamiltonian_4(spinconfig,num_loops);
    nonzeros=find(J);
    [sub,~,~,~]=ind2sub(size(J),nonzeros);
    problems.coupledspins(k)=length(unique(sub));
    hParams={h,0,0,0,0,J,0};
    gs_energy=Conf_energy(spinconfig,hParams);
    starting_conf=(round(rand(1,num_spins)).*2-1);
    parfor i=1:100
        solution_SA=simulatedAnnealing(hParams, starting_conf, init_temp_SA, final_temp_SA, ...
            spin_StepSize_SA, iterations_SA, 'exponential', flipsPerTemp_SA);
        if (solution_SA{1}-gs_energy)<epsilon
            counter_SA(i)=1;
        end
    end
    probSA=sum(counter_SA)/100;
    problems.timeSA(k)=iterations_SA*flipsPerTemp_SA*log(0.01)/log(1-min(0.99,probSA));
    parfor i=1:100
        solution_PIQMC=piqmc(starting_conf, hParams, iterations_PIQMC, trotterSlices,...
            Ginitial, temperature_PIQMC, step_flips_PIQMC);
        if (solution_PIQMC{1}-gs_energy)<epsilon
            counter_PIQMC(i)=1;
        end
    end
    probPIQMC=sum(counter_PIQMC)/100;
    problems.timePIQMC(k)=iterations_PIQMC*trotterSlices*log(0.01)/log(1-min(0.99,probPIQMC));
    problems.hamiltonian{k}=hParams;
    problems.solution(k,:)=spinconfig';
    problems.gs(k)=gs_energy;
    if mod(k,10)==0
        disp(strcat('Problem ',int2str(k)));
    end
end
end
problems.runtime=toc(t);
filename=strcat(int2str(num_problems),'_problems_',int2str(num_spins),'_spins_',int2str(loc),'local_',datestr(now,30),'.mat');
save(filename,'problems')
end