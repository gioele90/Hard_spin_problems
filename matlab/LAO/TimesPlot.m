timeSA2loc=mean(problems2loc.timeSA(find(problems2loc.timeSA>-Inf&problems2loc.timePIQMC>-Inf)));
timeSA2loclow=quantile(problems2loc.timeSA(find(problems2loc.timeSA>-Inf&problems2loc.timePIQMC>-Inf)),0.05);
timeSA2lochigh=quantile(problems2loc.timeSA(find(problems2loc.timeSA>-Inf&problems2loc.timePIQMC>-Inf)),0.95);
timePIQMC2loc=mean(problems2loc.timePIQMC(find(problems2loc.timeSA>-Inf&problems2loc.timePIQMC>-Inf)));
timePIQMC2loclow=quantile(problems2loc.timePIQMC(find(problems2loc.timeSA>-Inf&problems2loc.timePIQMC>-Inf)),0.05);
timePIQMC2lochigh=quantile(problems2loc.timePIQMC(find(problems2loc.timeSA>-Inf&problems2loc.timePIQMC>-Inf)),0.95);
timeSA3locvals=problems3loc.timeSA;
timePIQMC3locvals=problems3loc.timePIQMC;
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
set(gca,'XTick',[1 2])
set(gca,'XTickLabel',{'\begin{tabular}{c}2-local Chimera \\ 48 spins\end{tabular}',...
    '\begin{tabular}{c}3-local planar \\ 49 spins\end{tabular}'},'TickLabelInterpreter', 'latex')
xlabel('Problem locality','Interpreter','latex')
ylabel('Average TTS','Interpreter','latex')
plot(x,[timeSA2lochigh,timeSA3lochigh],'Color',[0 0.447 0.741],'LineStyle','--')
plot(x,[timeSA2loclow,timeSA3loclow],'Color',[0 0.447 0.741],'LineStyle','-.')
plot(x,[timePIQMC2lochigh,timePIQMC3lochigh],'Color',[0.85 0.325 0.098],'LineStyle','--')
plot(x,[timePIQMC2loclow,timePIQMC3loclow],'Color',[0.85 0.325 0.098],'LineStyle','-.')
 legend({'SA','PIQMC'},'Interpreter','latex')