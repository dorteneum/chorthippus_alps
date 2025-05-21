### R Script for simple pi and Fst plots ###

## I) Pi and Fst
#Here, we use pi and fst output files directly from pixy.

##WS 300##


library(ggplot2)

# Read the pi output file produced by pixy for all the individuals (190) with ws of 300bp 
pi_df<-read.table("~/pixy/outputs_paper_ws300/datasetB_paper_Alps_out_pi.txt",sep="\t",header=T)
pi_df
#            pop chromosome window_pos_1 window_pos_2      avg_pi no_sites count_diffs
#1     m.mollis     RAD_268            1          300 0.032967033       13         369
#2   biguttulus     RAD_268            1          300 0.003366751       13          45
#3     brunneus     RAD_268            1          300 0.070832025       13        1128
#4   t.brunneus     RAD_268            1          300 0.063026589       13         576
#5     m.ignifer    RAD_268            1          300 0.006451170       13          94
#6     m.mollis     RAD_767            1          300 0.065825815       52        1430
#7   biguttulus     RAD_767            1          300 0.048450048       52        2371
#8     brunneus     RAD_767            1          300 0.060115446       52        4749
#9   t.brunneus     RAD_767            1          300 0.060781738       52        6710
#10    m.ignifer    RAD_767            1          300 0.068435013       52        1548

#Note: when there are 0 SNPs (no_sites) in the window, the average pi (avg_pi) is "NA"


# Checking number of SNPs in each window
unique(pi_df$no_sites)
#13 52 35 31 21 27 49 44 29 38 47 23 46 51 43 14 53 10 26  7 40 37 39 33 18 30 24 28 11
#45 41 42  0 25 16 34  5 20 50 15 36 48 17 19 54 12 55 56 57 22 32  6  8  3  9

#Checking which loci of which population does NOT have sites to analyse
loci_0SNPs <- subset(pi_df, no_sites == 0)
print(loci_0SNPs)
#     pop chromosome window_pos_1 window_pos_2 avg_pi no_sites count_diffs count_comparisons
# mmollis  RAD_36005            1          300     NA        0           0                 0            1          300     NA        0           0                 0

#PAPER
#            pop chromosome window_pos_1 window_pos_2 avg_pi no_sites count_diffs
#261    m.mollis   RAD_33924            1          300     NA        0           0
#276    m.mollis   RAD_36005            1          300     NA        0           0
#541    m.mollis   RAD_64899            1          300     NA        0           0
#546    m.mollis   RAD_65281            1          300     NA        0           0
#561    m.mollis   RAD_65993            1          300     NA        0           0
#656    m.mollis   RAD_79928            1          300     NA        0           0
#662  biguttulus   RAD_80139            1          300     NA        0           0
#671    m.mollis   RAD_81266            1          300     NA        0           0
#675    m.ignifer  RAD_81266            1          300     NA        0           0
#726    m.mollis   RAD_89038            1          300     NA        0           0
#782  biguttulus   RAD_96018            1          300     NA        0           0
#1066   m.mollis  RAD_128870            1          300     NA        0           0
#1875   m.ignifer RAD_235847            1          300     NA        0           0
#2061   m.mollis  RAD_267979            1          300     NA        0           0
#2116   m.mollis  RAD_279648            1          300     NA        0           0
#2132 biguttulus  RAD_282102            1          300     NA        0           0
#2247 biguttulus  RAD_297372            1          300     NA        0           0
#2362 biguttulus  RAD_307640            1          300     NA        0           0
#2771   m.mollis  RAD_380727            1          300     NA        0           0
#2932 biguttulus  RAD_400478            1          300     NA        0           0
#3091   m.mollis  RAD_424038            1          300     NA        0           0
#3150   m.ignifer RAD_432150            1          300     NA        0           0

unique(pi_df$pop)
#"m.mollis "   "biguttulus " "brunneus "   "t.brunneus " "m.ignifer" 


# Create new data frame with pi information of just biguttulus
rows_to_keep <- (pi_df$pop == "biguttulus ")
pi_big <- pi_df[rows_to_keep, ]

avg_pi_big <- mean(pi_big[ , "avg_pi"], na.rm = TRUE)
avg_pi_big
#0.03998921 (PAPER)


# Create new data frame with pi information of just brunneus
rows_to_keep <- (pi_df$pop == "brunneus ")
pi_bru <- pi_df[rows_to_keep, ]

avg_pi_bru <- mean(pi_bru[ , "avg_pi"], na.rm = TRUE)
avg_pi_bru
#0.0402525 (PAPER)


# Create new data frame with pi information of just mollis ignifer
rows_to_keep <- (pi_df$pop == "m.ignifer")
pi_mi <- pi_df[rows_to_keep, ]

avg_pi_mi <- mean(pi_mi[ , "avg_pi"], na.rm = TRUE)
avg_pi_mi
#0.03966023 (PAPER)


# Create new data frame with pi information of just mollis mollis
rows_to_keep <- (pi_df$pop == "m.mollis ")
pi_mm <- pi_df[rows_to_keep, ]

avg_pi_mm <- mean(pi_mm[ , "avg_pi"], na.rm = TRUE)
avg_pi_mm
#0.03836479 (PAPER)


# Create new data frame with pi information of just ticino brunneus
rows_to_keep <- (pi_df$pop == "t.brunneus ")
pi_tbru <- pi_df[rows_to_keep, ]

avg_pi_tbru <- mean(pi_tbru[ , "avg_pi"], na.rm = TRUE)
avg_pi_tbru
#0.03836948 (PAPER)


#note: check if the label of the species has space after the name or not and adjust




##PLOTS##

population_colors <- c("m.mollis " = "#056608", "biguttulus " = "#800080","brunneus " = "#FFD700", "t.brunneus " = "#B4641E","m.ignifer" = "#81D170")
#my_colors <- c("#800080", "#FFD700", "#81D170", "#056608", "#B4641E")

# Pi density plot
theme_set(theme_classic())

pi_dplot <- ggplot(pi_df, aes(x = avg_pi, fill = pop)) +
  geom_density(alpha=0.6) +
  labs(x="Average Pi per window (300bp)", fill = "Population") +
  theme(legend.text = element_text(face = "italic")) +
  scale_fill_manual(values = population_colors)
  #scale_fill_manual(values = c("purple", "yellow", "lightgreen","darkgreen", "brown"))
#order of colours goes: big, bru, mi, mm, tbru

pi_dplot
ggsave(paste("pi_dplot_paper_allAlps_k5",".png", sep=""), plot = pi_dplot, device = "png", dpi = 300)

pi_dplot_2 <- ggplot(pi_df, aes(x = avg_pi, fill = pop)) +
  geom_density(alpha=0.4) +
  theme(legend.text = element_text(face = "italic")) +
  labs(x="Average Pi per window (300bp)", fill = "Population")
pi_dplot_2
ggsave(paste("pi_dplot_paper_allAlps_k5_2",".png", sep=""), plot = pi_dplot_2, device = "png", dpi = 300)



# Pi violin plot
theme_set(theme_bw())

pi_vplot <- ggplot(pi_df, aes(pop, avg_pi, fill=pop)) +
  geom_violin() + 
  labs(x="Population", y="Average Pi per window (300bp)") +
  scale_fill_manual(values = population_colors) +
  theme(legend.position = "none", axis.text.x = element_text(face = "italic")) +
  stat_summary(fun=mean, geom="point", shape=16, size=1.5)

pi_vplot
ggsave(paste("pi_vplot_paper_allAlps_k5",".png", sep=""), plot = pi_vplot, device = "png", dpi = 300)

#ggsave(paste("pi_vplot_allAlps_k5",".png", sep=""), plot = pi_vplot, device = "png", dpi = 300)


# Pi boxplot
theme_set(theme_classic())

pi_bplot <- ggplot(pi_df, aes(pop, avg_pi, fill=pop)) +
  geom_boxplot() + 
  labs(x="Populations", y="Average Pi per window (300bp)") +
  scale_fill_manual(values = population_colors) +
  theme(legend.position = "none", axis.text.x = element_text(face = "italic"))

pi_bplot
ggsave(paste("pi_bplot_paper_allAlps_k5",".png", sep=""), plot = pi_bplot, device = "png", dpi = 300)









## II) Fst
# Here, we use FST output files directly from pixy.

##WS 300##

# Provide path to input to FST.
#note: this is the only line you should have to edit to run this code:
fst_df<-read.table("/dss/dsshome1/0A/ra93rey/pixy/outputs_paper_ws300/datasetB_paper_Alps_out_fst.txt",sep="\t",header=T)
fst_df
#           pop1        pop2 chromosome window_pos_1 window_pos_2    avg_wc_fst no_snps
#1     m.mollis  biguttulus     RAD_268            1          300  0.0016845813      12
#2     m.mollis    brunneus     RAD_268            1          300 -0.0169029211      12
#3     m.mollis  t.brunneus     RAD_268            1          300 -0.0304343040      12
#4     m.mollis    m.ignifer    RAD_268            1          300  0.0020540814      12
#5   biguttulus    brunneus     RAD_268            1          300  0.0228466321      12
#6   biguttulus  t.brunneus     RAD_268            1          300  0.0091769130      12
#7   biguttulus    m.ignifer    RAD_268            1          300 -0.0002891132      12
#8     brunneus  t.brunneus     RAD_268            1          300 -0.0428817641      12
#9     brunneus    m.ignifer    RAD_268            1          300  0.0237582706      12
#10  t.brunneus    m.ignifer    RAD_268            1          300  0.0104246272      12



# Checking number of SNPs in each window
unique(fst_df$no_snps)
#12 46 35 30 19 24 49 41 48 29 34 47 16 37 27 43 14 28  7 10 51 26 45 40 36 32 23 17 13
#22 44 18 11 42 52 38 33  5 31 15 53 50 54 39 20 56 25 21  6  8 55  3  9

#Checking which loci of which pair of populations does NOT have sites
loci_0SNPs <- subset(fst_df, no_snps == 0)
print(loci_0SNPs)
#<0 rows> (or 0-length row.names)

loci_NAfst <- fst_df[is.na(fst_df$avg_wc_fst), ]
print(loci_NAfst)
#         pop1      pop2 chromosome window_pos_1 window_pos_2 avg_wc_fst no_snps
#1454 m.mollis  m.ignifer RAD_334122            1          300         NA       6
#PAPER
#           pop1        pop2 chromosome window_pos_1 window_pos_2 avg_wc_fst no_snps
#701    m.mollis  biguttulus   RAD_43943            1          300         NA       5
#704    m.mollis    m.ignifer  RAD_43943            1          300         NA       5
#707  biguttulus    m.ignifer  RAD_43943            1          300         NA       5
#757  biguttulus    m.ignifer  RAD_48732            1          300         NA      10
#1124   m.mollis    m.ignifer  RAD_65993            1          300         NA      19
#1321   m.mollis  biguttulus   RAD_80139            1          300         NA      27
#1341   m.mollis  biguttulus   RAD_81266            1          300         NA      15
#1344   m.mollis    m.ignifer  RAD_81266            1          300         NA      15
#1347 biguttulus    m.ignifer  RAD_81266            1          300         NA      15
#1411   m.mollis  biguttulus   RAD_86270            1          300         NA      16
#1414   m.mollis    m.ignifer  RAD_86270            1          300         NA      16
#1417 biguttulus    m.ignifer  RAD_86270            1          300         NA      16
#1821   m.mollis  biguttulus  RAD_113117            1          300         NA      36
#2077 biguttulus    m.ignifer RAD_126689            1          300         NA       7
#3042   m.mollis    brunneus  RAD_190286            1          300         NA      11
#3324   m.mollis    m.ignifer RAD_212940            1          300         NA       7
#3694   m.mollis    m.ignifer RAD_234139            1          300         NA      12
#4964   m.mollis    m.ignifer RAD_334122            1          300         NA       5
#4985 biguttulus    brunneus  RAD_334929            1          300         NA      16
#5222   m.mollis    brunneus  RAD_356758            1          300         NA       3
#5223   m.mollis  t.brunneus  RAD_356758            1          300         NA       3
#5228   brunneus  t.brunneus  RAD_356758            1          300         NA       3
#5544   m.mollis    m.ignifer RAD_380727            1          300         NA      37


unique(fst_df$pop1)
#"m.mollis "   "biguttulus " "brunneus "   "t.brunneus "
unique(fst_df$pop2)
#"biguttulus " "brunneus "   "t.brunneus " "m.ignifer" 


# Create data frames for each pair of populations and calculate their average fst
#create new data frame with fst information of m mollis and biguttulus
rows_to_keep <- (fst_df$pop1 == "m.mollis " & fst_df$pop2 == "biguttulus ")
fst_mm_big <- fst_df[rows_to_keep, ]
avg_fst_mm_big <- mean(fst_mm_big[ , "avg_wc_fst"], na.rm = TRUE)
avg_fst_mm_big
#0.1788757 (PAPER)
summ_fst_mm_big <- summary(fst_mm_big[ , "avg_wc_fst"])
summ_fst_mm_big
#PAPER
#Min.  1st Qu.   Median     Mean  3rd Qu.     Max.     NA's 
#-0.32847  0.02571  0.10322  0.17888  0.24873  0.99119        5 

#create new data frame with fst information of m mollis and brunneus
rows_to_keep <- (fst_df$pop1 == "m.mollis " & fst_df$pop2 == "brunneus ")
fst_mm_bru <- fst_df[rows_to_keep, ]
avg_fst_mm_bru <- mean(fst_mm_bru[ , "avg_wc_fst"], na.rm = TRUE)
avg_fst_mm_bru
#0.188882 (PAPER)
summ_fst_mm_bru <- summary(fst_mm_bru[ , "avg_wc_fst"])
summ_fst_mm_bru
#PAPER
#    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.     NA's 
#-0.62060  0.02685  0.11039  0.18888  0.27911  0.97839        2 

#create new data frame with fst information of m mollis and ticino brunneus
rows_to_keep <- (fst_df$pop1 == "m.mollis " & fst_df$pop2 == "t.brunneus ")
fst_mm_tbru <- fst_df[rows_to_keep, ]
avg_fst_mm_tbru <- mean(fst_mm_tbru[ , "avg_wc_fst"], na.rm = TRUE)
avg_fst_mm_tbru
#0.1958769 (PAPER)
summ_fst_mm_tbru <- summary(fst_mm_tbru[ , "avg_wc_fst"])
summ_fst_mm_tbru
#PAPER
#     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.     NA's 
#-0.52628  0.02846  0.11396  0.19588  0.29020  0.97977        1  

#create new data frame with fst information of m mollis and m ignifer
rows_to_keep <- (fst_df$pop1 == "m.mollis " & fst_df$pop2 == "m.ignifer")
fst_mm_mi <- fst_df[rows_to_keep, ]
avg_fst_mm_mi <- mean(fst_mm_mi[ , "avg_wc_fst"], na.rm = TRUE)
avg_fst_mm_mi
#0.1477791 (paper)
summ_fst_mm_mi <- summary(fst_mm_mi[ , "avg_wc_fst"])
summ_fst_mm_mi
#(PAPER)
#    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.     NA's 
#-0.65957  0.01857  0.08089  0.14778  0.21543  1.00000        8 


#create new data frame with fst information of biguttulus and brunneus
rows_to_keep <- (fst_df$pop1 == "biguttulus " & fst_df$pop2 == "brunneus ")
fst_big_bru <- fst_df[rows_to_keep, ]
avg_fst_big_bru <- mean(fst_big_bru[ , "avg_wc_fst"], na.rm = TRUE)
avg_fst_big_bru
#0.08847609 (paper)
summ_fst_big_bru <- summary(fst_big_bru[ , "avg_wc_fst"])
summ_fst_big_bru
#(PAPER)
#     Min.   1st Qu.    Median      Mean   3rd Qu.      Max.      NA's 
#-0.176317  0.005307  0.032204  0.088476  0.104202  0.817108         1 

#create new data frame with fst information of biguttulus and ticino brunneus
rows_to_keep <- (fst_df$pop1 == "biguttulus " & fst_df$pop2 == "t.brunneus ")
fst_big_tbru <- fst_df[rows_to_keep, ]
avg_fst_big_tbru <- mean(fst_big_tbru[ , "avg_wc_fst"], na.rm = TRUE)
avg_fst_big_tbru
#0.09894954 (paper)
summ_fst_big_tbru <- summary(fst_big_tbru[ , "avg_wc_fst"])
summ_fst_big_tbru
#(PAPER)
#     Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
#-0.046237  0.009236  0.034690  0.098949  0.116900  0.877648 

#create new data frame with fst information of biguttulus and m ignifer
rows_to_keep <- (fst_df$pop1 == "biguttulus " & fst_df$pop2 == "m.ignifer")
fst_big_mi <- fst_df[rows_to_keep, ]
avg_fst_big_mi <- mean(fst_big_mi[ , "avg_wc_fst"], na.rm = TRUE)
avg_fst_big_mi
#0.1011249 (paper)
summ_fst_big_mi <- summary(fst_big_mi[ , "avg_wc_fst"])
summ_fst_big_mi
#(PAPER)
#    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.     NA's 
#-0.42313  0.00830  0.04847  0.10113  0.12666  0.90753        5 

#create new data frame with fst information of brunneus and ticino brunneus
rows_to_keep <- (fst_df$pop1 == "brunneus " & fst_df$pop2 == "t.brunneus ")
fst_bru_tbru <- fst_df[rows_to_keep, ]
avg_fst_bru_tbru <- mean(fst_bru_tbru[ , "avg_wc_fst"], na.rm = TRUE)
avg_fst_bru_tbru
#0.0104408 (paper)
summ_fst_bru_tbru <- summary(fst_bru_tbru[ , "avg_wc_fst"])
summ_fst_bru_tbru
#(PAPER)
#     Min.   1st Qu.    Median      Mean   3rd Qu.      Max.      NA's 
#-0.042882 -0.003047  0.003962  0.010441  0.014988  0.168069         1 

#create new data frame with fst information of brunneus and m ignifer
rows_to_keep <- (fst_df$pop1 == "brunneus " & fst_df$pop2 == "m.ignifer")
fst_bru_mi <- fst_df[rows_to_keep, ]
avg_fst_bru_mi <- mean(fst_bru_mi[ , "avg_wc_fst"], na.rm = TRUE)
avg_fst_bru_mi
#0.1048829(paper)
summ_fst_bru_mi <- summary(fst_bru_mi[ , "avg_wc_fst"])
summ_fst_bru_mi
#(PAPER)
#     Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
#-0.076356  0.007626  0.041307  0.104883  0.142112  0.970762 

#create new data frame with fst information of ticino brunneus and m ignifer
rows_to_keep <- (fst_df$pop1 == "t.brunneus " & fst_df$pop2 == "m.ignifer")
fst_tbru_mi <- fst_df[rows_to_keep, ]
avg_fst_tbru_mi <- mean(fst_tbru_mi[ , "avg_wc_fst"], na.rm = TRUE)
avg_fst_tbru_mi
#0.1040461 (paper)
summ_fst_tbru_mi <- summary(fst_tbru_mi[ , "avg_wc_fst"])
summ_fst_tbru_mi
#(PAPER)
#     Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
#-0.043204  0.005369  0.036988  0.104046  0.137525  0.957468 



##PREPARATION FOR PLOTS##
# Add pair_pop column to the input "fst_df"
fst_df$pair_pop <- NA
unique(fst_df$pop2)
#"m.mollis "   "biguttulus " "brunneus "   "t.brunneus " "m.ignifer"

for (i in 1:length(fst_df$pair_pop)){
  if(fst_df$pop1[i] == "m.mollis "){
    if(fst_df$pop2[i] == "biguttulus "){
      fst_df$pair_pop[i] <- "mm_big"
    }else{
        if(fst_df$pop2[i] == "brunneus "){
          fst_df$pair_pop[i] <- "mm_bru"
        }else{
          if(fst_df$pop2[i] == "t.brunneus "){
            fst_df$pair_pop[i] <- "mm_tbru"
          }else{
            fst_df$pair_pop[i] <- "mm_mig"
          }
        }
      }
  }else{
    if(fst_df$pop1[i] == "biguttulus "){
      if(fst_df$pop2[i] == "brunneus "){
        fst_df$pair_pop[i] <- "big_bru"
      }else{
        if(fst_df$pop2[i] == "t.brunneus "){
          fst_df$pair_pop[i] <- "big_tbru"
        }else{
          fst_df$pair_pop[i] <- "big_mig"
        }
      }
    }else{
      if(fst_df$pop1[i] == "brunneus "){
        if(fst_df$pop2[i] == "t.brunneus "){
          fst_df$pair_pop[i] <- "bru_tbru"
        }else{
          fst_df$pair_pop[i] <- "bru_mig"
        }
      }else{
        fst_df$pair_pop[i] <- "tbru_mig"
      }
    }
  }
  i <- i+1
}


##PLOTS##

population_colors <- c("m.mollis " = "#056608", "biguttulus " = "#800080","brunneus " = "#FFD700", "t.brunneus " = "#B4641E","m.ignifer" = "#81D170")
#my_colors <- c("#800080", "#FFD700", "#81D170", "#056608", "#B4641E")

# Fst violin plot
theme_set(theme_bw())

fst_vplot <- ggplot(fst_df, aes(pair_pop, avg_wc_fst), fill=pair_pop) +
  geom_violin() + 
  labs(x="Pair of populations", y="Average FST per window (300bp)") +
  theme(legend.position = "none", axis.text.x = element_text(face = "italic"))
#  geom_point(aes(x = summ_fst_big_bru, y =  pair_pop, y = mean(avg_wc_fst), color = Category),
        #   position = position_dodge(width = 0.2), size = 3) +
 # stat_summary(fun = "mean", geom = "text", vjust = -1,
  #             aes(label = round(..y.., 2)),
   #            position = position_dodge(width = 0.2)) +
  

fst_vplot
ggsave(paste("fst_vplot_paper_allAlps_k5",".png", sep=""), plot = fst_vplot, device = "png", dpi = 300)


# Fst boxplot
theme_set(theme_classic())

fst_bplot <- ggplot(fst_df, aes(pair_pop, avg_wc_fst), fill=pair_pop) +
  geom_boxplot() + 
  labs(x="Pair of populations", y="Average FST per window (300bp)") +
  theme(legend.position = "none", axis.text.x = element_text(face = "italic")) +
  scale_fill_manual(values = population_colors)
fst_bplot
ggsave(paste("fst_bplot_paper_allAlps_k5",".png", sep=""), plot = fst_bplot, device = "png", dpi = 300)





























# Plot pi for each population found in the input file
# Saves a copy of each plot in the working directory
if("avg_pi" %in% colnames(inp)){
  pops <- unique(inp$pop)
  for (p in pops){
    thisPop <- subset(inp, pop == p)
    # Plot stats along all chromosomes:
    popPlot <- ggplot(thisPop, aes(window_pos_1, avg_pi, color=chrOrder)) +
      geom_point()+
      facet_grid(. ~ chrOrder)+
      labs(title=paste("Pi for population", p))+
      labs(x="Position of window start", y="Pi")+
      scale_color_manual(values=rep(c("black","gray"),ceiling((length(chrOrder)/2))))+
      theme_classic()+
      theme(legend.position = "none")
    ggsave(paste("piplot_", p,".png", sep=""), plot = popPlot, device = "png", dpi = 300)
  }
} else {
  print("Pi not found in this file")
}


# Plot Dxy for each combination of populations found in the input file
# Saves a copy of each plot in the working directory
if("avg_dxy" %in% colnames(inp)){
  # Get each unique combination of populations
  pops <- unique(inp[c("pop1", "pop2")])
  for (p in 1:nrow(pops)){
    combo <- pops[p,]
    thisPop <- subset(inp, pop1 == combo$pop1[[1]] & pop2 == combo$pop2[[1]])
    # Plot stats along all chromosomes:
    popPlot <- ggplot(thisPop, aes(window_pos_1, avg_dxy, color=chrOrder)) +
      geom_point()+
      facet_grid(. ~ chrOrder)+
      labs(title=paste("Dxy for", combo$pop1[[1]], "&", combo$pop2[[1]]))+
      labs(x="Position of window start", y="Dxy")+
      theme(legend.position = "none")+
      scale_color_manual(values=rep(c("black","gray"),ceiling((length(chrOrder)/2))))+
      theme_classic()+
      theme(legend.position = "none")
    ggsave(paste("dxyplot_", combo$pop1[[1]], "_", combo$pop2[[1]],".png", sep=""), plot = popPlot, device = "png", dpi = 300)
  }
} else {
  print("Dxy not found in this file")
}












pops <- unique(inp$pop)
pops
#"mmollis"    "biguttulus" "brunneus"   "mignifer"  

#I will focus on mmollis
p <- pops[1]
thisPop <- subset(inp, pop == p)

# Plot stats along all chromosomes:
popPlot <- ggplot(thisPop, aes(window_pos_1, avg_pi, color=chrOrder)) +
  geom_point() +
  #facet_grid(. ~ chrOrder)+ #adds smaller subplots to the plot based on the chrOrder variable --> plot will be divided into multiple subplots, each corresponding to a different locus specified by chrOrder
  labs(title=paste("Pi for population", p))+
  labs(x="Position of window start", y="Pi")+
  scale_color_manual(values=rep(c("black","gray"),ceiling((length(chrOrder)/2))))+ #alternates between black and gray colors for each facet (locus) to differentiate between different loci.
  theme_classic()+
  theme(legend.position = "none")
#ggsave(paste("piplot_", p,".png", sep=""), plot = popPlot, device = "png", dpi = 300)



#if want to see the first 3 loci, I subset the table until 1:94
thisLoci <- thisPop[1:24, ]
lchroms <- unique(thisLoci$chromosome)
lchrOrder <- sort(lchroms)
thisLoci$lchrOrder <- factor(thisLoci$chromosome,levels=lchrOrder)

# Plot stats along all chromosomes:
lpopPlot <- ggplot(thisLoci, aes(window_pos_1, avg_pi, color=lchrOrder)) +
  geom_point() +
  facet_grid(. ~ chrOrder)+ #adds smaller subplots to the plot based on the chrOrder variable --> plot will be divided into multiple subplots, each corresponding to a different locus specified by chrOrder
  labs(title=paste("Pi for population", p))+
  labs(x="Position of window start", y="Pi")+
  scale_color_manual(values=rep(c("black","gray"),ceiling((length(lchrOrder)/2))))+ #alternates between black and gray colors for each facet (locus) to differentiate between different loci.
  theme_classic()+
  theme(legend.position = "none")
#ggsave(paste("piplot_", p,".png", sep=""), plot = popPlot, device = "png", dpi = 300)










