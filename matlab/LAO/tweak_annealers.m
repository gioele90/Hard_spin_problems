function time=tweak_annealers(annealern,paramn,range,locality,nspins,nloops,nprobs,seed)
iterations_SA=40;
init_temp_SA=1e30;
final_temp_SA=0;
spin_StepSize_SA=1;
flipsPerTemp_SA=5;

iterations_PIQMC=350;
Ginitial=1.4;
temperature_PIQMC=0.05;
step_flips_PIQMC=1;
trotterSlices=30;

loc=locality;
num_spins=nspins;
num_loops=nloops;
num_problems=nprobs;
epsilon=4/num_spins;
loops=cell(1,num_loops);
time=zeros(length(range),num_problems);
time_avg=zeros(1,length(range));

if annealern==1
    param(1)=iterations_SA;
    param(2)=init_temp_SA;
    param(3)=final_temp_SA;
    param(4)=spin_StepSize_SA;
    param(5)=flipsPerTemp_SA;
    for i=1:length(range)
        param(paramn)=range(i);
        rng(seed);
        if loc==2
            if mod(num_spins,8)
                disp('Use a number of spins which is a multiple of 8');
            return
            end
            chimera_blocks=num_spins/8;
            if floor(sqrt(chimera_blocks))==sqrt(chimera_blocks)
                chimera_side=sqrt(chimera_blocks);
                adj=chimeraAdj(chimera_side,chimera_side);
                num_spins=chimera_side^2*8;
            else
                chimera_side=floor(sqrt(chimera_blocks));
                adj=chimeraAdj(chimera_side+1,chimera_side);
                num_spins=(chimera_side^2+chimera_side)*8;
            end
            for k=1:num_problems
            counter_SA=zeros(1,100);
            for m=1:num_loops
                loops{m}=random_walk_loop_2(adj);
            end
            spinconfig=(round(rand(1,num_spins)).*2-1);
            h=-spinconfig.*4./num_spins;
            [J,~]=planted_hamiltonian_2(spinconfig,loops);
            hParams={h,J,0,0,0,0,0};
            %hParams={0,J,0,0,0,0,0};
            gs_energy=Conf_energy(spinconfig,hParams);
            starting_conf=(round(rand(1,num_spins)).*2-1);
            parfor j=1:100
                solution_SA=simulatedAnnealing(hParams, starting_conf, param(2), param(3), ...
                    param(4), param(1), 'exponential', param(5));
                if (solution_SA{1}-gs_energy)<epsilon
                    counter_SA(j)=1;
                end
            end
            probSA=sum(counter_SA)/100;
            time(i,k)=param(1)*param(5)*log(0.01)/log(1-min(0.99,probSA));
            end
        elseif loc==3
            lattice_length=round(sqrt(num_spins));
            adj=nearestNeighbourAdj3local(lattice_length,lattice_length);
            num_spins=lattice_length^2;
            for k=1:num_problems
                counter_SA=zeros(1,100);
                for m=1:num_loops
                    loops{m}=random_walk_loop_3(adj);
                end
                spinconfig=(round(rand(1,num_spins)).*2-1);
                h=-spinconfig.*4./num_spins;
                [J,~]=planted_hamiltonian_3(spinconfig,loops);
                hParams={h,0,0,J,0,0,0};
                %hParams={0,0,0,J,0,0,0};
                gs_energy=Conf_energy(spinconfig,hParams);
                starting_conf=(round(rand(1,num_spins)).*2-1);
                parfor j=1:100
                    solution_SA=simulatedAnnealing(hParams, starting_conf, param(2), param(3), ...
                        param(4), param(1), 'exponential', param(5));
                    if (solution_SA{1}-gs_energy)<epsilon
                        counter_SA(j)=1;
                    end
                end
                probSA=sum(counter_SA)/100;
                time(i,k)=param(1)*param(5)*log(0.01)/log(1-min(0.99,probSA));
            end
        end
    end
elseif annealern==2
    param(1)=iterations_PIQMC;
    param(2)=Ginitial;
    param(3)=temperature_PIQMC;
    param(4)=step_flips_PIQMC;
    param(5)=trotterSlices;
    for i=1:length(range)
        param(paramn)=range(i);
        rng(seed);
        if loc==2
            if mod(num_spins,8)
                disp('Use a number of spins which is a multiple of 8');
            return
            end
            chimera_blocks=num_spins/8;
            if floor(sqrt(chimera_blocks))==sqrt(chimera_blocks)
                chimera_side=sqrt(chimera_blocks);
                adj=chimeraAdj(chimera_side,chimera_side);
                num_spins=chimera_side^2*8;
            else
                chimera_side=floor(sqrt(chimera_blocks));
                adj=chimeraAdj(chimera_side+1,chimera_side);
                num_spins=(chimera_side^2+chimera_side)*8;
            end
            for k=1:num_problems
            counter_PIQMC=zeros(1,100);
            for m=1:num_loops
                loops{m}=random_walk_loop_2(adj);
            end
            spinconfig=(round(rand(1,num_spins)).*2-1);
            h=-spinconfig.*4./num_spins;
            [J,~]=planted_hamiltonian_2(spinconfig,loops);
            hParams={h,J,0,0,0,0,0};
            %hParams={0,J,0,0,0,0,0};
            gs_energy=Conf_energy(spinconfig,hParams);
            starting_conf=(round(rand(1,num_spins)).*2-1);
            parfor j=1:100
                solution_PIQMC=piqmc(starting_conf, hParams, param(1), param(5),...
                    param(2), param(3), param(4));
                if (solution_PIQMC{1}-gs_energy)<epsilon
                    counter_PIQMC(j)=1;
                end
            end
            probPIQMC=sum(counter_PIQMC)/100;
            time(i,k)=param(1)*param(5)*log(0.01)/log(1-min(0.99,probPIQMC));
            end
        elseif loc==3
            lattice_length=round(sqrt(num_spins));
            adj=nearestNeighbourAdj3local(lattice_length,lattice_length);
            num_spins=lattice_length^2;
            for k=1:num_problems
                counter_PIQMC=zeros(1,100);
                for m=1:num_loops
                    loops{m}=random_walk_loop_3(adj);
                end
                spinconfig=(round(rand(1,num_spins)).*2-1);
                h=-spinconfig.*4./num_spins;
                [J,~]=planted_hamiltonian_3(spinconfig,loops);
                hParams={h,0,0,J,0,0,0};
                %hParams={0,0,0,J,0,0,0};
                gs_energy=Conf_energy(spinconfig,hParams);
                starting_conf=(round(rand(1,num_spins)).*2-1);
                parfor j=1:100
                    solution_PIQMC=piqmc(starting_conf, hParams, param(1), param(5),...
                        param(2), param(3), param(4));
                    if (solution_PIQMC{1}-gs_energy)<epsilon
                        counter_PIQMC(j)=1;
                    end
                end
                probPIQMC=sum(counter_PIQMC)/100;
                time(i,k)=param(1)*param(5)*log(0.01)/log(1-min(0.99,probPIQMC));
            end
        end
    end
end
for n=1:length(range)
    temp=time(n,:);
    time_avg(n)=mean(temp(find(temp>-Inf)));
end
figure
scatter(range,time_avg);
end