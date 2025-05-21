####Geometric morphometrics (landmark approach)
#rm(list=ls())

library(geomorph)
library(cowplot)
library(rlang)
library(ggplot2)
library(tidyverse)
library(Momocs)
library(lessR)
library(caret)
library(vegan)
library(mvnormtest)
#first load the tps file
wingdata<-readland.tps("alps_dataset.TPS",specID="imageID")
wingdata<-readland.tps("some.TPS",specID="imageID")

sliders=rbind(define.sliders(15:34), define.sliders(35:52),define.sliders(53:70), define.sliders(71:93))

#define factors here

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

specimen_ID <- factor(c("RP1210",
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

#procrustes fit     

winggpa<- gpagen(wingdata, ProcD=TRUE,curves=sliders, PrinAxes=T, Proj=T)



#levene test: long computational time!
winggpa.pars<-as.matrix(winggpa$coords)
winggpa.pars.d<-dist(winggpa.pars)
winggpa.MHV<-betadisper(winggpa.pars.d,species)
anova(winggpa.MHV)

#3. shapiro test

#####make a subset because of long computational time
sampled_rows <- sample(1:dim(winggpa.pars)[1], size = 5000, replace = FALSE)
subset_matrix <- winggpa.pars[sampled_rows, , drop = FALSE]
mshapiro.test(t(subset_matrix))
par(mfrow=c(1,1))
for(j in 1:ncol(winggpa.pars.2)){
  hist(winggpa.pars.2[,j])
}




#PCA plot: analysis: here I use a different formula for pca because of the landmark data
lm_PCA<-gm.prcomp(winggpa$coords)

df1<-lm_PCA$x %>% 
  as.data.frame()

df1$species <- species


#####Tukey test: first do anova, and if anova is significant (p<0.05), 
#do the tukey range test

lm_PCA$species<-species

par(mfrow=c(1,1))
for (i in 1:5){
  scores <- lm_PCA$x[ , i]   
  loadings <- lm_PCA$rotation
  tukey_data <- data.frame(scores, lm_PCA$species)
  
  anova <- aov(scores~lm_PCA$species, data=tukey_data)
  
  
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
  LABELS <- generate_label_df(TUKEY , "lm_PCA$species")
  
  #make boxplot with the tukey range groups
  library(ggplot2)
  library(dplyr)
  
  
  df3 <- tukey_data %>% 
    left_join(LABELS, by = c("lm_PCA.species" = "treatment"))
  head(df3)
  
  
  name <- colnames(lm_PCA$x)[i] # name of the PCA
  p <- df3 %>% 
    ggplot(aes(x = lm_PCA.species, y = scores)) +
    geom_boxplot(aes(fill = Letters),alpha=0.5)+
    #geom_violin()+
    geom_point(alpha=0.5)+
    xlab("species")+
    guides(fill=guide_legend(title="groups"))+
    ggtitle(name)+
    theme(axis.text.x = element_text(face = "italic", size=7)) 
  dir <- "C:/Users/sarah/OneDrive/Desktop/Uni/Uni Hohenheim/Master Landscape Ecology/Master thesis/Masks/figures/LGM_Tukey_tests"
  plot(p)
  ggsave(paste0(dir,"/",name,".png"),
         device = "png",
         dpi = 300, width = 20, height = 10, units = "cm")
  
}



#find and extract eigenvalues for plotting later

PC1<-lm_PCA$d[1]/sum(lm_PCA$d)*100 
PC2<-lm_PCA$d[2]/sum(lm_PCA$d)*100 
PC3<-lm_PCA$d[3]/sum(lm_PCA$d)*100  
PC4<-lm_PCA$d[4]/sum(lm_PCA$d)*100  
PC5<-lm_PCA$d[5]/sum(lm_PCA$d)*100  
PC6<-lm_PCA$d[6]/sum(lm_PCA$d)*100 
PC7<-lm_PCA$d[7]/sum(lm_PCA$d)*100 
PC8<-lm_PCA$d[8]/sum(lm_PCA$d)*100 
PC9<-lm_PCA$d[9]/sum(lm_PCA$d)*100 
PC10<-lm_PCA$d[10]/sum(lm_PCA$d)*100 
###add loadings to pca plot
PCAloadings.lm<-data.frame(Variables=rownames(lm_PCA$rotation),lm_PCA$rotation)

df_LGM= df1 %>% filter(ID %in% c("RP1304","RP1305","RP1312","RP1518","RP1493")) %>% as.data.frame()
?aes
###pca plot
p2<-df1 %>% 
  ggplot(aes(Comp2, Comp1, color = species), alpha=0.8) +
  geom_point(size=3, alpha=0.7) +
  scale_color_manual(values = c("C. brunneus"="#FFD700","C. biguttulus"="#800080","C. mollis mollis"="#056608","C. brunneus ab. ticino"="#B4641E","C. mollis ignifer"="#81D170"))+
  scale_fill_manual(values = c("C. brunneus"="#FFD700","C. biguttulus"="#800080","C. mollis mollis"="#056608","C. brunneus ab. ticino"="#B4641E","C. mollis ignifer"="#81D170"))+
  labs(y="PC1: 47.45%",x = "PC2: 16.46%")+
  stat_ellipse(geom="polygon",aes(fill = species),alpha=0.1,linetype=1, lwd=1.2)+
  guides(color = guide_legend(override.aes = list(linetype = c( 0, 0,0,0,0))))+
  theme(legend.text = element_text(face = c(rep("italic", 5), rep("plain", 5))))+
  theme(legend.background=element_blank())+
geom_point(data = df_LGM, aes(Comp2, Comp1),size = 3, shape = 1 , color = "black")+
geom_segment(data=PCAloadings.lm, aes(x=0, y=0, xend=(Comp2*0.5), 
                                 yend=(Comp3*0.5)), arrow=arrow(length=unit(1, "picas")),
           color="black")+
annotate("text", x=(PCAloadings.lm$Comp2*0.5), y=(PCAloadings.lm$Comp3*0.5), 
        label=PCAloadings.lm$Variables)+
theme(legend.text = element_text(face = c(rep("italic", 5), rep("plain", 5))))




#####LDA: choose non collinear data:

wingdata<-readland.tps("some.TPS",specID="imageID")

sliders=rbind(define.sliders(14:36))

winggpa<- gpagen(wingdata, ProcD=TRUE,curves=sliders, PrinAxes=T, Proj=T)
winggpa$species<-species


#PCA plot: analysis: here I use a different formula for pca because of the landmark data
lm_PCA<-gm.prcomp(winggpa$coords)

df1<-lm_PCA$x %>% 
  as.data.frame()



##split data into training and test set, using first 4 PCs(explain 95% of variation)


df2<-data.frame(lm_PCA$x[,1:36])
df2$species<-species
training.individuals<-df2$species %>% 
  createDataPartition(p=0.8, list=FALSE)
train.data<-df2[training.individuals,]
test.data<-df2[-training.individuals,]



#fit the model
model<-lda(species~., data=train.data,  prior = c(0.173,0.297,0.273,0.158,0.099))



#make predictions
predictions <- model %>% predict(train.data)
predictions2 <- model %>% predict(test.data)


#model accuracy 
mean(predictions$class==train.data$species)

mean(predictions2$class==test.data$species)


####confusion matrix for training error
lda_prediction<-predict(model)
conf<-table(list(predicted=predictions$class,observed=train.data$species))

#precision (positive predicted value)
diag(conf)/rowSums(conf)

#sensitivity
diag(conf)/colSums(conf)

confusionMatrix(conf)


#####test error
lda_model2<-lda(species~., data=train.data, CV=T)
conf2<-table(list(predicted=lda_model2$class,observed=train.data$species))
confusionMatrix(conf2)

#####Do the Manova to see if there are any differences among any groups

####non parametric MANOVA, permutation based
manova_proc <- procD.lm(coords ~ species, data = winggpa, iter = 999)
summary(manova_proc)


###Run LDA on raw data 
#######Visualization of average wings of each species


##here I replace the names of the individuals with species names, for later for making average wing shapes
#dimnames(winggpa$coords)[[3]]<-species
#dimnames(coor)[[3]] # now they are replaced

#ref <- mshape(winggpa$coords)# assign mean shape for use with plotRefToTarget below

# make a new objects based on the coordinates

#coor <- winggpa$coords


#make an object for each species coordinates
#target_species1 <- "C. biguttulus"
#target_species2<-"C. brunneus"
#target_species3<-"C. brunneus ab. ticino"
#target_species4<-"C. mollis mollis"
#target_species5<-"C. mollis ignifer"


#R puts all individuals with the same species name in the same index
#species_index1 <- which(dimnames(coor)[[3]] == target_species1)
#species_index2 <- which(dimnames(coor)[[3]] == target_species2)
#species_index3 <- which(dimnames(coor)[[3]] == target_species3)
#species_index4 <- which(dimnames(coor)[[3]] == target_species4)
#species_index5 <- which(dimnames(coor)[[3]] == target_species5)


#transform data
#subset_array1 <- coor[, , species_index1, drop = FALSE]
#subset_array2 <- coor[, , species_index2, drop = FALSE]
#subset_array3 <- coor[, , species_index3, drop = FALSE]
#subset_array4 <- coor[, , species_index4, drop = FALSE]
#subset_array5 <- coor[, , species_index5, drop = FALSE]


# create mean shape of each taxon
#big<-mshape(subset_array1)
#bru<-mshape(subset_array2)
#tic<-mshape(subset_array3)
#mol<-mshape(subset_array4)
#ign<-mshape(subset_array5)


#Thin plate spline: aesthetics

#GP1 <- gridPar(pt.bg = "lightblue", pt.size = 1.2,link.col = "#800080", tar.link.col="#800080", link.lwd=2, grid.col = "grey",
               
               #grid.lwd = 2,out.col = "#800080",
               #out.cex = 1,
               #grid.lty = 1,
               #tar.out.col = "#800080",
               #tar.out.cex = 2,
               #n.col.cell=30)

#plot the wings. I used a magnification of shape changes to visualize it better

#plotRefToTarget(ref,big, method=c("vector"), mag=5, gridPars = GP1)
#plotRefToTarget(ref,bru, method=c("vector"), mag=5, gridPars = GP1)
#plotRefToTarget(ref,tic, method=c("vector"), mag=5, gridPars = GP1)
#plotRefToTarget(ref,mol, method=c("vector"), mag=5, gridPars = GP1)
#plotRefToTarget(ref,ign, method=c("vector"), mag=5, gridPars = GP1)

#####LDA
cva1=CVA(winggpa$coords, species, weighting=T, p.adjust.method = "bonferroni", rounds=1000)


#####supplementary figure
##### visualize a shape change from score -5 to 5:
#cvvis5 <- 0.1*matrix(cva1$CVvis[,1],nrow(cva1$Grandm),ncol(cva1$Grandm))+cva1$Grandm
#cvvisNeg5 <- -0.1*matrix(cva1$CVvis[,1],nrow(cva1$Grandm),ncol(cva1$Grandm))+cva1$Grandm



typprobs<-typprobClass(cva1$CVscores, groups=species)
print(typprobs)


rownames(cva1$CVvis)<-c(
 "1.x","2.x", "3.x","4.x",
                        "5.x",
                        "6.x",
                        "7.x",
                        "8.x",
                        "9.x",
                        "10.x",
                        "11.x",
                        "12.x",
                        "13.x",
                        "14.x",
                        "15.x",
                        "16.x",
                        "17.x",
                        "18.x",
                        "19.x",
                        "20.x",
                        "21.x",
                        "22.x",
                        "23.x",
                        "24.x",
                        "25.x",
                        "26.x",
                        "27.x",
                        "28.x",
                        "29.x",
                        "30.x",
                        "31.x",
                        "32.x",
                        "33.x",
                        "34.x",
                        "35.x",
                        "36.x",
 "1.y","2.y",
                         "3.y",
                        "4.y",
                        "5.y",
                        "6.y",
                        "7.y",
                        "8.y",
                        "9.y",
                        "10.y",
                        "11.y",
                        "12.y",
                        "13.y",
                        "14.y",
                        "15.y",
                        "16.y",
                        "17.y",
                        "18.y",
                        "19.y",
                        "20.y",
                        "21.y",
                        "22.y",
                        "23.y",
                        "24.y",
                        "25.y",
                        "26.y",
                        "27.y",
                        "28.y",
                        "29.y",
                        "30.y",
                        "31.y",
                        "32.y",
                        "33.y",
                        "34.y",
                        "35.y",
                        "36.y"
                       )



LDA_loadings.lm<-data.frame(Variables=rownames(cva1$CVvis),cva1$CVvis)

cva1$CVvis
cva1$Var


df2<-data.frame(cva1$CVscores)
df2$ID<-ID
df3 = df2 %>% filter(ID %in% c("RP1304","RP1305","RP1312","RP1518","RP1493")) %>% as.data.frame()

lda.plot <- df2%>% 
  ggplot(aes(x = CV.1, y = CV.2)) +
  geom_point(aes(color = species, shape = species), size = 3) +
  scale_shape_manual(values = c("C. brunneus" = 17, "C. biguttulus" = 17, "C. mollis mollis" = 17, "C. brunneus ab. ticino" = 17, "C. mollis ignifer" = 17))+
  scale_color_manual(values = c("C. brunneus" = "#FFD700", "C. biguttulus" = "#800080", "C. mollis mollis" = "#056608", "C. brunneus ab. ticino" = "#B4641E", "C. mollis ignifer" = "#81D170")) +
  scale_fill_manual(values = c("C. brunneus"="#FFD700","C. biguttulus"="#800080","C. mollis mollis"="#056608","C. brunneus ab. ticino"="#B4641E","C. mollis ignifer"="#81D170"))+
  labs(y = "LD2: 14.39%", x = "LD1: 76.04%") +
  stat_ellipse(aes(fill = species, color = species), geom = "polygon", alpha = 0.1, linetype = 1, lwd = 1.2) +
  guides(color = guide_legend(override.aes = list(linetype = c(0, 0, 0, 0, 0)))) +
  theme(legend.text = element_text(face = c(rep("italic", 5), rep("plain", 5)))) +
  theme(legend.background = element_blank())+
  geom_point(data = df3, aes(CV.1, CV.2),size = 3, shape = 2, stroke=1)+
  geom_segment(data=LDA_loadings.lm, aes(x=0, y=0, xend=(CV.1*2000), 
                                         yend=(CV.2*2000)), arrow=arrow(length=unit(1, "picas")),
               color="black")+
  annotate("text", x=(LDA_loadings.lm$CV.1*2000), y=(LDA_loadings.lm$CV.2*2000), 
           label=LDA_loadings.lm$Variables)+
  theme(legend.text = element_text(face = c(rep("italic", 5), rep("plain", 5))))

