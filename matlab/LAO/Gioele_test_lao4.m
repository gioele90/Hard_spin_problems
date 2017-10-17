num_spins=16;
num_loops=5;
adj=nearestNeighbourAdj3local(4,4);
% adj=chimeraAdj(1,2);
spinconfig=(round(rand(1,num_spins)).*2-1);
spins=zeros(1,num_spins);
loops=cell(1,num_loops);
for k=1:num_loops
    loops{k}=random_walk_loop_3(adj);
end
% loop=random_walk_loop_2(adj);
% loop={loop};
% loop={[1,2,5,6],[2,3,6,7],[3,4,7,8],[1,4,5,8]};
% loop={loop};
[J,gs_energy]=planted_hamiltonian_3(spinconfig,loops);
% spins=randi(2^num_spins-1,1,500);
% J=symmetrize4local(J);
h=-spinconfig.*4./num_spins;
hParams={h,0,0,J,0,0,0};
gs_energy=Conf_energy(spinconfig,hParams);
gs=100;
gs_config={};
verifier=0;
x=0:(2^num_spins-1);
y=zeros(1,2^num_spins);
hamming=zeros(1,2^num_spins);
for i=0:2^num_spins-1
    bin=de2bi(i);
    spins=[bin,zeros(1,num_spins-numel(bin))];
    spins=2.*spins-1;
    energy=Conf_energy(spins,hParams);
    y(i+1)=energy;
    for j=1:length(spins)
        if spins(j)*spinconfig(j)==-1
            hamming(i+1)=hamming(i+1)+1;
        end
    end
%     if energy<gs
%         gs=energy;
%     end
%     if energy==-2
%         gs_config{end+1}=spins; 
%     end
end
% y=zeros(1,length(spins));
% for i=1:length(spins)
%     bin=de2bi(spins(i));
%     spin=[bin,zeros(1,num_spins-numel(bin))];
%     spin=2.*spin-1;
%     energy=Conf_energy(spin,hParams);
%     y(i)=energy;
% end
figure
hold
scatter(hamming,y,'MarkerEdgeColor',[0    0.45    0.45],'MarkerFaceColor',[0    0.45    0.45]);
% scatter(spins,y,'MarkerEdgeColor',[0    0.45    0.45],'MarkerFaceColor',[0    0.45    0.45]);
ground=(spinconfig+1)./2;
ground=bi2de(ground);
scatter(0,gs_energy,'MarkerEdgeColor',[0.8500    0.3250    0.0980],'MarkerFaceColor',[0.8500    0.3250    0.0980]);
xlabel('Hamming distance');
ylabel('Energy (a.u.)');
% for i=1:length(gs_config)
%     verifier=verifier+isequal(gs_config{i},spinconfig);
% end