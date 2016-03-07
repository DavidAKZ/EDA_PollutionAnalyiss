source("proj2Common.R")

library(ggplot2)
library(dplyr)

# Q5: How have emissions from motor vehicle sources changed 
#     from 1999–2008 in Baltimore City? 

# Task: Use the ggplot2 plotting system to make a plot

# Use data tables and dplyr functoins
dt.nei <- tbl_df(NEI)
dt.scc <- tbl_df(SCC)

# Search for Short.Name with "Veh" which defines vehicle sources
dt.scc.veh <- dt.scc %>% select(SCC, Short.Name) %>%  # grab needed vars only--more efficient
    filter(grepl("Veh", Short.Name))                  # Look for names identifying "Vehicle"
dt.plot <- dt.nei %>% filter(SCC %in% dt.scc.veh$SCC) %>% 
    filter(fips == "24510") %>% group_by(year) %>% summarize(sum(Emissions))

# now plot
png("plot5.png")
gr <- qplot(year, `sum(Emissions)`, data=dt.plot, color=I("navyblue"), 
            geom=c("point","smooth")) + 
      xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)")) +
      ggtitle(expression("Baltimore Vehicles" ~ PM[2.5] ~ "Emmissions by Year")) 
suppressWarnings(print(gr))
dev.off()
