#This program develops stm models
#Light and Odden (2017)

#4/1/2016

library(stm)

#Importing data and fixing publish year for stm...not needed once data is 
#in r.

readdat <- read.csv("~/GitHub/light_odden_2017/data/pos_rr.txt")

tmp <-  as.Date(readdat$publish_date,'%m/%d/%Y')
tmp2 <- format(tmp,'%Y')


readdat$year <- tmp2

#readdat$year <- as.numeric(readdat$year)

stopvec <- c("album", "song", "music", "record", "records", "track", "tracks", "band", "bands", 
              "albums", "songs",  "time", "shes", "hes",
             "sound", "rock", "doesnt", "theyr", "isnt", "your", "put", "theyv",
             "iv", "who", "youd", "dont", "she", "he", "didnt", "wont"
             )

processed <- textProcessor(readdat$wrds, metadata = readdat, customstopwords=stopvec)


out <- prepDocuments(processed$documents, 
                      lower.thresh=15,
                      processed$vocab, processed$meta)


storpos <- searchK(out$documents, out$vocab, K=seq(5,80,5), 
                     prevalence =~ s(year), data=out$meta, init.type = "Spectral")

plot(storpos)

print(storpos)

plot(storpos$results$semcoh, storpos$results$exclus, )
text(storpos$results$semcoh, storpos$results$exclus, labels=storpos$results$K,
     cex=0.7, pos=2)

#plotting heldout by topics

xax <- seq(5,80,5)

plot(xax, storpos$results$heldout, type="l", col=" bv  black")
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#plotting exclusivity by topics

xax <- seq(5,100,5)
--
plot(xax, storpos$results$exclus, type="l", col="black")

#byones

storbyone <- searchK(out$documents, out$vocab, K=seq(5,`
                                                     80,5), 
                   prevalence =~ s(year), data=out$meta, init.type = "Spectral")


#Run 25 topics

lda25 <- stm(out$documents, out$vocab, K = 25,
                 prevalence =~ s(year), max.em.its = 75,
                 data = out$meta, init.type = "Spectral")

labelTopics(lda25, c(1:25), n=10, frexweight=.75)

labelTopics(lda30, c(1:30), n=20, frexweight=.75)

labelTopics(lda30, c(1:30), n=20, frexweight=.75)

spectheta <- as.data.frame(lda25$theta)
spectheta$id <- 1:nrow(spectheta)
specmeta <- as.data.frame(out$meta)
specmeta$id <- 1:nrow(specmeta)

tot_spec2 <- merge(spectheta, specmeta, by="id")

varad <- read.csv("~/GitHub/light_odden_2017/data/pitchvaradd.csv")

spectheta$id <- 1:nrow(spectheta)
specmeta <- as.data.frame(out$meta)
specmeta$id <- 1:nrow(specmeta)

tot_spec2 <- merge(spectheta, specmeta, by="id")

#merge lda results with 

tp25 <- merge(varad, tot_spec2, by="nid")

#save(tp25, file = "~/GitHub/light_odden_2017/data/tp25.Rda")

#save(spectheta, file = "~/GitHub/light_odden_2017/data/spectheta.Rda")

#save(specmeta, file = "~/GitHub/light_odden_2017/data/specmeta.Rda")

#save(lda25, file = "~/GitHub/light_odden_2017/data/lda25.Rda")

#save(storpos, file = "~/GitHub/light_odden_2017/data/spectralk.Rda")

#save(totpitch, file = "C:/Users/light/Documents/GitHub/light_odden_2017/data/totpitch.Rda")

