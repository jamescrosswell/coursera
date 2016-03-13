#
# Plot 4.
#
# This plot shows how emissions from coal combustion-related sources have changed from 1999-2008
# Across the United States.
#
library(graphics)
library(grDevices)
library(methods)
library(stats)
library(utils)
library(plyr)
library(dplyr)
library(ggplot2)
library(maps)
library(lme4)
library(tidyr)

## Load the data to be analysed
emission_data <- readRDS("data/summarySCC_PM25.rds")
emission_data <- tbl_df(emission_data)

# Load sources indicated by the SCC column in the emmissions data
scc_data <- readRDS("data/Source_Classification_Code.rds")
scc_data <- tbl_df(scc_data)

# Narrow down our sources to only coal combustion related sources
coal_sources <- 
  scc_data %>% 
  filter(grepl("coal", scc_data$EI.Sector, ignore.case=T)) %>%
  select(SCC = SCC)

# Summarize coal emissions per year and per county
coal_emissions <-   
  emission_data %>% 
  filter(SCC %in% coal_sources$SCC) %>%
  group_by(year, fips) %>%
  summarise(emissions = sum(Emissions))

# Work out the "trend" for each county by applying a linear model to the yearly observations for each.
# The slope will be represent the average yearly change in PM2.5 levels (in tons) in that county. The 
# `coef` function converts the resulting coefficients to a data frame. 
trends <- coef(lmList(emissions ~ year | fips, data=coal_emissions))
colnames(trends) <- c("intercept", "slope")
trends$fips <- as.integer(rownames(trends))

# Note that some counties don't only have one year of data, so it's not possible to fit a linear model
# for these... we'll just color these "grey" in our plot along with various other counties that we don't
# have any data for
trends <- trends[complete.cases(trends),]

# We want to put our slopes into colour buckets that we can use to determine the color of each county. 
# The range of "slopes" (i.e. average yearly change in PM2.5 in tons) is from -1042.495 to 2258.704 but
# there are very few values at the extremes and the slopes are close to normally distributed...so a 
# logarithmic color scale would be better. As such, we'll set the breaks using powers of 2, ranging from
# -512 to +512.
breaks <- c(2^seq(-5, 8, 2), 5000)
breaks <- c(rev(-breaks), 0, breaks)
trends$bucket <- cut(trends$slope, breaks)
trends$bucket <- revalue(trends$bucket, c(
    "(-5e+03,-128]" = "less than -128", 
    "(-128,-32]" = "less than -32",
    "(-32,-8]" = "less than -8",
    "(-8,-2]" = "less than -2",
    "(-2,-0.5]" = "less than  -0.5",
    "(-0.5,-0.125]" = "less than -0.125",
    "(-0.125,-0.0312]" = "less than 0.0312",
    "(-0.0312,0]" = "less than zero",
    "(0,0.0312]" = "more than zero",
    "(0.0312,0.125]" = "more than  0.0312",
    "(0.125,0.5]" = "more than 0.125",
    "(0.5,2]" = "more than 0.5",
    "(2,8]" = "more than 2",
    "(8,32]" = "more than 8",
    "(32,128]" = "more than 32",
    "(128,5e+03]" = "more than 128"
    ))

# Merge our trend data with the county.fips dataset so that we know which region and subregion each of 
# our fips codes corresponds to. This lets us color the county appropriately using ggplot2.
data(county.fips)
county_trends <- inner_join(county.fips, trends, by="fips")

# plot counties with ggplot, color coding each state according to the "change" in PM2.5 levels,
# as determined by the slope of the linear model
all_county <- map_data("county")
all_county <- all_county %>% 
  mutate(polyname = as.factor(paste(region, subregion, sep=","))) %>% 
  left_join(county_trends, by="polyname") %>%
  mutate(bucket = addNA(bucket)) %>%
  select(long, lat, group, order, region, subregion, bucket)

# Write the plots out to a PNG device/file
png(file="plot4.png", height=600, width=800)

# Now finally make our plot
colfunc <- colorRampPalette(brewer.pal(11, "RdYlGn"))
bucket_colors <- c(rev(colfunc(16)),"#aaaaaa")
ggplot() +
  geom_polygon( data=all_county, aes(x=long, y=lat, group = group, fill=all_county$bucket)) +
  scale_fill_manual("Mean yearly change (tons)", values = bucket_colors) + 
  ggtitle(expression("Change in PM"[2.5]*" emissions from 1998 to 2008 by county"))

# Finish writing the PNG file
dev.off()
