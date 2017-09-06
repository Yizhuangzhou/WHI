library(ggplot2)
d<-read.table("WHI_validate_detail.xls",header=T)
d<-transform(d,Class=factor(Class,levels=c(">=95","<95","<90.5")))
Rank<-c("Intra","Inter")
name<-c("Same species","Different species")
col<- ifelse(d$Type == "Intra","red","blue")
d<-data.frame(d,col=col)

ggplot(d,aes(x=WHI,y=ANI))+
  geom_point(alpha = 1/10,col=d$col)+
  #geom_abline(intercept = lm.reg$coefficients[1], slope = lm.reg$coefficients[2],col="red")+
  #geom_smooth(method="lm",se=T,col="red",lwd=0.5)+
  scale_x_continuous(limits=c(74,100),breaks=seq(74,100,2),labels =seq(74,100,2))+
  scale_y_continuous(limits=c(87,100),breaks=seq(87,100,1),labels =seq(87,100,1))+
  xlab("WHI (%)")+
  ylab("ANI (%)")+
  # ggtitle("After normalization")+
  # geom_point(pch=20)+
  geom_hline(yintercept = c(90.5,95),lty=2)+
  #geom_vline(xintercept = c(90.5,95),lty=c(2,2))+
  # facet_grid(Percentage ~ .)+
  theme_bw()+
  #theme(title = element_text(face = "italic"))+
  theme( panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  theme(legend.background = element_blank(),legend.justification=c(1,0), legend.position="none")

ggsave("Validate_4WHI_detail_points.pdf")
