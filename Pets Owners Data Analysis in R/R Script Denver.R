library(ggplot2)

setwd("/Users/ashar/Desktop/Denver")
files <- list.files(pattern = ".csv")

for (i in files){
  assign(paste("df", i , sep = "_"), read.csv(i, stringsAsFactors = F))
}

names(df_pets.csv)[which(names(df_pets.csv)=="Name")] <- "PetName"
names(df_owners.csv)[which(names(df_owners.csv)=="Name")] <- "OwnerName" 

df_pets <- merge(df_pets.csv,df_owners.csv, by = "OwnerID", all.x = T)
df_procedures <- merge(df_procedures.csv, df_procedure_details.csv, by = c("ProcedureType","ProcedureSubCode"), all.x = T)

df_pets_procedure <- merge(df_pets, df_procedures, by = "PetID", all.x = T )

#---------------------------------------------------------------------------------------------------

pet_procedures <- aggregate(df_pets_procedure$ProcedureType, by= list(df_pets_procedure$PetID,df_pets_procedure$PetName), function(x) sum(!is.na(x)))
names(pet_procedures) <- c("PetID","PetName","Count_Procedures")

#-----Which pet had the most procedures?---------------------------

pet_procedures$PetName[pet_procedures$Count_Procedures==max(pet_procedures$Count_Procedures)]

#----------------------------------------------------------------------------------------------------
Owner_price = aggregate(df_pets_procedure$Price, list(df_pets_procedure$OwnerID), sum, na.rm=T )
names(Owner_price) <- c("OwnerID", "Spend")

#-------Which owner spent the most on a procedure or procedures for his/her pet(s)----------

Owner_price$OwnerID[Owner_price$Spend == max(Owner_price$Spend)]

#----------------------------------------------------------------------------------------------------

#-------What is the mean price per procedure for pets with owners who have a 49503 zip code?

mean(df_pets_procedure$Price[df_pets_procedure$ZipCode == 49503], na.rm = T)

#----------------------------------------------------------------------------------------------------

#----------What percentage of dogs in pets.csv that have a "c" in their name are male?---------------

# character "c" in their name:

c_dogs <- df_pets.csv$Gender[df_pets.csv$Kind == "Dog" & grepl('c',df_pets.csv$PetName)]

# rounding upto 2 decimals
round(sum(c_dogs=="male")/length(c_dogs),2)

#-----------------------------------------------------------------------------------------------------

#---------What is the standard deviation of age for dogs?-----------------

# For Sample with (n-1) Degrees of Freedom(Sample Standard Deviation)
round(sd(df_pets.csv$Age[df_pets.csv$Kind == "Dog"]),2)

# For population(Population Standard Deviation)
age <- df_pets.csv$Age[df_pets.csv$Kind == "Dog"]
round(sqrt(sum((age - mean(age))^2)/length(age)),2)

#-----------------------------------------------------------------------------------------------------

#--------How old is the oldest Parrot-----------

max(df_pets.csv$Age[df_pets.csv$Kind=="Parrot"])

#-----------------------------------------------------------------------------------------------------

#--------What is the mean age of cats?--------
round(mean(df_pets.csv$Age[df_pets.csv$Kind=="Cat"]),2)

#-----------------------------------------------------------------------------------------------------

#--------Box Plot---------

ggplot(data=df_pets.csv, aes(x=Kind, y = Age)) + 
  geom_boxplot(aes(fill=Kind)) +
  xlab("Kind") +
  ylab("Age") +
  ggtitle("GG BOX Plot") +
  theme_classic() +
  scale_fill_manual(values=c("Dog" = "green","Cat"="purple","Parrot" = "orange"))

#-----------------------------------------------------------------------------------------------



