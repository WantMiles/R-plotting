library(readxl)
Reproductive_fitness_QX <- read_excel("~/City U/PhD related/My PhD/EE2 project/Embryonic_Exposure/Reproductive fitness_QX.xlsx", 
                                      +     sheet = "For Plotting")
#Plot hatching success data
dpf <- colnames(Reproductive_fitness_QX[3:32])
Hatch.melt <- melt(Reproductive_fitness_QX, id.vars = c("ID", "group"))
Hatch.melt <- Hatch.melt[Hatch.melt$variable %in% dpf,]
Hatch.melt$group <-factor(Hatch.melt$group, levels = c("Ctrl", "EE2"))
library(FSA)
#summarize Hatch.melt data with summarize function
sum <- Summarize(value ~ group + variable, data = Hatch.melt)
sum$se = sum$sd/sqrt(sum$n)
library(scales)
sum$mean <- sum$mean
#Turn 'variable' column into a character vector
sum$variable <- as.character(sum$variable)
#Then turn it back into a factor with the levels in the correct order
sum$variable <- factor(sum$variable, levels=unique(sum$variable))

p0 <- ggplot(sum, aes(x=variable, y=mean, color = group, group=group)) + geom_point(size=2) + geom_line(size=1.5,alpha=0.8) + geom_errorbar(aes(ymin = mean -se, ymax = mean + se, width = 0.15)) +
  scale_color_manual(values=c("dodgerblue", "orangered1")) + labs(x="Day Post Fertilization", y="Cumulative Hatching Success", col=NULL) + scale_y_continuous(labels = scales::percent)
p0


