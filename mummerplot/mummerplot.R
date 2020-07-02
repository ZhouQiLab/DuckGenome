rm(list = ls())
graphics.off()
library(ggplot2)
library(RColorBrewer)

theme <- theme_bw()+
  theme(plot.title = element_text(hjust = 0.5),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

md <- read.table("duck_chicken.sizes.coords",header = FALSE, stringsAsFactors = FALSE)
axis <- read.table("axis.txt",header = FALSE, stringsAsFactors = FALSE)
head(md)
head(axis)

p1 <- ggplot(md[md$V7>80 & md$V5>500,],aes(x=V1,y=V3,colour=V14,size=V5))+ geom_point(alpha=0.2)+
  theme+
  geom_hline(data = axis, aes(yintercept=V2), size=0.3, alpha=0.5)+
  geom_vline(data = axis, aes(xintercept=V1), size=0.3, alpha=0.5)+
  scale_colour_brewer(palette='Set1')
pdf("p1.pdf",width = 6,height = 5)
p1
dev.off()

