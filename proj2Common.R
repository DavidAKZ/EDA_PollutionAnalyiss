## Download and unzip file
getRemoteFile <- function(fileUrl, localFname) {
    if (!file.exists(localFname)) {
        localzip <- "./tempfn.zip"
        download.file(fileUrl, localzip, method = "curl")
        if (grep("\\.zip$", localfn) > 0) {  # successful download?
            unzip(localzip)
            unlink(localzip) # remove the uneeded big zip file
        }
    }
}

# Assuming data had been downloaded and in the following directory
setwd("~/Workspace/Coursera/DataScience/4.ExploratoryDataAnalysis/Week4/Project2")

# Download zip if the rds files do not exist in curren dir
remoteFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
getRemoteFile(remoteFile, "Source_Classification_Code.rds")

# Read code table 
SCC <- readRDS("Source_Classification_Code.rds")
# nrow(SCC)  = 11717

# Read PM25 emmision data - this does take time to load a 20 MB file
# Should code up a caching function here for faster testing
NEI <- readRDS("summarySCC_PM25.rds")
# nrow(NEI)  = 6497651
