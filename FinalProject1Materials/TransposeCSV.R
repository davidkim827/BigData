# install.packages("sos")


df <- read.csv("Sale_Prices_Msa.csv")
transpose <- t(df)
transpose
#names(transpose) <- transpose[1,]
#transpose <- transpose[-1,]
colnames(transpose) <- transpose[1,]

write.table(transpose, file = "Sale_Prices_MsaTranspose.csv", sep=",",col.names=FALSE,na = "")

# creating a script to create a sql statement that creates tables and columns
importStatement <- 'CREATE TABLE TRANSPOSE ('

for (i in 1:ncol(transpose)){
  importStatement <- paste(importStatement,"c", sep="")
  importStatement <- paste(importStatement,transpose[1,i], sep="")
  importStatement <- paste(importStatement,'DECIMAL(15,4)', sep=" ")
  if(i == ncol(transpose)){
    break
  }
  importStatement <- paste(importStatement,', ',sep="")
}
importStatement <- paste(importStatement, ')',sep="")
print(importStatement)

