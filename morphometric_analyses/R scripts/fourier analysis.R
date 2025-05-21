rm(list=ls())
par(mfrow=c(1,1))
library(Momocs)
library(vegan)
library(mvnormtest)
library(multcompView)
library(dplyr)
library(ggplot2)
library(cowplot)
library(factoextra)
library(caret)
library(MASS)


###########################################################################
#load dataset with the wings, for this one first we have to make a list
lf1<-list.files('C:/Users/sarah/OneDrive/Desktop/Uni/Uni Hohenheim/Master Landscape Ecology/Master thesis/Outline_approach/Masks/only_alps_reference')
#creating the path to the mask files

coo<-import_jpg(jpg.paths = lf1)#import the data (here R is picky)
wings.outlines<-Out(coo)#making the outlines containing x and y 
#coordinates from the images

###procrustes superimposition

dat.al.2<-wings.outlines %>% coo_smooth(10) %>%
  coo_center %>% coo_scale %>% 
  coo_alignxax() %>% coo_slidedirection("left") 

wing_stack<-stack(dat.al.2)



dat.al.t2=dat.al.2 #here the groups are predefined for PCA later

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


ID <- factor(c("RP1210",
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
####for supplementary data:
# analysis how many harmonics are needed for fourier
#ef<-efourier(dat.al.t2[1],9)
#hp<-harm_pow(ef)
#plot(hp)

#png(filename = "harmonics_accumulation.png",
  #  width = 15, height = 10, units = "cm", res = 600)
#plot(cumsum(hp[-1]), type='o',
    # main='Cumulated harmonic power without the first harmonic',
    # ylab='Cumulated harmonic power', xlab='Harmonic rank') 
#save(hp, file = paste0(dir, "/cumulated_power.png"))
#dev.off()



#fourier analysis: 9 harmonics are sufficient because they cover >99% of harmonic power
fourier<-efourier(dat.al.t2, n.bh=9, smooth.it=0, norm=FALSE, start=FALSE)
coe_mat<-as.matrix(fourier$coe)
dir <- "C:/Users/sarah/OneDrive/Desktop/Uni/Uni Hohenheim/Master Landscape Ecology/Master thesis/Outline_approach/Figures PCA"
save(fourier, file = paste0(dir, "/fourier.RData"))

####before PCA, we have to check if data (fourier coefficients) fulfil conditions for linear models


######statistics

#2. homogeneity test (Levene test)

fourier.pars<-as.matrix(fourier$coe)
fourier.pars.d<-dist(fourier.pars)
fourier.MHV<-betadisper(fourier.pars.d,species)
anova(fourier.MHV)

####there is homogeneity of variances in covariance matrix because p=0.34 in both tests

#3. shapiro test
fourier.pars.2<-cbind(fourier$coe)
mshapiro.test(t(fourier.pars.2))
par(mfrow=c(1,1))
for(j in 1:ncol(fourier.pars.2)){
  hist(fourier.pars.2[,j])
}

####there is no normal distribution, but due to high sample size, PCA is accepted as valid

####vif test for multicollinearity
faraway::vif(fourier$coe)

# no excessive multicollinearity


###NOT RUN: making minimum and maximum PC shapes (for supplementary figures)
#svg(filename = "max_shape_PC3.svg",
 #width = 15, height = 10, pointsize=12)
#shape<-PCcontrib(wings.pca,nax = 1:3, sd.r=c(5))
#shape$gg+geom_polygon(fill="lightblue", col="black")+
#  theme(
 #  panel.background = element_rect(fill='transparent'),
  #  plot.background = element_rect(fill='transparent', color=NA),
   # panel.grid.major = element_blank(),
   # panel.grid.minor = element_blank(),
    #legend.background = element_rect(fill='transparent'),
   # legend.box.background = element_rect(fill='transparent'))
#dev.off()



####plotting fourier transformations
#const<-calibrate_reconstructions_efourier(dat.al.t2, id = 45, 
                                  # range = c(1,2,3,4,5,6,7,8,9))

#hpow <- calibrate_harmonicpower_efourier(dat.al.t2, nb.h=10)
#boxplot(hpow$q)




######do the pca for visualization of the data and dimensionality reduction

pca <- prcomp(fourier[1:202])
fourier$species<-species
pca$species<-species
pca$ID<-ID
par(mfrow=c(1,1))
pca$sdev^2

###1:5 means testing for PC 1 until PC5
for (i in 1:5){
  scores <- pca$x[ , i]   
  loadings <- pca$rotation
  tukey_data <- data.frame(scores, fourier$species)
  
  anova <- aov(scores~fourier$species, data=tukey_data)
  
  
  head(tukey_data)
  summary(anova)
  
  TUKEY<-TukeyHSD(anova, conf.level=.95) 
  
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
  LABELS <- generate_label_df(TUKEY , "fourier$species")
  
  #make boxplot with the tukey range groups
  library(ggplot2)
  library(dplyr)
  
  
  df <- tukey_data %>% 
    left_join(LABELS, by = c("fourier.species" = "treatment"))
  head(df)
  
  
  name <- colnames(pca$x)[i] # name of the PCA
  p <- df %>% 
    ggplot(aes(x = fourier.species, y = scores)) +
    geom_boxplot(aes(fill = Letters),alpha=0.5)+
    #geom_violin()+
    geom_point(alpha=0.5)+
    xlab("species")+
    ylab("PC scores")+
    guides(fill=guide_legend(title="group"))+
    ggtitle(name)+
    theme(axis.text.x = element_text(face = "italic", size=7)) 
  dir <- "C:/Users/sarah/OneDrive/Desktop/Uni/Uni Hohenheim/Master Landscape Ecology/Master thesis/Masks/figures/EFA_Tukey_tests"
  plot(p)
  ggsave(paste0(dir,"/",name,".png"),
         device = "png",
         dpi = 300, width = 20, height = 10, units = "cm")
  
}
TUKEY###call the test statistic p value and later plot it there. PC2 is significant but not PC1

# making plot for explained variances of the Principal components
#fviz_screeplot(pca, ncp=10,xlab="Principal component", addlabels=TRUE, main=FALSE)



###pca plot: make data frame 
df<-pca$x %>% 
  as.data.frame()

PCAloadings1<-data.frame(Variables=rownames(pca$rotation),pca$rotation)
df_EFA= df %>% filter(ID %in% c("RP1304","RP1305","RP1312","RP1518","RP1493")) %>% as.data.frame()

p1<-df %>% ggplot(aes(PC2, PC1, color = species))+
  geom_point(size = 3, alpha = 0.7)+
  scale_color_manual(values = c("C. brunneus"="#FFD700","C. biguttulus"="#800080","C. mollis mollis"="#056608", "C. brunneus ab. ticino"="#B4641E","C. mollis ignifer"="#81D170"))+
  scale_fill_manual(values = c("C. brunneus"="#FFD700","C. biguttulus"="#800080","C. mollis mollis"="#056608", "C. brunneus ab. ticino"="#B4641E","C. mollis ignifer"="#81D170"))+
  labs(y="PC1: 39.9%" , x = "PC2: 27%")+
  stat_ellipse(geom="polygon",aes(fill = species),alpha=0.1,linetype=1, lwd=1.2)+
  guides(color = guide_legend(override.aes = list(linetype = c(0,0,0,0,0) )))+
  theme(legend.text = element_text(face = c(rep("italic", 5), rep("plain", 5))))+
theme(legend.background=element_blank())+
  geom_point(data = df_EFA, aes(PC2, PC1),size = 3, shape = 1 , color = "black")



# Add density curves to y axis

#ydens <-
  #axis_canvas(p1, axis = "y", coord_flip = TRUE) + 
 # geom_density(data = df, aes(x = PC2, fill = species, colour = species), alpha = 0.2) +
 # scale_color_manual(values = c("C. brunneus"="#FFD700","C. biguttulus"="#800080","C. mollis mollis"="#056608","C. brunneus ab. ticino"="#B4641E","C. mollis ignifer"="#81D170"))+
 # scale_fill_manual(values = c("C. brunneus"="#FFD700","C. biguttulus"="#800080","C. mollis mollis"="#056608","C. brunneus ab. ticino"="#B4641E","C. mollis ignifer"="#81D170"))+
  #coord_flip()
#p1 %>%
 # insert_yaxis_grob(ydens, grid::unit(1, "in"), position = "right") %>%
  #ggdraw()


####linear discriminant analysis

##split data into training and test set
dfx<-data.frame(fourier$coe)
dfx$species<-species
training.individuals<-dfx$species %>% 
  createDataPartition(p=0.8, list=FALSE)
train.data<-dfx[training.individuals,]
test.data<-dfx[-training.individuals,]

#fit the model
model2<-lda(species~., data=train.data,  prior = c(0.173,0.297,0.273,0.158,0.099))


#make predictions
predictions <- model2 %>% predict(train.data)
predictions2 <- model2 %>% predict(test.data)





#model accuracy 
mean(predictions$class==train.data$species)

mean(predictions2$class==test.data$species)

plot(model2, points, col=as.numeric(test.data$species))


####confusion matrix for training error
lda_prediction<-predict(model2)
conf<-table(list(predicted=predictions$class,observed=train.data$species))

#precision (positive predicted value)
diag(conf)/rowSums(conf)

#sensitivity
diag(conf)/colSums(conf)

confusionMatrix(conf)
?confusionMatrix

#####test error
lda_model2<-lda(species~., data=train.data, CV=T)
conf2<-table(list(predicted=lda_model2$class,observed=train.data$species))
confusionMatrix(conf2)


library(Morpho)
#####Do the Manova to see if there are any differences among any groups
MAN<-manova(cbind(A1,A2,A3,A4,A5,A6,A7,A8,A9,B1,B2,B3,B4,B5,B6,B7,B8,B9,C1,
                  C2,C3,C4,C5,C6,C7,C8,C9,D1,D2,D3,D4,D5,D6,D7,D8,D9)~species, data=df_coe)

summary(MAN, test = "Pillai")


#####the effect size:
library(effectsize)
eta_squared(MAN)

#run LDA analysis on whole dataset
cva2=CVA(fourier$coe, species, weighting=T, p.adjust.method = "bonferroni", rounds=1000)



#####showing the proportion of trace of each LD (%variance)
cva2$Var

#####cross-validation for heat map
typprobs<-typprobClass(cva2$CVscores, groups=species)
print(typprobs)


#####in total numbers instead of percentages: 
lda$CV.tab
lda$CV.correct

#####the average correct classification
lda$CV.ce


#####loadings are for the supplementary figures
LDA_loadings.tm<-data.frame(Variables=rownames(cva2$CVvis),cva2$CVvis)


#####LDA 
df5<-data.frame(cva2$CVscores)
df5$ID<-ID

#####for labelling the specific individuals like from Cortignelli
df6 = df5 %>% filter(ID %in% c("RP1304","RP1305","RP1312","RP1518","RP1493")) %>% as.data.frame()

lda.plot <- df5%>% 
  ggplot(aes(x = CV.1, y = CV.2)) +
  geom_point(aes(color = species, shape = species), size = 3) +
  scale_shape_manual(values = c("C. brunneus" = 17, "C. biguttulus" = 17, "C. mollis mollis" = 17, "C. brunneus ab. ticino" = 17, "C. mollis ignifer" = 17))+
  scale_color_manual(values = c("C. brunneus" = "#FFD700", "C. biguttulus" = "#800080", "C. mollis mollis" = "#056608", "C. brunneus ab. ticino" = "#B4641E", "C. mollis ignifer" = "#81D170")) +
  scale_fill_manual(values = c("C. brunneus"="#FFD700","C. biguttulus"="#800080","C. mollis mollis"="#056608","C. brunneus ab. ticino"="#B4641E","C. mollis ignifer"="#81D170"))+
  labs(y = "LD2: 12.32%", x = "LD1: 77.47%") +
  stat_ellipse(aes(fill = species, color = species), geom = "polygon", alpha = 0.1, linetype = 1, lwd = 1.2) +
  guides(color = guide_legend(override.aes = list(linetype = c(0, 0, 0, 0, 0)))) +
  theme(legend.text = element_text(face = c(rep("italic", 5), rep("plain", 5)))) +
  theme(legend.background = element_blank())+
  scale_x_reverse()+
  scale_y_reverse()+
  geom_point(data = df6, aes(CV.1, CV.2),size = 3, shape = 2, stroke=1)#+
#geom_segment(data=LDA_loadings.tm, aes(x=0, y=0, xend=(CV.1*1000), 
                                           #yend=(CV.2*1000)), arrow=arrow(length=unit(1, "picas")),
            # color="black")+
  #annotate("text", x=(LDA_loadings.tm$CV.1*1000), y=(LDA_loadings.tm$CV.2*1000), 
         #  label=LDA_loadings.tm$Variables)+
  #theme(legend.text = element_text(face = c(rep("italic", 5), rep("plain", 5))))



#### figures to show the wing outline:
###see the average shape of each wing
?MSHAPES
ms <- MSHAPES(fourier, fourier$species)
big<-coo_plot(ms$shp$`C. biguttulus`)
bru<-coo_plot(ms$shp$`C. brunneus`)
ticino<-coo_plot(ms$shp$`C. brunneus ab. ticino`)
moll<-coo_plot(ms$shp$`C. mollis mollis`)
ignif<-coo_plot(ms$shp$`C. mollis ignifer`)
