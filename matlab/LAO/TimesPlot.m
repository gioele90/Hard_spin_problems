% timeSA2locvals=problems2loc.timeSA;
% timePIQMC2locvals=problems2loc.timePIQMC;
% timeSA3locvals=problems3loc.timeSA;
% timePIQMC3locvals=problems3loc.timePIQMC;
timeSA2locvals=timeSA2locvals./48; %conversion between spin updates and sweeps
timePIQMC2locvals=timePIQMC2locvals./48;
timeSA3locvals=timeSA3locvals./49;
timePIQMC3locvals=timePIQMC3locvals./49;

timeSA2loc=mean(timeSA2locvals(find(timeSA2locvals>-Inf&timePIQMC2locvals>-Inf)));
timeSA2loclow=quantile(timeSA2locvals(find(timeSA2locvals>-Inf&timePIQMC2locvals>-Inf)),0.05);
timeSA2lochigh=quantile(timeSA2locvals(find(timeSA2locvals>-Inf&timePIQMC2locvals>-Inf)),0.95);
timePIQMC2loc=mean(timePIQMC2locvals(find(timeSA2locvals>-Inf&timePIQMC2locvals>-Inf)));
timePIQMC2loclow=quantile(timePIQMC2locvals(find(timeSA2locvals>-Inf&timePIQMC2locvals>-Inf)),0.05);
timePIQMC2lochigh=quantile(timePIQMC2locvals(find(timeSA2locvals>-Inf&timePIQMC2locvals>-Inf)),0.95);
timeSA3locvals(find(timeSA3locvals==-Inf))=10*max(timeSA3locvals);
timePIQMC3locvals(find(timePIQMC3locvals==-Inf))=10*max(timePIQMC3locvals);
timeSA3loc=mean(timeSA3locvals);
timeSA3loclow=quantile(timeSA3locvals,0.05);
timeSA3lochigh=quantile(timeSA3locvals,0.95);
timePIQMC3loc=mean(timePIQMC3locvals);
timePIQMC3loclow=quantile(timePIQMC3locvals,0.05);
timePIQMC3lochigh=quantile(timePIQMC3locvals,0.95);
x=[1 2];
timeSA=[timeSA2loc,timeSA3loc];
timeSAnegerr=[timeSA2loc-timeSA2loclow,timeSA3loc-timeSA3loclow];
timeSAposerr=[timeSA2lochigh-timeSA2loc,timeSA3lochigh-timeSA3loc];
timePIQMC=[timePIQMC2loc,timePIQMC3loc];
timePIQMCnegerr=[timePIQMC2loc-timePIQMC2loclow,timePIQMC3loc-timePIQMC3loclow];
timePIQMCposerr=[timePIQMC2lochigh-timePIQMC2loc,timePIQMC3lochigh-timePIQMC3loc];
figure
h1=errorbar(x,timeSA,timeSAnegerr,timeSAposerr);
hold
h2=errorbar(x,timePIQMC,timePIQMCnegerr,timePIQMCposerr);
axis([0.5 2.5 ylim])
set(gca,'XTick',[1 2],'FontSize',20)
set(gca,'XTickLabel',{'\begin{tabular}{c}2-local Chimera \\ 48 spins\end{tabular}',...
    '\begin{tabular}{c}3-local planar \\ 49 spins\end{tabular}'},'TickLabelInterpreter', 'latex')
xlabel('Problem locality','FontSize',20,'Interpreter','latex')
ylabel('Average TTS','FontSize',20,'Interpreter','latex')
plot(x,[timeSA2lochigh,timeSA3lochigh],'Color',[0 0.447 0.741],'LineStyle','--')
plot(x,[timeSA2loclow,timeSA3loclow],'Color',[0 0.447 0.741],'LineStyle','-.')
plot(x,[timePIQMC2lochigh,timePIQMC3lochigh],'Color',[0.85 0.325 0.098],'LineStyle','--')
plot(x,[timePIQMC2loclow,timePIQMC3loclow],'Color',[0.85 0.325 0.098],'LineStyle','-.')
 legend({'SA','PIQMC'},'FontSize',20,'Interpreter','latex')