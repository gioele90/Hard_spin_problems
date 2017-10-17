c=parcluster('legion_R2016b');
myJob1 = createCommunicatingJob (c, 'Type', 'Pool');
num_workers = 12;
myJob1.AttachedFiles = {
'anneal_schedule.m'
'chimeraAdj.m'
'Conf_energy.m'
'energyChange.m'
'getChimeraAdjacency.m'
'local_hamiltonian_3.m'
'piqmc.m'
'planted_hamiltonian_3.m'
'random_walk_loop_3.m'
'simulatedAnnealing.m'
'tran_prob.m'
'nearestNeighbourAdj3local.m'
'Gioele_test_annealers.m'
}; 
myJob.NumWorkersRange = [4,12];
task = createTask (myJob1, @Gioele_test_annealers, 2, {});