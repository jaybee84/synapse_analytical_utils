# Libraries
library(synapser)
library(synapserutils)
library(tidyverse)
library(stringr) 
synapser::synLogin(email= "",
                   apiKey= "")

# Check for Dates in a gene-expression table

query <- "SELECT * FROM syn22351884"
data <- synTableQuery(query)$asDataFrame()

#Find Regex
vec <- stringr::str_detect(data$Symbol, regex("^[0-9]-[Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec]")) 
sum(vec == TRUE)

#Find the Symbols that Excel converted to dates
data$Symbol[which(vec == TRUE)]

# Replace with gene names
data$Symbol[data$Symbol == "5-Mar"] <- "MARCH5"

# Check if any dates remain

#Store table in Synapse
tableId <- "syn22351884"
table <- Table(tableId, data)
table <- synStore(table)

