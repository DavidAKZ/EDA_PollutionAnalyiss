source("proj2Common.R")

library(ggplot2)
suppressPackageStartupMessages(library(dplyr))

# Q6: How have emissions from motor vehicle sources changed 
#     from 1999–2008 in Baltimore City? 

# Ans: ???

# Task: Use the ggplot2 plotting system to make a plot

# Use data tables and dplyr functoins
dt.nei <- tbl_df(NEI) # %>% mutate_each(funs(factor), SCC) # get rid of char/factor mismatch
dt.scc <- tbl_df(SCC)

# Search for Short.Name with "Veh" which defines vehicle sources
dt.scc.veh <- dt.scc %>% select(SCC, Short.Name) %>%  # grab needed vars only--more efficient
    filter(grepl("Veh", Short.Name))                  # Look for names identifying "Vehicle"
dt.us <- dt.nei %>% filter(SCC %in% dt.scc.veh$SCC)
dt.baltimore <- dt.us %>% filter(fips == "24510") %>% group_by(year) %>% 
    summarize(sum(Emissions)) %>% mutate(Location=as.factor("Baltimore City"))
dt.la <- dt.us %>% filter(fips == "06037") %>% group_by(year) %>% 
    summarize(sum(Emissions)) %>% mutate(Location=as.factor("LA County"))
dt.plot <- suppressWarnings(full_join(dt.baltimore, dt.la, by = c("year", "sum(Emissions)", "Location")))

# now plot
png("plot6.png")
gr <- qplot(year, `sum(Emissions)`, data=dt.plot, color=Location, 
            geom=c('point', 'smooth')) + 
      xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)")) +
      ggtitle(expression("Baltimore City vs LA County Vehicle" ~ PM[2.5] ~ "Emmissions by Year")) 
suppressWarnings(print(gr))
dev.off()
