#
# Plot 3.
# Here we try to determine which types of sources (point, nonpoint, on-road, non-road), have seen 
# increases and which have seen decreases in emissions from 1999-2008 for Baltimore City (MD)
# 
# This plot uses the ggplot2 plotting system and shows the PM2.5 emissions, by type, for each of 
# the years 1999, 2002, 2005, and 2008 in Baltimore City (with trend lines)
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

# Write the plots out to a PNG device/file
png(file="plot3.png", height=480, width=1024)

# Summarize the emissions for baltimor city only (fips == 24510)
baltimore_emissions <-   
  emission_data %>% 
  filter(fips == 24510) %>%
  group_by(year, type) %>%
  summarise(emissions = sum(Emissions))
baltimore_emissions$type <- as.factor(baltimore_emissions$type)


# Plot the results with trend lines for each type
qplot(
  main = expression("PM"[2.5]*" emissions per year in Baltimore City (by type)"),
  year, emissions,
  data = baltimore_emissions,
  facets = .~ type,
  col = type,
  geom = c("point", "smooth"),
  method = "lm",
  xlab = "Year",
  ylab = "Emissions (tons)"
)

# Finish writing the PNG file
dev.off()
