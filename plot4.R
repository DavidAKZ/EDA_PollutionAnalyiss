source("proj2Common.R")

library(ggplot2)
library(dplyr)

# Q4: Across the United States, how have emissions from coal combustion-related 
#    sources changed from 1999–2008?

# Ans: Yes, from the plot by code below total US PM2.5 from coal combustion sources
#      is slightly reduced from 1999 to 2002.
#      It ticks up a bit from 2002 and 2005.  
#      It decreases sharply between 2005 and 2008.

# Task: Use the ggplot2 plotting system to make a plot

# Use data tables and dplyr functoins
dt.nei <- tbl_df(NEI)
dt.scc <- tbl_df(SCC)
# generate subsets to plot
# Search for Short.Name with "Coal" and "Comb" which defines coal combustion sources
dt.scc.coal <- dt.scc %>% select(SCC, Short.Name) %>%  # grab needed vars only--more efficient
                          filter(grepl("Coal", Short.Name), grepl("Comb", Short.Name))
#dt.plot <- dt.nei %>% semi_join(dt.scc.coal) %>%  # warning: character/factor mismatch, use filter() instead
dt.plot <- dt.nei %>% filter(SCC %in% dt.scc.coal$SCC) %>% 
    group_by(year) %>% summarize(sum(Emissions))

# now plot
png("plot4.png")
gr <- qplot(year, `sum(Emissions)`, data=dt.plot, color=I("magenta"), 
            geom=c("point","smooth")) + 
      xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)")) +
      ggtitle(expression("US Coal Combustion" ~ PM[2.5] ~ "Emmission by Year")) 

suppressWarnings(print(gr))
dev.off()
