# R-plotting
# Plot gene expression with ggplot2
target_genes <- colnames(RQ)[4:12]
library(reshape2)
RQ.melt <- melt(RQ, id.vars=c("ID", "group"))
RQ.melt <- RQ.melt[RQ.melt$variable %in% target_genes,]
RQ.melt$group <- factor(RQ.melt$group, levels=c("Ctrl", "BaP"))

library(ggplot2)
ggplot(RQ.melt) + geom_boxplot(aes(x=variable, y=value, col=group)) + theme_classic() + scale_color_manual(values=c("#4dac26", "#d01c8b")) + labs(x=NULL, y="Relative quantity", col=NULL)
