rm(list = ls())
graphics.off()

library(ggplot2)
library(RColorBrewer)

theme <- theme_bw()+
  theme(plot.title = element_text(hjust = 0.5),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

###
md <- read.table("new.matrix.tri.add.add",stringsAsFactors = FALSE,header = FALSE)
head(md)

interval <- (max(md$V3)-min(md$V3))/200
md$V6 <- 0
md$V6 <- round(md$V3/interval)+1

colfunc<-colorRampPalette(c(brewer.pal(9,"Reds")[5],brewer.pal(9,"Reds")[8]))  ###red
colour <- colfunc(231)
colour <- colour[c(1,5,9,14,17,20,23,25,27,29,31,34,37,39,41,43,45,47,49,50:231)]


names(colour) <- c(seq(1,201))
md$V7 <- colour[as.character(md$V6)]

plot(rep(1,201),col=colour, pch=15,cex=2)
plot(rep(1,201),col=md$V7, pch=15,cex=2)

#width <- 0.015*max(md$V1)
md <- md[md$V6>4,]
new <- md

md$size <- 3

p1 <- ggplot(md)+
  geom_point(data=md,aes(x=V1,y=V2),colour=md$V7,stroke=FALSE,alpha=0.5,size=md$size,show.legend = FALSE)+
  xlab("")+
  ylab("")+
  #guides(color=FALSE)+
  geom_segment(aes(x=1,y=1,xend=26,yend=26))+ ###TAD
  geom_segment(aes(x=27,y=27,xend=51,yend=51))+ ###TAD
  geom_segment(aes(x=52,y=52,xend=70,yend=70))+ ###TAD 
  geom_segment(aes(x=71,y=71,xend=84,yend=84))+ ###TAD
  geom_segment(aes(x=85,y=85,xend=116,yend=116))+ ###TAD
  geom_segment(aes(x=117,y=117,xend=140,yend=140))+ ###TAD
  geom_segment(aes(x=141,y=141,xend=165,yend=165))+ ###TAD
  geom_segment(aes(x=166,y=166,xend=180,yend=180))+ ###TAD
  theme

pdf("p1.pdf")
p1
dev.off()

