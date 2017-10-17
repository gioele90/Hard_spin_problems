% go=1;
% num_spins=9;
% adj=nearestNeighbourAdj3local(3,3);
% num_loops=4;
% while go
% spinconfig=(round(rand(1,num_spins)).*2-1);
% loops=cell(1,num_loops);
% for i=1:num_loops
%     loops{i}=random_walk_loop_3(adj);
% end
% loopy=random_walk_loop_3(adj);
% loopy={loopy};
% [J,gs_energy]=planted_hamiltonian_3(spinconfig,loopy);
% J4=symmetrize3local(J4);
% J=zeros(16,16,16);
% J(2,3,7)=-1;
% J(2,6,7)=1;
% J(3,7,8)=-1;
% J(7,8,11)=-1;
% J(7,10,11)=-1;
% J(6,7,10)=-1;
% J=symmetrize3local(J);
spins=zeros(1,num_spins);
hParams={0,0,0,J,0,0,0};
gs_energy=Conf_energy(spinconfig,hParams);
gs=100;
% gs_config={};
% verifier=0;
% x=0:(2^num_spins-1);
% y=zeros(1,2^num_spins);
% figure
% hold
for i=0:2^num_spins-1
    bin=de2bi(i);
    spins=[bin,zeros(1,num_spins-numel(bin))];
    spins=2.*spins-1;
    energy=Conf_energy(spins,hParams);
%     y(i+1)=energy;
    if energy<gs
        gs=energy;
    end
%    if energy==-4
%        gs_config{end+1}=spins; 
%    end
end
% if ~isequal(gs,gs_energy)
%     go=0;
% end
% end
% scatter(x,y,[],'MarkerEdgeColor',[0    0.45    0.45],'MarkerFaceColor',[0    0.45    0.45]);
% ground=(spinconfig+1)./2;
% ground=bi2de(ground);
% scatter(ground,gs_energy,[],'MarkerEdgeColor',[0.8500    0.3250    0.0980],'MarkerFaceColor',[0.8500    0.3250    0.0980]);
% xlabel('|n\rangle');
% ylabel('Energy (a.u.)');
% for i=1:length(gs_config)
%     verifier=verifier+isequal(gs_config{i},spinconfig);
% end