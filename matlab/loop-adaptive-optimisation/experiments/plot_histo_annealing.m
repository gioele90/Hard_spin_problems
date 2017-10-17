% figure
% subplot(2,2,1)
% histogram(timetoepsilon_PIQMC_chimera,20)
% xlabel('TT\epsilon')
% title('2-local Chimera')
% subplot(2,2,2)
% histogram(timetoepsilon_PIQMC_chimera_nondeg,20,'FaceColor','r')
% title('2-local Chimera, non-degenerate')
% xlabel('TT\epsilon')
% subplot(2,2,3)
% histogram(timetoepsilon_PIQMC_3local,20,'FaceColor','g')
% title('3-local planar')
% xlabel('TT\epsilon')
% subplot(2,2,4)
% histogram(timetoepsilon_PIQMC_3local_nondeg,20,'FaceColor','y')
% title('3-local planar, non-degenerate')
% xlabel('TT\epsilon')
%%
% timetoepsilon_SA_chimera=timetoepsilon_SA_chimera./100.*10.2;
% timetoepsilon_SA_chimera_nondeg=timetoepsilon_SA_chimera_nondeg./100.*10.2;
% timetoepsilon_SA_3local=timetoepsilon_SA_3local./100.*10.2;
% timetoepsilon_SA_3local_nondeg=timetoepsilon_SA_3local_nondeg./100.*10.2;
% timetoepsilon_SA_4local=timetoepsilon_SA_4local./100.*10.2;
% 
% timetoepsilon_PIQMC_chimera=timetoepsilon_PIQMC_chimera.*6;
% timetoepsilon_PIQMC_chimera_nondeg=timetoepsilon_PIQMC_chimera_nondeg.*6;
% timetoepsilon_PIQMC_3local=timetoepsilon_PIQMC_3local.*6;
% timetoepsilon_PIQMC_3local_nondeg=timetoepsilon_PIQMC_3local_nondeg.*6;
% timetoepsilon_PIQMC_4local=timetoepsilon_PIQMC_4local.*6;
% %%
% timetoepsilon_SA_3local(timetoepsilon_SA_3local==Inf)=1020;
% timetoepsilon_SA_3local_nondeg(timetoepsilon_SA_3local_nondeg==Inf)=10200;
% %%
% chimera_SA=mean(timetoepsilon_SA_chimera);
% chimera_SA_sigma=quantile(timetoepsilon_SA_chimera,0.975)-chimera_SA;
% chimera_SA_sigma_down=chimera_SA-quantile(timetoepsilon_SA_chimera,0.025);
% 
% chimera_nondeg_SA=mean(timetoepsilon_SA_chimera_nondeg);
% chimera_nondeg_SA_sigma=quantile(timetoepsilon_SA_chimera_nondeg,0.975)-chimera_nondeg_SA;
% chimera_nondeg_SA_sigma_down=chimera_nondeg_SA-quantile(timetoepsilon_SA_chimera_nondeg,0.025);
% 
% chimera_PIQMC=mean(timetoepsilon_PIQMC_chimera);
% chimera_PIQMC_sigma=quantile(timetoepsilon_PIQMC_chimera,0.975)-chimera_PIQMC;
% chimera_PIQMC_sigma_down=chimera_PIQMC-quantile(timetoepsilon_PIQMC_chimera,0.025);
% 
% chimera_nondeg_PIQMC=mean(timetoepsilon_PIQMC_chimera_nondeg);
% chimera_nondeg_PIQMC_sigma=quantile(timetoepsilon_PIQMC_chimera_nondeg,0.975)-chimera_nondeg_PIQMC;
% chimera_nondeg_PIQMC_sigma_down=chimera_nondeg_PIQMC-quantile(timetoepsilon_PIQMC_chimera_nondeg,0.025);
% 
% local3_SA=mean(timetoepsilon_SA_3local);
% local3_SA_sigma=quantile(timetoepsilon_SA_3local,0.975)-local3_SA;
% local3_SA_sigma_down=local3_SA-quantile(timetoepsilon_SA_3local,0.025);
% 
% local3_nondeg_SA=mean(timetoepsilon_SA_3local_nondeg);
% local3_nondeg_SA_sigma=quantile(timetoepsilon_SA_3local_nondeg,0.975)-local3_nondeg_SA;
% local3_nondeg_SA_sigma_down=local3_nondeg_SA-quantile(timetoepsilon_SA_3local_nondeg,0.025);
% 
% local3_PIQMC=mean(timetoepsilon_PIQMC_3local);
% local3_PIQMC_sigma=quantile(timetoepsilon_PIQMC_3local,0.975)-local3_PIQMC;
% local3_PIQMC_sigma_down=local3_PIQMC-quantile(timetoepsilon_PIQMC_3local,0.025);
% 
% local3_nondeg_PIQMC=mean(timetoepsilon_PIQMC_3local_nondeg);
% local3_nondeg_PIQMC_sigma=quantile(timetoepsilon_PIQMC_3local_nondeg,0.975)-local3_nondeg_PIQMC;
% local3_nondeg_PIQMC_sigma_down=local3_nondeg_PIQMC-quantile(timetoepsilon_PIQMC_3local_nondeg,0.025);
% 
% local4_SA=mean(timetoepsilon_SA_4local);
% local4_SA_sigma=quantile(timetoepsilon_SA_4local,0.975)-local4_SA;
% local4_SA_sigma_down=local4_SA-quantile(timetoepsilon_SA_4local,0.025);
% 
% local4_PIQMC=mean(timetoepsilon_PIQMC_4local);
% local4_PIQMC_sigma=quantile(timetoepsilon_PIQMC_4local,0.975)-local4_PIQMC;
% local4_PIQMC_sigma_down=local4_PIQMC-quantile(timetoepsilon_PIQMC_4local,0.025);
% %%
% SA=[chimera_SA,local3_SA,local4_SA];
% SA_nondeg=[chimera_nondeg_SA,local3_nondeg_SA];
% PIQMC=[chimera_PIQMC,local3_PIQMC,local4_PIQMC];
% PIQMC_nondeg=[chimera_nondeg_PIQMC,local3_nondeg_PIQMC];
% SA_sigma=[chimera_SA_sigma,local3_SA_sigma,local4_SA_sigma];
% SA_sigma_down=[chimera_SA_sigma_down,local3_SA_sigma_down,local4_SA_sigma_down];
% SA_nondeg_sigma=[chimera_nondeg_SA_sigma,local3_nondeg_SA_sigma];
% SA_nondeg_sigma_down=[chimera_nondeg_SA_sigma_down,local3_nondeg_SA_sigma_down];
% PIQMC_sigma=[chimera_PIQMC_sigma,local3_PIQMC_sigma,local4_PIQMC_sigma];
% PIQMC_sigma_down=[chimera_PIQMC_sigma_down,local3_PIQMC_sigma_down,local4_PIQMC_sigma_down];
% PIQMC_nondeg_sigma=[chimera_nondeg_PIQMC_sigma,local3_nondeg_PIQMC_sigma];
% PIQMC_nondeg_sigma_down=[chimera_nondeg_PIQMC_sigma_down,local3_nondeg_PIQMC_sigma_down];
% x=[1,2,3];
% y=[1,2];
%%
figure
errorbar(x,SA,SA_sigma_down,SA_sigma);
hold
errorbar(x,PIQMC,PIQMC_sigma_down,PIQMC_sigma);
set(gca,'XTick',[1,2,3]);
set(gca,'XTickLabel',{'2-local','3-local','4-local'});
ylabel('Mean TTS');
legend('SA','PIQMC');
figure
errorbar(y,SA_nondeg,SA_nondeg_sigma_down,SA_nondeg_sigma);
hold
errorbar(y,PIQMC_nondeg,PIQMC_nondeg_sigma_down,PIQMC_nondeg_sigma);
set(gca,'XTick',[1,2]);
set(gca,'XTickLabel',{'2-local','3-local'});
ylabel('Mean TTS');
legend('SA','PIQMC');