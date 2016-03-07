
source("proj2Common.R")

library(dplyr)

# Q1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Ans: Yes, from the plot by code below PM2.5 is sharply reduced from 1999 to 2002
#      then reducing less slightly from 2002 and 2005.  It is sharply reduced again
#      between 2005 and 2008

# Task: Using the base plotting system, make a plot showing the total PM2.5 emission 
#       from all sources for each of the years 1999, 2002, 2005, and 2008.

# Use data tables and dplyr functoins
dt.nei <- tbl_df(NEI)
# tally up all emissions by year
dt.plot <- dt.nei %>% group_by(year) %>% summarize(sum(Emissions))

# now plot
png("plot1.png")
plot(dt.plot$year, dt.plot$`sum(Emissions)`,
     type="o", col="Blue", xlab = "Year", lwd=3,
     ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),        # subscript "2.5"
     main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"),
     panel.first = grid(lwd=2))
dev.off()
