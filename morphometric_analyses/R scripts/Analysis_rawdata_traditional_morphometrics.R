rm(list=ls()) 
library(ggplot2)
library(tidyverse)
library(cowplot)
library(multcompView)
library(MASS)
library(caret)
library(vegan)
library(mvnormtest)
#1) first create species as a factor in the order of the species IDs of the dataset
species <- factor(c("C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. mollis ignifer",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus ab. ticino",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. mollis mollis",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. biguttulus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus",
                    "C. brunneus"
                    
                    
                    
                    
                    
                    
))

ID <- factor(c(
"RP1210",
"RP1211",
"RP1212",
"RP1213",
"RP1214",
"RP1221",
"RP1230",
"RP1231",
"RP1232",
"RP1233",
"RP1234",
"RP1238",
"RP1239",
"RP1240",
"RP1241",
"RP1242",
"RP1243",
"RP1253",
"RP1254",
"RP1255",
"RP1256",
"RP1257",
"RP1258",
"RP1259",
"RP1260",
"RP1261",
"RP1262",
"RP1263",
"RP1264",
"RP1265",
"RP1266",
"RP1267",
"RP1268",
"RP1269",
"RP1270",
"RP1271",
"RP1272",
"RP1273",
"RP1274",
"RP1275",
"RP1276",
"RP1277",
"RP1278",
"RP1280",
"RP1281",
"RP1282",
"RP1283",
"RP1284",
"RP1285",
"RP1286",
"RP1287",
"RP1288",
"RP1289",
"RP1290",
"RP1291",
"RP1292",
"RP1293",
"RP1294",
"RP1295",
"RP1296",
"RP1297",
"RP1298",
"RP1299",
"RP1301",
"RP1302",
"RP1304",
"RP1305",
"RP1312",
"RP1313",
"RP1314",
"RP1315",
"RP1316",
"RP1317",
"RP1338",
"RP1339",
"RP1340",
"RP1341",
"RP1342",
"RP1343",
"RP1344",
"RP1345",
"RP1346",
"RP1347",
"RP1360",
"RP1361",
"RP1362",
"RP1363",
"RP1364",
"RP1365",
"RP1366",
"RP1367",
"RP1368",
"RP1369",
"RP1379",
"RP1380",
"RP1381",
"RP1382",
"RP1383",
"RP1384",
"RP1385",
"RP1386",
"RP1387",
"RP1388",
"RP1403",
"RP1404",
"RP1405",
"RP1406",
"RP1407",
"RP1417",
"RP1418",
"RP1419",
"RP1420",
"RP1421",
"RP1422",
"RP1423",
"RP1424",
"RP1425",
"RP1426",
"RP1427",
"RP1433",
"RP1434",
"RP1435",
"RP1436",
"RP1437",
"RP1438",
"RP1439",
"RP1440",
"RP1441",
"RP1442",
"RP1456",
"RP1457",
"RP1458",
"RP1459",
"RP1460",
"RP1463",
"RP1464",
"RP1465",
"RP1466",
"RP1467",
"RP1468",
"RP1469",
"RP1470",
"RP1479",
"RP1480",
"RP1481",
"RP1482",
"RP1483",
"RP1484",
"RP1485",
"RP1486",
"RP1487",
"RP1488",
"RP1489",
"RP1490",
"RP1493",
"RP1494",
"RP1495",
"RP1496",
"RP1497",
"RP1498",
"RP1499",
"RP1500",
"RP1509",
"RP1510",
"RP1511",
"RP1512",
"RP1513",
"RP1517",
"RP1518",
"RP1519",
"RP1520",
"RP1521",
"RP1531",
"RP1532",
"RP1533",
"RP1534",
"RP1550",
"RP1551",
"RP1552",
"RP1553",
"RP1554",
"RP1555",
"RP1556",
"RP1561",
"RP1562",
"RP1563",
"RP1565",
"RP1569",
"RP1570",
"RP1571",
"RP1572",
"RP1573",
"RP1575",
"RP1576",
"RP1577",
"RP1578",
"RP1579",
"RP1581",
"RP1582",
"RP1583",
"RP1584",
"RP1585"
))





#2) read the data (in a txt file)
TM<-read.table("alps_final.txt",stringsAsFactors = TRUE, header=TRUE, sep="\t")


#3) for PCA, include only measurements, no meta data, so columns between 5 and 17
TM1<-TM[5:17]

#4) PCAs###
t.pca <- prcomp(TM1, center=TRUE, scale.=TRUE)

# add the species to the pca object
t.pca$species<-species
t.pca$ID<-ID
#5) do anova and a post hoc tukey test to a) check if there are any differences 
#in any groups and b) between which groups are differences

###Tukey test
par(mfrow=c(1,1))
for (i in 1:5){
  scores <- t.pca$x[ , i]   
  loadings <- t.pca$rotation
  tukey_data <- data.frame(scores, t.pca$species)
  
  anova <- aov(scores~t.pca$species, data=tukey_data)
  
  
  head(tukey_data)
  summary(anova)
  
  TUKEY<-TukeyHSD(anova, conf.level=.95) 
  library(multcompView)
  plot(TukeyHSD(anova, conf.level=.95), las = 2)
  
  
  generate_label_df <- function(TUKEY, variable){
    
    # Extract labels and factor levels from Tukey post-hoc 
    Tukey.levels <- TUKEY[[variable]][,4]
    Tukey.labels <- data.frame(multcompLetters(Tukey.levels)['Letters'])
    
    #I need to put the labels in the same order as in the boxplot :
    Tukey.labels$treatment=rownames(Tukey.labels)
    Tukey.labels=Tukey.labels[order(Tukey.labels$treatment) , ]
    return(Tukey.labels)
  }
  
  # Apply the function on my dataset
  LABELS <- generate_label_df(TUKEY , "t.pca$species")
  
  #make boxplot with the tukey range groups
  library(ggplot2)
  library(dplyr)
  
  
  df3 <- tukey_data %>% 
    left_join(LABELS, by = c("t.pca.species" = "treatment"))
  head(df3)
  
  
  name <- colnames(t.pca$x)[i] # name of the PCA
  p <- df3 %>% 
    ggplot(aes(x = t.pca.species, y = scores)) +
    geom_boxplot(aes(fill = Letters),alpha=0.5)+
    #geom_violin()+
    geom_point(alpha=0.5)+
    xlab("species")+
    guides(fill=guide_legend(title="groups"))+
    ggtitle(name)+
    theme(axis.text.x = element_text(face = "italic", size=7)) 
  dir <- "C:/Users/sarah/OneDrive/Desktop/Uni/Uni Hohenheim/Master Landscape Ecology/Master thesis/Masks/figures/TM_Tukey_tests"
  plot(p)
  ggsave(paste0(dir,"/",name,".png"),
         device = "png",
         dpi = 300, width = 20, height = 10, units = "cm")
  
}


df1 <- data.frame(t.pca$x) 
df1$species<-species
df1$ID<-ID
t.pca$sdev^2###print numbers of proportion of explained variances

PCAloadings1<-data.frame(Variables=rownames(t.pca$rotation),t.pca$rotation)
df2 = df1 %>% filter(ID %in% c("RP1304","RP1305","RP1312","RP1518","RP1493")) %>% as.data.frame()


  

###########plotting the PCA, get the PC values from the sdev^2 ###############
pt1<- df1 %>% ggplot(aes(PC2, PC1, color = species))+
  geom_point(size = 3, alpha = 0.7) +
  scale_color_manual(values = c("C. brunneus"="#FFD700","C. biguttulus"="#800080","C. mollis mollis"="#056608","C. brunneus ab. ticino"="#B4641E","C. mollis ignifer"="#81D170"))+
  scale_fill_manual(values = c("C. brunneus"="#FFD700","C. biguttulus"="#800080","C. mollis mollis"="#056608","C. brunneus ab. ticino"="#B4641E","C. mollis ignifer"="#81D170"))+
  labs(y="PC1: 6.3%" , x = "PC2: 2.9%")+
  stat_ellipse(geom="polygon",aes(fill = species),alpha=0.1,linetype=1, lwd=1.2)+
  guides(color = guide_legend(override.aes = list(linetype = c(0,0,0,0,0) )))+
  theme(legend.text = element_text(face = c(rep("italic", 5), rep("plain", 5))))+
  theme(legend.background=element_blank())+
  geom_point(data = df2, aes(PC2, PC1),size = 3, shape = 1 , color = "black")
  
  
  ####the loadings are optional and not necessary  
  #+
  #geom_segment(data=PCAloadings1, aes(x=0, y=0, xend=(PC2*10), 
   #                                   yend=(PC1*10)), arrow=arrow(length=unit(1, "picas")),
    #           color="black")+ 
  #annotate("text", x=(PCAloadings1$PC2*10), y=(PCAloadings1$PC1*10), 
   #        label=PCAloadings1$Variables)+
  #theme(legend.text = element_text(face = c(rep("italic", 5), rep("plain", 5)))) 




#############density plot for traditional morphometrics
#ydens <-
 # axis_canvas(pt1, axis = "y", coord_flip = TRUE) + 
  #geom_density(data = df1, aes(x = PC1, fill = species, colour = species), alpha = 0.2) +
  #coord_flip()+
  #scale_color_manual(values = c("C. brunneus"="#FFD700","C. biguttulus"="#800080","C. mollis mollis"="#056608","C. brunneus ab. ticino"="#B4641E","C. mollis ignifer"="#81D170"))+
  #scale_fill_manual(values = c("C. brunneus"="#FFD700","C. biguttulus"="#800080","C. mollis mollis"="#056608","C. brunneus ab. ticino"="#B4641E","C. mollis ignifer"="#81D170"))
#pt1 %>%
  #insert_xaxis_grob(xdens, grid::unit(1, "in"), position = "top") %>%
 # insert_yaxis_grob(ydens, grid::unit(1, "in"), position = "right") %>%
  #ggdraw()

##########LDA##########
#####do some tests to check if the conditions for the LDA are fulfilled

#####multicollinearity test
as.dist(cor(TM1))
faraway::vif(TM1)
#####many variables are multicollinear, so they have to be dropped stepwise (see below)

####drop all multicollinear variables, keep only the 5 uncorrelated variables under the threshold 
TM2<-TM1[3:13]
TM2<-TM2[,-3]
TM2<-TM2[,-1]
TM2<-TM2[,-1]
TM2<-TM2[,-2]
TM2<-TM2[,-7]
TM2<-TM2[,-6]
as.dist(cor(TM2))
faraway::vif(TM2)

###now vif factor is only between 1 and 2, which is acceptable for me


#####assumptions check: homogeneity test

t.hle<-decostand(as.matrix(TM2), "hellinger")
gr<-cutree(hclust(vegdist(t.hle, "euc"), "ward.D"), 5)
table(gr)
t.pars<-as.matrix(TM2)
t.pars.d<-dist(t.pars)
t.MHV<-betadisper(t.pars.d,TM$species)
anova(t.MHV)


####we can accept the homogeneity assumption, as p > 0.05
####normality

TM.transformed.pars2<-as.matrix(TM2)
TM.transformed.pars.d2<-dist(TM.transformed.pars2)
TM.transformed.MHV2<-betadisper(TM.transformed.pars.d2, TM$species)

par(mfrow=c(1,ncol(TM.transformed.pars2)))
for(j in 1:ncol(TM.transformed.pars2)){
  hist(TM.transformed.pars2[,j])
}
par(mar=c(1,1,1,1))


mshapiro.test(t(TM.transformed.pars2))


#####not normally distributed data according to shapiro test, but large sample size justifies a linear model here




df4 <- data.frame(TM2) 
df4$species<-species


#####LDA

# LDA model
#   1.) split data into training dataset and test dataset
#
trainIndex <- createDataPartition(species, 
                                  p = 0.8, 
                                  list = FALSE) 


train <- df4[trainIndex, ] 
test <- df4[-trainIndex, ] 

# Fit an lda Model using training data. the numbers are prior probabilities, i.e. 
#proportions of each species in the whole dataset

model1 <- lda(species ~ ., data = train, prior = c(0.173,0.297,0.273,0.158,0.099))



####predict both the training data and the test data

#####first: Training error
predict.train<-predict(model1, train)
predicted <- predict(model1, newdata = test)  

#####test how well LDA performs in class statistics
confusionMatrix(predicted$class, test$species) 

#####second: Training error 
####confusion matrix for training error
lda_prediction<-predict(model1)
conf<-table(list(predicted=predict.train$class,observed=train$species))

#precision (positive predicted value)
diag(conf)/rowSums(conf)

#sensitivity
diag(conf)/colSums(conf)

confusionMatrix(conf)

#####test error
lda_model2<-lda(species~., data=train, CV=T)
conf2<-table(list(predicted=lda_model2$class,observed=train$species))

####gives an estimate on the mean error (model accuracy)
####compare the mean error between training and test error
mean(predict.train$class == train$species)
mean(predicted$class == test$species)

#the test dataset had a higher error (80% vs. 67% accuracy)



#calculate LD values
(model1$svd^2 / sum(model1$svd^2))*100



#####lda on raw data

library(Morpho)
TM3<-data.frame(TM2)

#####Do the Manova to see if there are any differences among any groups
MAN<-manova(cbind(costal_subcostal_width, tegmen_length.apical_area, tegmen_length.sigma_apex, tegmen_length.tegmen_width, costal_width.subcostal_width)~species, data=TM3)

summary(MAN, test = "Pillai")

####here to additionally see the effect size of species 
library(effectsize)
eta_squared(MAN)
#####very high effect size of species

####Do the LDA (also called CVA)
cva1=CVA(TM3, species, weighting=T, p.adjust.method = "bonferroni", rounds=1000)

######variances show also the LD% values 
cva1$Var

##### cross-validated classification for creating the heat map
typprobs<-typprobClass(cva1$CVscores, groups=species)
print(typprobs)


#####visualisation of the LDA

#####loadings are for the supplementary figures
LDA_loadings.tm<-data.frame(Variables=rownames(cva1$CVvis),cva1$CVvis)


#####LDA 
df4<-data.frame(cva1$CVscores)
df4$ID<-ID
df5 = df4 %>% filter(ID %in% c("RP1304","RP1305","RP1312","RP1518","RP1493")) %>% as.data.frame()
lda.plot <- df4%>% 
  ggplot(aes(x = CV.1, y = CV.2)) +
  geom_point(aes(color = species, shape = species), size = 3) +
  scale_shape_manual(values = c("C. brunneus" = 17, "C. biguttulus" = 17, "C. mollis mollis" = 17, "C. brunneus ab. ticino" = 17, "C. mollis ignifer" = 17))+
  scale_color_manual(values = c("C. brunneus" = "#FFD700", "C. biguttulus" = "#800080", "C. mollis mollis" = "#056608", "C. brunneus ab. ticino" = "#B4641E", "C. mollis ignifer" = "#81D170")) +
  scale_fill_manual(values = c("C. brunneus"="#FFD700","C. biguttulus"="#800080","C. mollis mollis"="#056608","C. brunneus ab. ticino"="#B4641E","C. mollis ignifer"="#81D170"))+
  labs(y = "LD2: 21.27%", x = "LD1: 76.85%") +
  stat_ellipse(aes(fill = species, color = species), geom = "polygon", alpha = 0.1, linetype = 1, lwd = 1.2) +
  guides(color = guide_legend(override.aes = list(linetype = c(0, 0, 0, 0, 0)))) +
  theme(legend.text = element_text(face = c(rep("italic", 5), rep("plain", 5)))) +
  theme(legend.background = element_blank())+
geom_point(data = df5, aes(CV.1, CV.2),size = 3, shape = 2, stroke=1)
#+
#geom_segment(data=LDA_loadings.tm, aes(x=0, y=0, xend=(CV.1*20), 
                                         #yend=(CV.2*20)), arrow=arrow(length=unit(1, "picas")),
              # color="black")+
 # annotate("text", x=(LDA_loadings.tm$CV.1*20), y=(LDA_loadings.tm$CV.2*20), 
        #   label=LDA_loadings.tm$Variables)+
  #theme(legend.text = element_text(face = c(rep("italic", 5), rep("plain", 5))))


