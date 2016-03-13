#
# Plot 5.
# This plot illustrates how emissions from motor vehicle sources have changed from 1999-2008 
# in Baltimore City (MD)
#
library(graphics)
library(grDevices)
library(methods)
library(stats)
library(utils)
library(dplyr)
library(ggplot2)
library(scales) 

## Load the data to be analysed
emission_data <- readRDS("data/summarySCC_PM25.rds")
emission_data <- tbl_df(emission_data)

# Load sources indicated by the SCC column in the emmissions data
scc_data <- readRDS("data/Source_Classification_Code.rds")
scc_data <- tbl_df(scc_data)

# Work out which sources relate to motor vehicles
motor_vehicle_sources <- scc_data[grepl("Highway Veh|Motor Vehicle|Motorcycle", scc_data$Short.Name, ignore.case=T),] %>% select(SCC)

# Extract motor vehicle emissions for baltimor city (fips == 24510)
baltimore_emissions <-   
  emission_data %>% 
  filter(fips == 24510) %>%
  inner_join(motor_vehicle_sources, by="SCC") %>%
  group_by(year)

# Summarise the yearly mean for our trend line
mean_emissions <- baltimore_emissions %>% summarise(Emissions=mean(Emissions))

# Write the plots out to a PNG device/file
png(file="plot5.png", height=480, width=640)

# Make the plot
ggplot(
    baltimore_emissions, 
    aes(x=year, y=Emissions, fill=as.factor(year))
  ) +
  geom_smooth(data=mean_emissions, aes(year, Emissions, group=1), method=lm, se=FALSE, lwd=1, col="steelblue") + 
  geom_boxplot(alpha = 0.6) + 
  coord_trans(y="log2") + 
  ggtitle(expression("PM"[2.5]*" emissions from motor vehicles in Baltimore City")) + 
  guides(fill=guide_legend(title="Year"))

# Finish writing the PNG file
dev.off()
