Applying seafloor climate change data for habitat suitability modeling
================
Chih-Lin Wei
2024-09-12

``` r
library(TaiwanSSP585)
```

# Species occurrence data

We downloaded polychaeta and Alpheus snapping shrimp occurrence data
from [OBIS Eastern China Sea](https://obis.org/area/34302) and [OBIS
South China Sea](https://obis.org/area/34332) using the
[occurrence](https://www.rdocumentation.org/packages/robis/versions/2.11.3/topics/occurrence)
function from the
[robis](https://www.rdocumentation.org/packages/robis/versions/2.11.3)
package. You may choose any other species from
[OBIS](https://mapper.obis.org/) and no. 34302 and 34332 are the area ID
for Eastern and South China Sea. The Fish Database of Taiwan is
downloaded from Global Biodiversity Information Facility
[(GBIF)](https://doi.org/10.15468/dl.e57g23).

``` r
library(robis)

# Download OBIS data
po1 <- occurrence(scientificname = "Polychaeta", areaid = 34302)
po2 <- occurrence(scientificname = "Polychaeta", areaid = 34332)

sh1 <- occurrence(scientificname = "Alpheus", areaid = 34302)
sh2 <- occurrence(scientificname = "Alpheus", areaid = 34332)

# The Fish Database of Taiwan
fis <- cbind(coordinates(fish) %>% as.data.frame(), scientificName=fish$scientificName, Taxa="Fish")

# Combine all occurrence data
occ <- rbind(po1[, c(4:5, 7)] %>% cbind(Taxa="Polychaeta"), 
             po2[, c(4:5, 7)] %>% cbind(Taxa="Polychaeta"), 
             sh1[, c(4:5, 7)] %>% cbind(Taxa="Alpheus Shrimp"), 
             sh2[, c(4:5, 7)] %>% cbind(Taxa="Alpheus Shrimp"),
             fis
             )

occ <- subset(occ, decimalLatitude>=16.5 & decimalLatitude <=28 & decimalLongitude>=113.5 & decimalLongitude <=124.5)
```

Here, let’s look at the first five records of the Polychaeta data.

``` r
library(knitr)

head(po1[, c(4:5, 7)]) %>% kable
```

| decimalLatitude | decimalLongitude | scientificName                     |
|----------------:|-----------------:|:-----------------------------------|
|         30.2500 |         122.7500 | Glycera                            |
|         24.8598 |         123.8397 | Paralvinella                       |
|         28.0000 |         124.0000 | Eunice tubifex                     |
|         29.5000 |         123.0000 | Eunicidae                          |
|         28.0000 |         121.2500 | Mediomastus                        |
|         33.2500 |         123.0000 | Sthenolepis izuensis hwanghaiensis |

There are a total of 6965 occurrence records within or in the vicinity
of the [Taiwan
EEZ](https://marineregions.org/gazetteer.php?p=details&id=8321). We can
then overlay them on top of the
[etopo2022](https://www.ncei.noaa.gov/products/etopo-global-relief-model)
raster to see the data distribution.

``` r
basemap(-etopo2022, title="Depth (m)", colours = terrain.colors(7))+
  geom_point(data=occ, aes(x=decimalLongitude, y=decimalLatitude), size=0.5)+
  facet_wrap(~Taxa)
```

![](tute3_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

# Environmental predictors

Besides extracting data for each coordinate, we can also apply these
data for simple habitat suitability modeling using
[Maxent](https://www.rdocumentation.org/packages/dismo/versions/1.3-14/topics/maxent)
from the
[dismo](https://www.rdocumentation.org/packages/dismo/versions/1.3-14)
package. Here, we’d like to model the species occurrence using the
historical projection from 1950 to 2000 and then the
[Maxent](https://www.rdocumentation.org/packages/dismo/versions/1.3-14/topics/maxent)
model to predict their habitat suitability in 2041 to 2060 and 2081 to
2100. Therefore, we need three sets of annual average of the climate
change projections for 1950 to 2000, 2041 to 2060, and 2081 to 2100.
Because water depth is usually the most critical factor controlling the
species distribution in the deep sea, we also add the
[etopo2022](https://www.ncei.noaa.gov/products/etopo-global-relief-model)
global relief model into the predictors. The predictor names are
modified (e.g., removing the years) to be consistent across 1950 to
2000, 2041 to 2060, and 2081 to 2100 for the convenience of modeling and
predictions.

``` r
hist <- addLayer(etopo2022, cmip6_1950_2000_av)
names(hist)[-1] <- gsub("_av_1950_to_2000", "", names(cmip6_1950_2000_av))

proj1 <- addLayer(etopo2022, cmip6_2041_2060_av)
names(proj1)[-1] <- gsub("_av_2041_2060", "", names(cmip6_2041_2060_av))

proj2 <- addLayer(etopo2022, cmip6_2081_2100_av)
names(proj2)[-1] <- gsub("_av_2081_2100", "", names(cmip6_2081_2100_av))
```

# Species distribution modeling

The commands in
[Maxent](https://www.rdocumentation.org/packages/dismo/versions/1.3-14/topics/maxent)
are pretty simple. We only need a raster brick of predictors and
coordinates of species occurrence to create a model. The historical and
future species’ habitat suitability can be
[predicted](https://www.rdocumentation.org/packages/dismo/versions/1.3-14/topics/predict)
using seafloor climate change data and the Maxent model. As a
demonstration, we will skip all other details, such as the model
validation, performance or variable importance, etc. More details on
applying Maxent and other species distribution modeling methods can be
found in [Hijmans and Elith
(2023)](https://rspatial.org/raster/sdm/raster_SDM.pdf).

``` r
library(dismo)
library(doBy)

# Split the occurrence dat by taxa into a list consisting of two sets of occurrence coordinates
# Conduct Mexent modeling on each set independently
r <- lapply(splitBy(~Taxa, occ), FUN = function(x){
  # Covert the coordinates to spatial point dataframe
  coordinates(x) <- c("decimalLongitude", "decimalLatitude")
  # Maxnet modeling
  me <-maxent(hist, x)
  # Predict habitat suitability
  out <- addLayer(predict(me, hist), predict(me, proj1), predict(me, proj2))
  names(out) <- c("Y1950_2000", "Y2041_2060", "Y2081_2100")
  return(out)
})
```

We can use the
[extract](https://www.rdocumentation.org/packages/raster/versions/3.6-23/topics/extract)
function to take a quick look at the historical predictors used in the
model. This predictor table is corresponded to the previous Argentine
hake table.

``` r
raster::extract(hist, occ[,c("decimalLongitude", "decimalLatitude")]) %>% head(5) %>% kable(digits=3)
```

|     layer |    epc |    o2 |    ph | thetao | arag | calc |   co3 | co3satarag | co3satcalc | aragsat | calcsat |
|----------:|-------:|------:|------:|-------:|-----:|-----:|------:|-----------:|-----------:|--------:|--------:|
| -1920.688 | 11.968 | 0.121 | 7.826 |  5.854 |    0 |    0 | 0.092 |      0.107 |      0.061 |   0.703 |   1.263 |
|   -96.057 | 73.205 | 0.199 | 8.084 | 16.521 |    0 |    0 | 0.193 |      0.069 |      0.044 |   2.806 |   3.492 |
|   -14.713 | 64.602 | 0.223 | 8.141 | 18.425 |    0 |    0 | 0.209 |      0.066 |      0.042 |   3.194 |   3.924 |
|   -26.000 | 58.782 | 0.221 | 8.138 | 18.331 |    0 |    0 | 0.209 |      0.066 |      0.042 |   3.185 |   3.913 |
|   -88.839 | 70.889 | 0.211 | 8.115 | 17.608 |    0 |    0 | 0.202 |      0.067 |      0.043 |   2.996 |   3.738 |

# Habitat suitability projections

Finally, we map the projected habitat suitability of polychaeta and
Alpheus snapping shrimp for the years 1951 to 2000, 2041 to 2060, and
2081 to 2100, respectively.

``` r
library(plyr)

# For each prediction raster brick, mask the raster layer by Argentina EEZ, convert the prediction raster into data frame, and then stack the data frame for ggplot
dat <- lapply(r, FUN=function(x){
  x %>% as.data.frame(xy = TRUE, na.rm = TRUE) %>% gather(-x, -y, key = "var", value = "value")
}) %>% ldply(.id="Taxa")
dat$var <- factor(dat$var, labels=c("1951-2000", "2041-2060", "2081-2100"))

bathy <- etopo2022 %>% as.data.frame(xy=TRUE, na.rm=TRUE)
ggplot(dat) +
  geom_raster(aes(x=x, y=y, fill=value))+
  geom_polygon(data=land, aes(x=X, y=Y, group=PID), fill="bisque2", colour="transparent")+
  geom_sf(data=as(eez, "sf"), fill="transparent", colour="red")+
  geom_contour(data=bathy, aes(x=x, y=y, z=layer), breaks=-200, linetype=2, colour="gray50")+
  geom_contour(data=bathy, aes(x=x, y=y, z=layer), breaks=-4000, linetype=1, colour="gray50")+
  geom_point(data=occ, aes(x=decimalLongitude, y=decimalLatitude), size=0.2)+
  facet_grid(Taxa~var)+
  scale_fill_gradientn(colours=brewer.pal(10, 'RdYlBu') %>% rev, na.value="white")+
  scale_x_continuous(expand = expansion(mult = 0))+
  scale_y_continuous(expand = expansion(mult = 0))+
  labs(x=NULL, y=NULL, fill="Habitat\nSuitability")+
  theme_bw() %+replace% theme(legend.position = "top", legend.key.width =  unit(1, 'cm'))
```

![](tute3_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

# Excercises

- Download other occurrence data from OBIS and display them on maps.

- Construct species distribution models using historical projection
  (1950 t0 2000) with Maxent and predict and map the historical and
  future species habitat suitability from 2041 to 2060 and 2081 to 2100.
