rm(list = ls())
graphics.off()
library(ggplot2)
library(RColorBrewer)
#devtools::install_github("wilkox/treemapify")
#install.packages("treemap")
library(treemapify)
library(treemap)

theme <- theme_bw()+
  theme(plot.title = element_text(hjust = 0.5),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

md = read.table('genome.contig_gap.block.bed', h=F)
md$V1 <- factor(md$V1)
head(md)
md <- md[md$V5=="contig",]
md <- md[grepl("chr",md$V1),]
#min(md$V4);max(md$V4)

md <- md[md$V1=="chr1" | md$V1=="chr2" | md$V1=="chr3" | md$V1=="chr4" | md$V1=="chr5"
         | md$V1=="chr6" | md$V1=="chr7" | md$V1=="chr8" | md$V1=="chrZ",]


p1 <- ggplot(md, aes(area=V4, label=V1, subgroup = V1))+
  geom_treemap(colour="Black",fill="White")+
  # geom_treemap_text(fontface = "italic", colour = "white", place = "centre",
  #                   grow = TRUE)+
  geom_treemap_subgroup_border()+
  geom_treemap_subgroup_text(place = "centre", grow = T, alpha = 0.9, colour =
                               "Black", fontface = "italic", min.size = 0)

pdf("p1.pdf",width = 10, height = 10)
p1
dev.off()
