source("proj2Common.R")

library(dplyr)

# Q2: Have total emissions from PM2.5 decreased in the Baltimore City, 
#     Maryland (fips == "24510") from 1999 to 2008?
# Ans: Yes, from the plot by code below PM2.5 is sharply reduced from 1999 to 2002
#      then sharply increased from 2002 and 2005.  It is sharply reduced
#      between 2005 and 2008

# Task: Using the base plotting system, make a plot showing above Q

# Use data tables and dplyr functoins
dt.nei <- tbl_df(NEI)
# generate subsets to plot
dt.plot <- dt.nei %>% filter(fips == "24510") %>% 
                      group_by(year) %>%
                      summarize(sum(Emissions))
    
# now plot
png("plot2.png")
plot(dt.plot$year, dt.plot$`sum(Emissions)`, 
     type = "o", col = "red", xlab="Year", lwd=3,
     ylab= expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), 
     main=expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Source & Year"),
     panel.first = grid(lwd=2))
dev.off()
