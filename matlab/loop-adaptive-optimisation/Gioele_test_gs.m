num_spins=4;
adj=nearestNeighbourAdj3local(2,2);
% spinconfig=(round(rand(1,num_spins)).*2-1);
% loop={[1,2,3],[2,3,4],[3,4,5],[1,3,4]};
% loop=random_walk_loop_3(adj);
% loops={loop};
% [J_global,gsenergy]=planted_hamiltonian_3(spinconfig,loops);
% J_local = zeros(num_spins, num_spins, num_spins,num_spins);
% J_local = zeros(num_spins, num_spins, num_spins);
%     % Loop through triplets of nodes in loop
%     for i = 1:length(loop)
%         % Get node triplet
%         quad = sort(loop{i});
%         % Set coupling to J = -s_1 s_2 s_3 s_4
%         J_local(quad(1), quad(2), quad(3),quad(4)) = ...
%             -spinconfig(quad(1)) * spinconfig(quad(2)) * spinconfig(quad(3)) * spinconfig(quad(4));
%     end
    % Loop through triplets of nodes in loop
%     for i = 1:length(loop)
%         % Get node triplet
%         triplet = sort(loop{i});
%         % Set coupling to J = -s_1 s_2 s_3
%         J_local(triplet(1), triplet(2), triplet(3)) = ...
%             -spinconfig(triplet(1)) * spinconfig(triplet(2)) * spinconfig(triplet(3));
%     end
% coupling_indicies=find(J_local);
% random_coupling=coupling_indicies(randi(length(coupling_indicies)));
% J_local(random_coupling)=-J_local(random_coupling);
% J_local(2,3,4)=1;
% J_local=symmetrize4local(J_local);
% J_local=symmetrize3local(J_local);
J_global(4,6,7)=-1;
J_global=symmetrize3local(J_global);
spins=zeros(1,num_spins);
hParams={0,0,0,J_global,0,0,0};
gs=100;
gs_config={};
verifier=0;
figure
hold
for i=0:2^num_spins-1
    bin=de2bi(i);
    spins=[bin,zeros(1,num_spins-numel(bin))];
    spins=2.*spins-1;
    energy=Conf_energy(spins,hParams);
    hamming=0;
    for j=1:length(spins)
        if spins(j)*spinconfig(j)==-1
            hamming=hamming+1;
        end
    end
    scatter(hamming,energy,[],'MarkerEdgeColor',[0    0.45    0.45],'MarkerFaceColor',[0    0.45    0.45]);
%     if energy<gs
%         gs=energy;
%     end
%     if energy==-6
%         gs_config{end+1}=spins; 
%     end
end
xlabel('Hamming distance');
ylabel('Energy (a.u.)');
% for i=1:length(gs_config)
%     verifier=verifier+isequal(gs_config{i},spinconfig);
% end