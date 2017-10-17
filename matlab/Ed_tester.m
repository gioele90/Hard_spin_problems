clear all

rng('default');
rng(1);


n=100;
indices_to_flip=[16];
Jzz=randn(100,100);
new_spin_config=((rand(1,100)>0.5).*2)-1;
ediff=0;
slice=1;


% 
% for spin_index = 1:length(indices_to_flip);
%     for neib_1 = 1:n;
%         if neib_1 ~= indices_to_flip(spin_index)
%             ediff = ediff + 2.0*Jzz(indices_to_flip(spin_index), neib_1)*new_spin_config(slice,indices_to_flip(spin_index))*new_spin_config(slice,neib_1);
%         end
%     end
%     
% end
for i =1:length(indices_to_flip)
    ediff= ediff+sum(2.0*Jzz(indices_to_flip(i), 1:size(Jzz,2)~=indices_to_flip(i)).*new_spin_config(slice,indices_to_flip(i)).*new_spin_config(slice,1:size(Jzz,2)~=indices_to_flip(i)));
end
ediff