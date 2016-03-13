#
# Plot 2.
# Here we try to determine whether total emissions from PM2.5 have decreased in Baltimor City (MD) 
# from 1999 to 2008. 
# 
# Plot two uses the base plotting system and shows the total PM2.5 emission from all sources, in 
# Baltimore, for each of the years 1999, 2002, 2005, and 2008.
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

# Summarize the emissions for baltimor city only (fips == 24510)
baltimore_emissions <-   
  emission_data %>% 
  filter(fips == 24510) %>%
  group_by(year) %>%
  summarise(emissions = sum(Emissions))

# Write the plots out to a PNG device/file
png(file="plot2.png", height=480, width=640)

# Now plot the results and add a trend line (using a linear regression)
with(baltimore_emissions, {
  plot(
    main = expression("Total PM"[2.5]*" emissions by year in Baltimore City"),
    year, emissions,
    pch = 16,
    col = "firebrick",
    xlab = "Year",
    ylab = "Emissions (tons)"
    )
})
trend <- lm(emissions ~ year, baltimore_emissions)
abline(trend, lwd = 2, col="cadetblue")

# Finish writing the PNG file
dev.off()
