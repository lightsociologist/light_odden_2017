#This program develops regression models, tables, and figures
#Light and Odden (2017)

#4/1/2016

library("dplyr")

#This file has all of the relevant pieces including words (wrds)

load("~/GitHub/light_odden_2017/data/tp25.Rda")

#add age of review variable;

tp25$age <- tp25$year.x-1998

library("glmnet")

#construct entropy
tp25$entropy <- -1 * apply(tp25[,17:41]*log(tp25[,17:41],25),1,sum,na.rm=T)

#construct niche
tp25$niche <- 1 - apply(tp25[,17:41]^2, 1, sum, na.rm=T) 

#check correlation
cor(tp25$niche, tp25$entropy)   

#check top loading topic
tp25$hitop <- apply(tp25[,17:41], 1, function(x)which(x==max(x)))
tp25$hitop <- do.call(pmax, tp25[17:41])

#Construct best music accolade with suppressed slope

#This has corrected accolade data


load("~/GitHub/light_odden_2017/data/totpitch.Rda")

library("dplyr")

totpitch$best <- 0;

totpitch$bestwrd <- substr(totpitch$accolade, 1, 4)

totpitch$best <- ifelse(totpitch$bestwrd!='Best', totpitch$best, '1')

totpitch$best <- as.factor(totpitch$best)

tp25 <- left_join(tp25, totpitch)

best25 <- subset(tp25, tp25$year.x > 2002)

options(scipen = 999)


#This is final model for Table3.A

scor.noint <- lm(score ~ V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8 + V9 + V10 
                  + V11 + V12 + V13 + V14 + V15 + V16 + V17 + V18 + V19 + 
                    V20 + V21 + V22 + V23 +  
                    V24 + V25 + 
                   niche + mpolarity + majorlab + cnt + add10 - 1   
                  , data=tp25)

summary(scor.noint)
sum(scor.noint$residuals^2)
anova(scor.noint, scor.selint)


#This is final model for Table3.B

scor.selint <- lm(score ~ V1 + V2 + V3*age + V4 + V5 + V6 + V7 + V8*age + V9 + V10*age 
                  + V11 + V12*age + V13 + V14 + V15 + V16 + V17 + V18*age + V19 + 
                    V20 + V21 + V22 + V23*age +  
                    V24*age + V25 + 
                    niche*age + mpolarity*age + majorlab*age + cnt*age + add10*age + age-1  
                  , data=tp25)

summary(scor.selint)
sum(scor.selint$residuals^2)


#This is final model for Table4.A

best.noint <- glm(best ~ V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8 + V9 + V10 
                 + V11 + V12 + V13 + V14 + V15 + V16 + V17 + V18 + V19 + 
                   V20 + V21 + V22 + V23 +  
                   V24 + V25 + 
                   niche + majorlab + cnt + add10 + mpolarity  - 1   
                 , data=best25, family = "binomial")

summary(best.noint)
logLik(best.noint)

#This is finla model for Table5.B

best2.selint <- glm(best2~ V1 + V2 + V3*age + V4 + V5 + V6 + V7 + V8*age + V9 + V10*age 
                    + V11 + V12*age + V13 + V14 + V15 + V16 + V17 + V18*age + V19 + 
                      V20 + V21 + V22 + V23*age +  
                      V24*age + V25 + 
                      niche*age + mpolarity*age + majorlab*age + cnt*age + add10*age + age-1  
                    , data=best25, family = "binomial")

summary(best2.selint)
logLik(best2.selint)


#Descriptives (Table 1)

 descvar <- c("niche" , "majorlab" , "cnt" , "add10" , "mpolarity")

 descdat <- tp25[descvar]

 descmean <- sapply(descdat, mean, na.rm=TRUE)
 descsd <- sapply(descdat, sd, na.rm=TRUE)
 
mean(tp25$score, na.rm=TRUE)
sd(tp25$score, na.rm=TRUE)

best25$best2 <- as.numeric(best25$best)-1

mean(best25$best2, na.rm=TRUE)
sd(best25$best2, na.rm=TRUE)

#graphs (see diagnostics above)

#expected topic proprtions

tprop <- plot.STM(lda25, type="summary", xlim = c(0, .20))

#network showing correlation

mod.out.corr <- topicCorr(lda25, cutoff=.01)

plot.topicCorr(mod.out.corr)

#topic change over time

prep <- estimateEffect(1:25 ~ s(year), lda25,
                       meta = out$meta, uncertainty = "Global")

om <- as.data.frame(out$meta)

preds <- predict(mod, newdata = data.frame(x=newx), 
                 interval = 'confidence')

plest <- plot.estimateEffect(prep, "year", method = "continuous",
                    model = z, printlegend = FALSE, xaxt = "n", xlab = "Year",
                    main="30 TOPICS", labeltype="frex")

plest <- plot.estimateEffect(prep, "year", method = "continuous")


plot.estimateEffect(prep, "year", method = "continuous", topics = 3, 
                    linecol="Black", printlegend=FALSE, main="3:Emo")


plot.estimateEffect(prep, "year", method = "continuous", topics = 8, 
                    linecol="Black", printlegend=FALSE, main="8:New Wave")


plot.estimateEffect(prep, "year", method = "continuous", topics = 10, 
                    linecol="Black", printlegend=FALSE, main="10:Rap 1")


plot.estimateEffect(prep, "year", method = "continuous", topics = 12, 
                    linecol="Black", printlegend=FALSE, main="12:Hiphop")

plot.estimateEffect(prep, "year", method = "continuous", topics = 15, 
                    linecol="Black", printlegend=FALSE, main="15:Noise")

plot.estimateEffect(prep, "year", method = "continuous", topics = 18, 
                    linecol="Black", printlegend=FALSE, main="18:Lofi")


plot.estimateEffect(prep, "year", method = "continuous", topics = 23, 
                    linecol="Black", printlegend=FALSE, main="23:Metal")

plot.estimateEffect(prep, "year", method = "continuous", topics = 24, 
                    linecol="Black", printlegend=FALSE, main="24:Rap 2")

mscore <- aggregate(score~year.x, data=tp25, FUN=function(x) c(mean=mean(x), count=length(x)))

plot(mscore$year.x, mscore$score, type = "o")