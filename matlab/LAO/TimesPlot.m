% timeSA2locvals=problems48spins2locset2.timeSA;
% timePIQMC2locvals=problems48spins2locset2.timePIQMC;
% timeSA3locvals=problems49spins3locset2.timeSA;
% timePIQMC3locvals=problems49spins3locset2.timePIQMC;
timeSA2locvals16spins=problems16spins2loc.timeSA;
timePIQMC2locvals16spins=problems16spins2loc.timePIQMC;
timeSA3locvals16spins=problems16spins3loc.timeSA;
timePIQMC3locvals16spins=problems16spins3loc.timePIQMC;
timeSA2locvals24spins=problems24spins2loc.timeSA;
timePIQMC2locvals24spins=problems24spins2loc.timePIQMC;
timeSA3locvals25spins=problems25spins3loc.timeSA;
timePIQMC3locvals25spins=problems25spins3loc.timePIQMC;
timeSA2locvals32spins=problems32spins2loc.timeSA;
timePIQMC2locvals32spins=problems32spins2loc.timePIQMC;
timeSA3locvals36spins=problems36spins3loc.timeSA;
timePIQMC3locvals36spins=problems36spins3loc.timePIQMC;
timeSA2locvals48spins=cat(2,problems48spins2locset1.timeSA,problems48spins2locset2.timeSA);
timePIQMC2locvals48spins=cat(2,problems48spins2locset1.timePIQMC,problems48spins2locset2.timePIQMC);
timeSA3locvals49spins=cat(2,problems49spins3locset1.timeSA,problems49spins3locset2.timeSA);
timePIQMC3locvals49spins=cat(2,problems49spins3locset1.timePIQMC,problems49spins3locset2.timePIQMC);
% timeSA2locvals=timeSA2locvals./48; %conversion between spin updates and sweeps
% timePIQMC2locvals=timePIQMC2locvals./48;
% timeSA3locvals=timeSA3locvals./49;
% timePIQMC3locvals=timePIQMC3locvals./49;

timeSA2locvals16spins=timeSA2locvals16spins./16;%conversion between spin updates and sweeps
timePIQMC2locvals16spins=timePIQMC2locvals16spins./16;
timeSA3locvals16spins=timeSA3locvals16spins./16;
timePIQMC3locvals16spins=timePIQMC3locvals16spins./16;

timeSA2locvals24spins=timeSA2locvals24spins./24; 
timePIQMC2locvals24spins=timePIQMC2locvals24spins./24;
timeSA3locvals25spins=timeSA3locvals25spins./25;
timePIQMC3locvals25spins=timePIQMC3locvals25spins./25;

timeSA2locvals32spins=timeSA2locvals32spins./32; 
timePIQMC2locvals32spins=timePIQMC2locvals32spins./32;
timeSA3locvals36spins=timeSA3locvals36spins./36;
timePIQMC3locvals36spins=timePIQMC3locvals36spins./36;

timeSA2locvals48spins=timeSA2locvals48spins./48;
timePIQMC2locvals48spins=timePIQMC2locvals48spins./48;
timeSA3locvals49spins=timeSA3locvals49spins./49;
timePIQMC3locvals49spins=timePIQMC3locvals49spins./49;

% timeSA2loc=mean(timeSA2locvals(find(timeSA2locvals>-Inf&timePIQMC2locvals>-Inf)));
% timeSA2loclow=quantile(timeSA2locvals(find(timeSA2locvals>-Inf&timePIQMC2locvals>-Inf)),0.05);
% timeSA2lochigh=quantile(timeSA2locvals(find(timeSA2locvals>-Inf&timePIQMC2locvals>-Inf)),0.95);
% timePIQMC2loc=mean(timePIQMC2locvals(find(timeSA2locvals>-Inf&timePIQMC2locvals>-Inf)));
% timePIQMC2loclow=quantile(timePIQMC2locvals(find(timeSA2locvals>-Inf&timePIQMC2locvals>-Inf)),0.05);
% timePIQMC2lochigh=quantile(timePIQMC2locvals(find(timeSA2locvals>-Inf&timePIQMC2locvals>-Inf)),0.95);
% timeSA3locvals(find(timeSA3locvals==-Inf))=10*max(timeSA3locvals);
% timePIQMC3locvals(find(timePIQMC3locvals==-Inf))=10*max(timePIQMC3locvals);
% timeSA3loc=mean(timeSA3locvals);
% timeSA3loclow=quantile(timeSA3locvals,0.05);
% timeSA3lochigh=quantile(timeSA3locvals,0.95);
% timePIQMC3loc=mean(timePIQMC3locvals);
% timePIQMC3loclow=quantile(timePIQMC3locvals,0.05);
% timePIQMC3lochigh=quantile(timePIQMC3locvals,0.95);

timeSA2loc16spins=mean(timeSA2locvals16spins(find(timeSA2locvals16spins>-Inf&timePIQMC2locvals16spins>-Inf)));
timeSA2loclow16spins=quantile(timeSA2locvals16spins(find(timeSA2locvals16spins>-Inf&timePIQMC2locvals16spins>-Inf)),0.05);
timeSA2lochigh16spins=quantile(timeSA2locvals16spins(find(timeSA2locvals16spins>-Inf&timePIQMC2locvals16spins>-Inf)),0.95);
timePIQMC2loc16spins=mean(timePIQMC2locvals16spins(find(timeSA2locvals16spins>-Inf&timePIQMC2locvals16spins>-Inf)));
timePIQMC2loclow16spins=quantile(timePIQMC2locvals16spins(find(timeSA2locvals16spins>-Inf&timePIQMC2locvals16spins>-Inf)),0.05);
timePIQMC2lochigh16spins=quantile(timePIQMC2locvals16spins(find(timeSA2locvals16spins>-Inf&timePIQMC2locvals16spins>-Inf)),0.95);
% timeSA3locvals16spins(find(timeSA3locvals16spins==-Inf))=10*max(timeSA3locvals16spins);
% timePIQMC3locvals16spins(find(timePIQMC3locvals16spins==-Inf))=10*max(timePIQMC3locvals16spins);
timeSA3loc16spins=mean(timeSA3locvals16spins(find(timeSA3locvals16spins>-Inf&timePIQMC3locvals16spins>-Inf)));
timeSA3loclow16spins=quantile(timeSA3locvals16spins(find(timeSA3locvals16spins>-Inf&timePIQMC3locvals16spins>-Inf)),0.05);
timeSA3lochigh16spins=quantile(timeSA3locvals16spins(find(timeSA3locvals16spins>-Inf&timePIQMC3locvals16spins>-Inf)),0.95);
timePIQMC3loc16spins=mean(timePIQMC3locvals16spins(find(timeSA3locvals16spins>-Inf&timePIQMC3locvals16spins>-Inf)));
timePIQMC3loclow16spins=quantile(timePIQMC3locvals16spins(find(timeSA3locvals16spins>-Inf&timePIQMC3locvals16spins>-Inf)),0.05);
timePIQMC3lochigh16spins=quantile(timePIQMC3locvals16spins(find(timeSA3locvals16spins>-Inf&timePIQMC3locvals16spins>-Inf)),0.95);

timeSA2loc24spins=mean(timeSA2locvals24spins(find(timeSA2locvals24spins>-Inf&timePIQMC2locvals24spins>-Inf)));
timeSA2loclow24spins=quantile(timeSA2locvals24spins(find(timeSA2locvals24spins>-Inf&timePIQMC2locvals24spins>-Inf)),0.05);
timeSA2lochigh24spins=quantile(timeSA2locvals24spins(find(timeSA2locvals24spins>-Inf&timePIQMC2locvals24spins>-Inf)),0.95);
timePIQMC2loc24spins=mean(timePIQMC2locvals24spins(find(timeSA2locvals24spins>-Inf&timePIQMC2locvals24spins>-Inf)));
timePIQMC2loclow24spins=quantile(timePIQMC2locvals24spins(find(timeSA2locvals24spins>-Inf&timePIQMC2locvals24spins>-Inf)),0.05);
timePIQMC2lochigh24spins=quantile(timePIQMC2locvals24spins(find(timeSA2locvals24spins>-Inf&timePIQMC2locvals24spins>-Inf)),0.95);
% timeSA3locvals36spins(find(timeSA3locvals36spins==-Inf))=10*max(timeSA3locvals36spins);
% timePIQMC3locvals36spins(find(timePIQMC3locvals36spins==-Inf))=10*max(timePIQMC3locvals36spins);
timeSA3loc25spins=mean(timeSA3locvals25spins(find(timeSA3locvals25spins>-Inf&timePIQMC3locvals25spins>-Inf)));
timeSA3loclow25spins=quantile(timeSA3locvals25spins(find(timeSA3locvals25spins>-Inf&timePIQMC3locvals25spins>-Inf)),0.05);
timeSA3lochigh25spins=quantile(timeSA3locvals25spins(find(timeSA3locvals25spins>-Inf&timePIQMC3locvals25spins>-Inf)),0.95);
timePIQMC3loc25spins=mean(timePIQMC3locvals25spins(find(timeSA3locvals25spins>-Inf&timePIQMC3locvals25spins>-Inf)));
timePIQMC3loclow25spins=quantile(timePIQMC3locvals25spins(find(timeSA3locvals25spins>-Inf&timePIQMC3locvals25spins>-Inf)),0.05);
timePIQMC3lochigh25spins=quantile(timePIQMC3locvals25spins(find(timeSA3locvals25spins>-Inf&timePIQMC3locvals25spins>-Inf)),0.95);

timeSA2loc32spins=mean(timeSA2locvals32spins(find(timeSA2locvals32spins>-Inf&timePIQMC2locvals32spins>-Inf)));
timeSA2loclow32spins=quantile(timeSA2locvals32spins(find(timeSA2locvals32spins>-Inf&timePIQMC2locvals32spins>-Inf)),0.05);
timeSA2lochigh32spins=quantile(timeSA2locvals32spins(find(timeSA2locvals32spins>-Inf&timePIQMC2locvals32spins>-Inf)),0.95);
timePIQMC2loc32spins=mean(timePIQMC2locvals32spins(find(timeSA2locvals32spins>-Inf&timePIQMC2locvals32spins>-Inf)));
timePIQMC2loclow32spins=quantile(timePIQMC2locvals32spins(find(timeSA2locvals32spins>-Inf&timePIQMC2locvals32spins>-Inf)),0.05);
timePIQMC2lochigh32spins=quantile(timePIQMC2locvals32spins(find(timeSA2locvals32spins>-Inf&timePIQMC2locvals32spins>-Inf)),0.95);
% timeSA3locvals36spins(find(timeSA3locvals36spins==-Inf))=10*max(timeSA3locvals36spins);
% timePIQMC3locvals36spins(find(timePIQMC3locvals36spins==-Inf))=10*max(timePIQMC3locvals36spins);
timeSA3loc36spins=mean(timeSA3locvals36spins(find(timeSA3locvals36spins>-Inf&timePIQMC3locvals36spins>-Inf)));
timeSA3loclow36spins=quantile(timeSA3locvals36spins(find(timeSA3locvals36spins>-Inf&timePIQMC3locvals36spins>-Inf)),0.05);
timeSA3lochigh36spins=quantile(timeSA3locvals36spins(find(timeSA3locvals36spins>-Inf&timePIQMC3locvals36spins>-Inf)),0.95);
timePIQMC3loc36spins=mean(timePIQMC3locvals36spins(find(timeSA3locvals36spins>-Inf&timePIQMC3locvals36spins>-Inf)));
timePIQMC3loclow36spins=quantile(timePIQMC3locvals36spins(find(timeSA3locvals36spins>-Inf&timePIQMC3locvals36spins>-Inf)),0.05);
timePIQMC3lochigh36spins=quantile(timePIQMC3locvals36spins(find(timeSA3locvals36spins>-Inf&timePIQMC3locvals36spins>-Inf)),0.95);

timeSA2loc48spins=mean(timeSA2locvals48spins(find(timeSA2locvals48spins>-Inf&timePIQMC2locvals48spins>-Inf)));
timeSA2loclow48spins=quantile(timeSA2locvals48spins(find(timeSA2locvals48spins>-Inf&timePIQMC2locvals48spins>-Inf)),0.05);
timeSA2lochigh48spins=quantile(timeSA2locvals48spins(find(timeSA2locvals48spins>-Inf&timePIQMC2locvals48spins>-Inf)),0.95);
timePIQMC2loc48spins=mean(timePIQMC2locvals48spins(find(timeSA2locvals48spins>-Inf&timePIQMC2locvals48spins>-Inf)));
timePIQMC2loclow48spins=quantile(timePIQMC2locvals48spins(find(timeSA2locvals48spins>-Inf&timePIQMC2locvals48spins>-Inf)),0.05);
timePIQMC2lochigh48spins=quantile(timePIQMC2locvals48spins(find(timeSA2locvals48spins>-Inf&timePIQMC2locvals48spins>-Inf)),0.95);
% timeSA3locvals49spins(find(timeSA3locvals49spins==-Inf))=10*max(timeSA3locvals49spins);
% timePIQMC3locvals49spins(find(timePIQMC3locvals49spins==-Inf))=10*max(timePIQMC3locvals49spins);
timeSA3loc49spins=mean(timeSA3locvals49spins(find(timeSA3locvals49spins>-Inf&timePIQMC3locvals49spins>-Inf)));
timeSA3loclow49spins=quantile(timeSA3locvals49spins(find(timeSA3locvals49spins>-Inf&timePIQMC3locvals49spins>-Inf)),0.05);
timeSA3lochigh49spins=quantile(timeSA3locvals49spins(find(timeSA3locvals49spins>-Inf&timePIQMC3locvals49spins>-Inf)),0.95);
timePIQMC3loc49spins=mean(timePIQMC3locvals49spins(find(timeSA3locvals49spins>-Inf&timePIQMC3locvals49spins>-Inf)));
timePIQMC3loclow49spins=quantile(timePIQMC3locvals49spins(find(timeSA3locvals49spins>-Inf&timePIQMC3locvals49spins>-Inf)),0.05);
timePIQMC3lochigh49spins=quantile(timePIQMC3locvals49spins(find(timeSA3locvals49spins>-Inf&timePIQMC3locvals49spins>-Inf)),0.95);

s1=[16 24 32 48];
s2=[16 25 36 49];
vecSA2loc=[timeSA2loc16spins,timeSA2loc24spins,timeSA2loc32spins,timeSA2loc48spins];
vecSA3loc=[timeSA3loc16spins,timeSA3loc25spins,timeSA3loc36spins,timeSA3loc49spins];
vecSA2loclow=[timeSA2loclow16spins,timeSA2loclow24spins,timeSA2loclow32spins,timeSA2loclow48spins];
vecSA3loclow=[timeSA3loclow16spins,timeSA3loclow25spins,timeSA3loclow36spins,timeSA3loclow49spins];
vecSA2lochigh=[timeSA2lochigh16spins,timeSA2lochigh24spins,timeSA2lochigh32spins,timeSA2lochigh48spins];
vecSA3lochigh=[timeSA3lochigh16spins,timeSA3lochigh25spins,timeSA3lochigh36spins,timeSA3lochigh49spins];
vecSA2locnegerr=vecSA2loc-vecSA2loclow;
vecSA2locposerr=vecSA2lochigh-vecSA2loc;
vecSA3locnegerr=vecSA3loc-vecSA3loclow;
vecSA3locposerr=vecSA3lochigh-vecSA3loc;
vecPIQMC2loc=[timePIQMC2loc16spins,timePIQMC2loc24spins,timePIQMC2loc32spins,timePIQMC2loc48spins];
vecPIQMC3loc=[timePIQMC3loc16spins,timePIQMC3loc25spins,timePIQMC3loc36spins,timePIQMC3loc49spins];
vecPIQMC2loclow=[timePIQMC2loclow16spins,timePIQMC2loclow24spins,timePIQMC2loclow32spins,timePIQMC2loclow48spins];
vecPIQMC3loclow=[timePIQMC3loclow16spins,timePIQMC3loclow25spins,timePIQMC3loclow36spins,timePIQMC3loclow49spins];
vecPIQMC2lochigh=[timePIQMC2lochigh16spins,timePIQMC2lochigh24spins,timePIQMC2lochigh32spins,timePIQMC2lochigh48spins];
vecPIQMC3lochigh=[timePIQMC3lochigh16spins,timePIQMC3lochigh25spins,timePIQMC3lochigh36spins,timePIQMC3lochigh49spins];
vecPIQMC2locnegerr=vecPIQMC2loc-vecPIQMC2loclow;
vecPIQMC2locposerr=vecPIQMC2lochigh-vecPIQMC2loc;
vecPIQMC3locnegerr=vecPIQMC3loc-vecPIQMC3loclow;
vecPIQMC3locposerr=vecPIQMC3lochigh-vecPIQMC3loc;
% timePIQMCnegerr=[timePIQMC2loc-timePIQMC2loclow,timePIQMC3loc-timePIQMC3loclow];
% timePIQMCposerr=[timePIQMC2lochigh-timePIQMC2loc,timePIQMC3lochigh-timePIQMC3loc];
figure
h1=errorbar(s1,vecSA2loc,vecSA2locnegerr,vecSA2locposerr,'Linewidth',2);
hold
h2=errorbar(s2,vecSA3loc,vecSA3locnegerr,vecSA3locposerr,'Linewidth',2);
h3=errorbar(s1,vecPIQMC2loc,vecPIQMC2locnegerr,vecPIQMC2locposerr,'Linewidth',2);
h4=errorbar(s2,vecPIQMC3loc,vecPIQMC3locnegerr,vecPIQMC3locposerr,'Linewidth',2);
prop1=get(h1);
prop2=get(h2);
prop3=get(h3);
prop4=get(h4);
color1=prop1.Color;
color2=prop2.Color;
color3=prop3.Color;
color4=prop4.Color;
% h2=errorbar(x,timePIQMC,timePIQMCnegerr,timePIQMCposerr);
% axis([0.5 2.5 ylim])
% set(gca,'XTick',[1 2],'FontSize',20)
% set(gca,'XTickLabel',{'\begin{tabular}{c}2-local Chimera \\ 48 spins\end{tabular}',...
%     '\begin{tabular}{c}3-local planar \\ 49 spins\end{tabular}'},'TickLabelInterpreter', 'latex')
xlabel('Graph size','FontSize',20,'Interpreter','latex')
ylabel('Average TTS','FontSize',20,'Interpreter','latex')
% plot(s1,vecSA2loclow,'Color',color1,'LineStyle','--','LineWidth',2)
% plot(s1,vecSA2lochigh,'Color',color1,'LineStyle','-.','LineWidth',2)
% plot(s2,vecSA3loclow,'Color',color2,'LineStyle','--','LineWidth',2)
% plot(s2,vecSA3lochigh,'Color',color2,'LineStyle','-.','LineWidth',2)
% plot(s1,vecPIQMC2loclow,'Color',color3,'LineStyle','--','LineWidth',2)
% plot(s1,vecPIQMC2lochigh,'Color',color3,'LineStyle','-.','LineWidth',2)
% plot(s2,vecPIQMC3loclow,'Color',color4,'LineStyle','--','LineWidth',2)
% plot(s2,vecPIQMC3lochigh,'Color',color4,'LineStyle','-.','LineWidth',2)
% plot(x,[timePIQMC2lochigh,timePIQMC3lochigh],'Color',[0.85 0.325 0.098],'LineStyle','--')
% plot(x,[timePIQMC2loclow,timePIQMC3loclow],'Color',[0.85 0.325 0.098],'LineStyle','-.')
legend({'SA 2-local','SA 3-local','PIQMC 2-local','PIQMC 3-local'},'FontSize',20,'Interpreter','latex')