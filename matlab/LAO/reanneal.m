function problems_out=reanneal(problems)
t=tic();

init_temp_SA=1e29;
final_temp_SA=0;
spin_StepSize_SA=1;
iterations_SA=600;
flipsPerTemp_SA=5;

iterations_PIQMC=350;
trotterSlices=30;
Ginitial=1.3;
temperature_PIQMC=0.05;
step_flips_PIQMC=1;

problems_out=problems;
hampar=problems.hamiltonian{1};
% num_spins=length(hampar{4});
num_spins=length(hampar{2});
epsilon=4/num_spins;

failedSA=find(problems.timeSA==-Inf);
failedPIQMC=find(problems.timePIQMC==-Inf);
    
for k=1:length(failedSA)
    counter_SA=zeros(1,1000);
    hParams=problems.hamiltonian{failedSA(k)};
    gs_energy=problems.gs(failedSA(k));
    starting_conf=(round(rand(1,num_spins)).*2-1);
    parfor i=1:1000
        solution_SA=simulatedAnnealing(hParams, starting_conf, init_temp_SA, final_temp_SA, ...
            spin_StepSize_SA, iterations_SA, 'exponential', flipsPerTemp_SA);
        if (solution_SA{1}-gs_energy)<epsilon
            counter_SA(i)=1;
        end
    end
    probSA=sum(counter_SA)/1000;
    problems_out.timeSA(failedSA(k))=iterations_SA*flipsPerTemp_SA*log(0.01)/log(1-min(0.99,probSA));
    problems_out.probSA(failedSA(k))=probSA;
    if mod(k,10)==0
        fprintf('SA Problem %d of %d\n',k,length(failedSA));
    end
end
for k=1:length(failedPIQMC)
    counter_PIQMC=zeros(1,1000);
    hParams=problems.hamiltonian{failedPIQMC(k)};
    gs_energy=problems.gs(failedPIQMC(k));
    starting_conf=(round(rand(1,num_spins)).*2-1);
     parfor i=1:1000
        solution_PIQMC=piqmc(starting_conf, hParams, iterations_PIQMC, trotterSlices,...
            Ginitial, temperature_PIQMC, step_flips_PIQMC);
        if (solution_PIQMC{1}-gs_energy)<epsilon
            counter_PIQMC(i)=1;
        end
    end
    probPIQMC=sum(counter_PIQMC)/1000;
    problems_out.timePIQMC(failedPIQMC(k))=iterations_PIQMC*trotterSlices*log(0.01)/log(1-min(0.99,probPIQMC));
    problems_out.probPIQMC(failedPIQMC(k))=probPIQMC;
    if mod(k,10)==0
        fprintf('PIQMC Problem %d of %d\n',k,length(failedPIQMC));
    end
end
problems_out.runtime=toc(t);
filename=strcat(int2str(problems.nproblems),'_problems_',int2str(num_spins),'_spins_',int2str(problems.locality),'local_degenerate',datestr(now,30),'_reannealed','.mat');
save(filename,'problems_out')
end
