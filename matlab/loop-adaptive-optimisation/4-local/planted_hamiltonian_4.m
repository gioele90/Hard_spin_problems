function [J,gs_energy]=planted_hamiltonian_4(solution,num_loops)
num_spins = length(solution);
J=zeros(num_spins,num_spins,num_spins,num_spins);
J_local=zeros(num_spins,num_spins,num_spins,num_spins);
side=sqrt(num_spins);
if ~isequal(side,floor(side))
    disp('Use a square number for the number of spins');
    return
end
for i=1:num_loops
    if randi(2)==1 %randomly choose wether to drow a row or column loop
        column=randi(side-1); %column loop
        for row=1:side-1
            s1=(row-1)*side+column;
            s2=(row-1)*side+column+1;
            s3=row*side+column;
            s4=row*side+column+1;
            J_local(s1,s2,s3,s4)=-solution(s1)*solution(s2)*solution(s3)*solution(s4);
        end
        s1=column;
        s2=column+1;
        s3=(side-1)*side+column;
        s4=(side-1)*side+column+1;
        J_local(s1,s2,s3,s4)=-solution(s1)*solution(s2)*solution(s3)*solution(s4);
    else
        row=randi(side-1); %row loop
        for column=1:side-1
            s1=(row-1)*side+column;
            s2=(row-1)*side+column+1;
            s3=row*side+column;
            s4=row*side+column+1;
            J_local(s1,s2,s3,s4)=-solution(s1)*solution(s2)*solution(s3)*solution(s4);
        end
        s1=(row-1)*side+1;
        s2=(row-1)*side+side;
        s3=row*side+1;
        s4=row*side+side;
        J_local(s1,s2,s3,s4)=-solution(s1)*solution(s2)*solution(s3)*solution(s4);
    end
    % coupling flip
    coupling_indicies = find(J_local);
    random_coupling = coupling_indicies(randi(length(coupling_indicies)));
    J_local(random_coupling) = -J_local(random_coupling);
    J=J+J_local;
    J_local=zeros(num_spins,num_spins,num_spins,num_spins);
end
J=symmetrize4local(J);
hParams={0,0,0,0,0,J,0};
gs_energy=Conf_energy(solution,hParams);
end