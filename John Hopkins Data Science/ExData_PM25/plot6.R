#
# Plot 6.
# This plot compares emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County and plots a trendline for each. The trendlines 
# illustrate that Motor Vehicle emissions in Baltimore droped more than those in LA County over
# the selected period.
#
library(graphics)
library(grDevices)
library(methods)
library(stats)
library(utils)
library(dplyr)
library(ggplot2)
library(scales) 
library(quantreg)

## Load the data to be analysed
emission_data <- readRDS("data/summarySCC_PM25.rds")
emission_data <- tbl_df(emission_data)

# Load sources indicated by the SCC column in the emmissions data
scc_data <- readRDS("data/Source_Classification_Code.rds")
scc_data <- tbl_df(scc_data)

# Work out which sources relate to motor vehicles
motor_vehicle_sources <- scc_data[grepl("Highway Veh|Motor Vehicle|Motorcycle", scc_data$Short.Name, ignore.case=T),] %>% select(SCC)

# Extract motor vehicle emissions for baltimor city (fips == 24510) and Los Angeles County (fips == 06037)
study_emissions <-   
  emission_data %>% 
  filter(fips %in% c("24510", "06037")) %>%
  inner_join(motor_vehicle_sources, by="SCC") %>%
  mutate(location=ifelse(fips=="24510", "Baltimore", "L.A. County"),emissions=log10(Emissions)) %>%
  select(year, location, emissions) %>%
  group_by(year, location) 

# Write the plots out to a PNG device/file
png(file="plot6.png", height=480, width=640)

# Make the plot
qplot(
  main = expression("Comparison of PM"[2.5]*" motor vehicle emissions (1998 to 2008)"),
  year, emissions,
  data = study_emissions,
  facets = .~ location,
  col = location,
  geom = c("point", "smooth"),
  method = "lm",
  xlab = "Year",
  ylab = expression("log"[10]*" Emissions (tons)")
  ) + 
  guides(colour=guide_legend(title="Location"))

# Finish writing the PNG file
dev.off()
