### Plots of Tajima's D and Watterson's theta after running in DnaSp ###

# Before using this script:
#1. open output files from dnasp in excel
#2. delete the big header (not the name of the columns), the last rows at the end of the file and the columns of mean etc
#3. delete the information that we don't need: the 6 n.a columns and 3 columns filled with 0 values
#4. replace the "n.a" values by nothing (live the cell empty)
#5. check that all the numbers are in numerical format, if not, change them (5 numbers after the comma)
#6. save the excel in "CSV UTF-8" format. This will be the input file used in this document


library(ggplot2)

# Open the input files for each population
inp_big <- read.csv2("DatasetB_paper_dnasp_big.csv")
inp_bru <- read.csv2("DatasetB_paper_dnasp_bru.csv")
inp_tbru <- read.csv2("DatasetB_paper_dnasp_tbru.csv")
inp_mig <- read.csv2("DatasetB_paper_dnasp_mig.csv")
inp_mm <- read.csv2("DatasetB_paper_dnasp_mm.csv")


head(inp_big)
#   ?..Locus.MSA TotalPos SegSites NetSegSites Pos1 Pos2 NetSites Sample_Size Eta
#1      RAD_268       13       13           1   14  225      212          46   1
#2      RAD_767       55       55           9    3  279      277          44   9
#3      RAD_827       37       37           6    5  287      283          38   6
#4     RAD_3424       33       33           9   19  269      251          56   9
#5     RAD_3747       24       24           1    5  288      284          12   1
#6     RAD_4260       28       28           3   13  257      245          42   3

length(inp_big$?..Locus.MSA)
#636 (paper)
length(inp_bru$?..Locus.MSA)
#642 (paper)
length(inp_tbru$?..Locus.MSA)
#642 (paper)
length(inp_mig$?..Locus.MSA)
#639 (paper)
length(inp_mm$?..Locus.MSA)
#629 (paper)


#note: not all the loci are exactly the same for each population


# Add at the beginning a "Population" column to each of the data sets
inp_big <- cbind(Population = rep("biguttulus", nrow(inp_big)), inp_big)
inp_bru <- cbind(Population = rep("brunneus", nrow(inp_bru)), inp_bru)
inp_tbru <- cbind(Population = rep("t.brunneus", nrow(inp_tbru)), inp_tbru)
inp_mig <- cbind(Population = rep("m.ignifer", nrow(inp_mig)), inp_mig)
inp_mm <- cbind(Population = rep("m.mollis", nrow(inp_mm)), inp_mm)


# Create a big data frame with all the data sets
data <- rbind(inp_big, inp_bru, inp_tbru, inp_mig, inp_mm)

#mean values
mean_TajD <- aggregate(TajimaD ~ Population, data = data, FUN = mean)
mean_TajD
#PAPER
#  Population    TajimaD
#1 biguttulus -1.2371753
#2   brunneus -1.7720236
#3  m.ignifer -1.1082810
#4   m.mollis -0.9552008
#5 t.brunneus -1.6091086

mean_twatt <- aggregate(ThetaWatt ~ Population, data = data, FUN = mean)
mean_twatt
#PAPER
#Population ThetaWatt
#1 biguttulus  2.003223
#2   brunneus  2.748967
#3  m.ignifer  1.828024
#4   m.mollis  1.772534
#5 t.brunneus  2.254148


##PLOTS##
# Violin plot - Tajima's D

#yellow= "#FFD700" # --> brunneus
#dgreen = "#056608" #deep green --> m mollis
#lgreen = "#81D170" #light green --> m ignifer
#purp = "#800080" # purple --> biguttulus
#brown = "#B4641E" #brown --> ticino bruneus

my_colors <- c("#800080", "#FFD700", "#81D170", "#056608", "#B4641E")

tajD_vplot <- ggplot(data, aes(x=Population,y=TajimaD,fill=Population)) +
  geom_violin(trim=FALSE) + 
  labs(x= NULL, y="Tajima's D per locus") +
  theme_classic()+
  scale_fill_manual(values = my_colors) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "darkgrey") +
  stat_summary(fun=mean, geom="point", shape=16, size=2) +
  theme(legend.position = "none", axis.text.y = element_text(face = "italic")) +
  coord_flip()

tajD_vplot

ggsave(paste("tajD_vplot_paper_allAlps_k5",".png", sep=""), plot = tajD_vplot, device = "png", dpi = 300)


# Violin plot - Theta Watterson

watt_vplot <- ggplot(data, aes(x=Population,y=ThetaWatt,fill=Population)) +
  geom_violin(trim=FALSE) + 
  labs(x= NULL, y="Watterson's Theta per locus") +
  scale_y_continuous(breaks = seq(-2, 10, by = 2)) +
  theme_classic()+
  scale_fill_manual(values = my_colors) +
  #geom_hline(yintercept = 0, linetype = "dashed", color = "darkgrey") +
  stat_summary(fun=mean, geom="point", shape=16, size=2) +
  theme(legend.position = "none", axis.text.y = element_text(face = "italic")) +
  coord_flip()

watt_vplot

ggsave(paste("watttheta_vplot_paper_allAlps_k5",".png", sep=""), plot = watt_vplot, device = "png", dpi = 300)
