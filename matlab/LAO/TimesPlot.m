timeSA2loc=mean(problems2loc.timeSA(find(problems2loc.timeSA>-Inf&problems2loc.timePIQMC>-Inf)));
timeSA2loclow=quantile(problems2loc.timeSA(find(problems2loc.timeSA>-Inf&problems2loc.timePIQMC>-Inf)),0.05);
timeSA2lochigh=quantile(problems2loc.timeSA(find(problems2loc.timeSA>-Inf&problems2loc.timePIQMC>-Inf)),0.95);
timePIQMC2loc=mean(problems2loc.timePIQMC(find(problems2loc.timeSA>-Inf&problems2loc.timePIQMC>-Inf)));
timePIQMC2loclow=quantile(problems2loc.timePIQMC(find(problems2loc.timeSA>-Inf&problems2loc.timePIQMC>-Inf)),0.05);
timePIQMC2lochigh=quantile(problems2loc.timePIQMC(find(problems2loc.timeSA>-Inf&problems2loc.timePIQMC>-Inf)),0.95);
timeSA3loc=mean(problems3loc.timeSA(find(problems3loc.timeSA>-Inf&problems3loc.timePIQMC>-Inf)));
timeSA3loclow=quantile(problems3loc.timeSA(find(problems3loc.timeSA>-Inf&problems3loc.timePIQMC>-Inf)),0.05);
timeSA3lochigh=quantile(problems3loc.timeSA(find(problems3loc.timeSA>-Inf&problems3loc.timePIQMC>-Inf)),0.95);
timePIQMC3loc=mean(problems3loc.timePIQMC(find(problems3loc.timeSA>-Inf&problems3loc.timePIQMC>-Inf)));
timePIQMC3loclow=quantile(problems3loc.timePIQMC(find(problems3loc.timeSA>-Inf&problems3loc.timePIQMC>-Inf)),0.05);
timePIQMC3lochigh=quantile(problems3loc.timePIQMC(find(problems3loc.timeSA>-Inf&problems3loc.timePIQMC>-Inf)),0.95);
x=[1 2];
timeSA=[timeSA2loc,timeSA3loc];
timeSAnegerr=[timeSA2loc-timeSA2loclow,timeSA3loc-timeSA3loclow];
timeSAposerr=[timeSA2lochigh-timeSA2loc,timeSA3lochigh-timeSA3loc];
timePIQMC=[timePIQMC2loc,timePIQMC3loc];
timePIQMCnegerr=[timePIQMC2loc-timePIQMC2loclow,timePIQMC3loc-timePIQMC3loclow];
timePIQMCposerr=[timePIQMC2lochigh-timePIQMC2loc,timePIQMC3lochigh-timePIQMC3loc];
figure
errorbar(x,timeSA,timeSAnegerr,timeSAposerr)
hold
errorbar(x,timePIQMC,timePIQMCnegerr,timePIQMCposerr)
axis([0.5 2.5 ylim])
set(gca,'XTick',[1 2])
set(gca,'XTickLabel',{'2-local','3-local'})
xlabel('Problem locality')
ylabel('Average TTS')
legend('SA','PIQMC')