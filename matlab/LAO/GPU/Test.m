num_spins=49;
num_loops=12;
num_problems=10;
epsilon=4/num_spins;
loops=cell(1,num_loops);
lattice_length=round(sqrt(num_spins));
adj=gpuArray(nearestNeighbourAdj3local(lattice_length,lattice_length));
num_spins=lattice_length^2;
counter_SA=zeros(1,100);
counter_PIQMC=zeros(1,100);
for i=1:num_loops
    loops{i}=random_walk_loop_3_gpu(adj);
end
spinconfig=2.*(gpuArray.randi(2,1,num_spins)-3/2);
h=-spinconfig.*4./num_spins;
h2=gather(h);
[J,~]=planted_hamiltonian_3_gpu(spinconfig,loops);
J2=gather(J);
nonzeros=find(J);
[sub,~,~]=ind2sub(size(J),nonzeros);
coupledspins=length(unique(sub));
hParams={h,0,0,J,0,0,0};
hParams2={h2,0,0,J2,0,0,0};
gs_energy=Conf_energy_gpu(spinconfig,hParams);
starting_conf=cell(1,100);
starting_conf2=cell(1,100);
ground2=zeros(1,100);
ground3=zeros(1,100);
for i=1:100
starting_conf{i}=2.*(gpuArray.randi(2,1,num_spins)-3/2);
starting_conf2{i}=gather(starting_conf{i});
end
t=tic;
for i=1:100
    ground2(i)=Conf_energy(starting_conf2{i},hParams2);
end
toc(t)
t2=tic;
ground=cellfun(@(z) Conf_energy_gpu(z,hParams),starting_conf,'UniformOutput',false);
toc(t2)
for i=1:100
    ground3(i)=gather(ground{i});
end


