r <- read.csv("chu.csv", header = F)

data <- data.frame("hist" = numeric(0),
                   "pap" = numeric(0),
                   "s" = numeric(0))

for(i in 1:nrow(r)){
  if(r[i,1]!=0) data <- rbind(data, matrix(c(1,1,i), byrow = T, r[i,1], 3))
  if(r[i,2]!=0) data <- rbind(data, matrix(c(1,0,i), byrow = T, r[i,2], 3))
  if(r[i,3]!=0) data <- rbind(data, matrix(c(0,0,i), byrow = T, r[i,3], 3))
  if(r[i,4]!=0) data <- rbind(data, matrix(c(0,1,i), byrow = T, r[i,4], 3))
}

write.table(data, "Mplus.txt", col.names = F, row.names = F, sep = "\t")