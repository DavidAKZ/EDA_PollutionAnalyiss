source("proj2Common.R")

library(ggplot2)
library(dplyr)

# Q3: Of the four types of sources indicated by the type (point, nonpoint, 
#     onroad, nonroad) variable, which of these four sources have seen decreases 
#     in emissions from 1999–2008 for Baltimore City?
#     Which have seen increases in emissions from 1999–2008?

# Ans: From the plot sources of type nonpoint, onroad, and nonroad have decreases
#      in emmisions from 1999-2008.  Source of type point has a slight increase
#      in emissions from 2005 and 2008

# Task: Use the ggplot2 plotting system to make a plot

# Use data tables and dplyr functoins
dt.nei <- tbl_df(NEI)
# generate subsets to plot
dt.plot <- dt.nei %>% filter(fips == "24510") %>%
                      rename(Type = type) %>%
                      group_by(year, Type) %>% 
                      summarize(sum(Emissions))

# now plot
png("plot3.png")
gr <- qplot(year, `sum(Emissions)`, data=dt.plot, color=Type, 
            geom=c("point","smooth")) + 
      xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)")) +
      ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emmission by Type & Year")) 
suppressWarnings(print(gr))
dev.off()
