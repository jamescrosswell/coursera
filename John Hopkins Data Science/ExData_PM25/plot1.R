#
# Plot 1.
# Here we try to determine whether total emissions from PM2.5 have decreased in the United States 
# from 1999 to 2008. 
# 
# Plot one uses the base plotting system and shows the total PM2.5 emission from all sources for 
# each of the years 1999, 2002, 2005, and 2008.
#
library(graphics)
library(grDevices)
library(methods)
library(stats)
library(utils)
library(dplyr)
library(ggplot2)

## Load the data to be analysed
emission_data <- readRDS("data/summarySCC_PM25.rds")
emission_data <- tbl_df(emission_data)

# Load sources indicated by the SCC column in the emmissions data
scc_data <- readRDS("data/Source_Classification_Code.rds")
scc_data <- tbl_df(scc_data)

# Summarize the emissions data by year (note that the emissions are divided by 10^6 so the 
# emissions by year are described in millions of tons rather than in tons)
emissions_by_year <- 
  emission_data %>% 
  group_by(year) %>%
  summarise(emissions = sum(Emissions) / 10^6)

# Write the plots out to a PNG device/file
png(file="plot1.png", height=480, width=640)

# Now plot the results and add a trend line (using a linear regression)
with(emissions_by_year, {
  plot(
    
    main = expression("Total PM"[2.5]*" emissions by year in the U.S."),
    year, emissions,
    pch = 16,
    col = "firebrick",
    xlab = "Year",
    ylab = "Emissions (millions of tons)"
    )
})
trend <- lm(emissions ~ year, emissions_by_year)
abline(trend, lwd = 2, col="cadetblue")

# Finish writing the PNG file
dev.off()
