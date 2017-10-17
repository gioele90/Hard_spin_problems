Nspinx=4;
Nspiny=Nspinx;
spinconfig=(round(rand(1,Nspinx*Nspiny)).*2-1);
adj=nearestNeighbourAdj4local(Nspinx,Nspiny);
num_loops=10;
loops=cell(1,num_loops);
for i = 1:num_loops
    % Generate random walk loop
    loop = random_walk_loop_4( adj );
    % Add to loop array
    loops{i} = loop;
    % Progress timer
end
[J_global,gsenergy]=planted_hamiltonian_4(spinconfig,loops);