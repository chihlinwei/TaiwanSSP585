Extract seafloor climate change data by polygon, polyline, or points
================
Chih-Lin Wei
2024-09-19

``` r
library(TaiwanSSP585)
```

# Seafloor habitats within Taiwan EEZ

In this analysis, we want to extract and display [Taiwan
EEZ’s](https://marineregions.org/gazetteer.php?p=details&id=8321)
seafloor climate change data. We can do that by
[mask](https://www.rdocumentation.org/packages/raster/versions/3.6-26/topics/mask)ing
the
[etopo2022](https://www.ncei.noaa.gov/products/etopo-global-relief-model)
raster with Taiwan EEZ. We can see that the Taiwan EEZ consists of
continental shelf (0-200 m) and continental slope (200-4000 m). The
shelf is indicated by gray dashed contour lines and the slope by gray
solid contour lines. Additionally, submarine canyons [(Harris and
Whitway, 2011)](https://doi.org/10.1016/j.margeo.2011.05.008) are
indicated by blue solid lines, seamounts [(Kim and Wessel,
2011)](https://doi.org/10.1111/j.1365-246X.2011.05076.x) by green dots,
hydrothermal vents [(Beaulieu et al.,
2020)](https://doi.pangaea.de/10.1594/PANGAEA.917894) by red dots, cold
water corals [(CWC)](http://data.unep-wcmc.org/datasets/3) by black
dots, and selected marine protected areas
([MPA](https://iocean.oca.gov.tw/OCA_OceanConservation/Default.aspx)) as
polygons.

``` r
basemap(-etopo2022, title="Depth (m)", colours = terrain.colors(7))+
  geom_sf(data=as(canyon, "sf"), size=2, colour="blue")+
  geom_sf(data=as(seamount, "sf"), size=2, colour="green")+
  geom_sf(data=as(vent, "sf"), size=2, colour="red")+
  geom_sf(data=as(coral, "sf"), size=2, colour="black")+
  geom_sf(data=as(dongshaatoll, "sf"), fill = "transparent")+
  geom_sf(data=as(taijiang, "sf"), fill = "transparent")+
  geom_sf(data=as(whitedolphin, "sf"), fill = "transparent")+
  geom_sf(data=as(offshorewindplan, "sf"), fill = "transparent")
```

![](tute2_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

# Climate change hazards

For example, we can mask the climate change hazards between 2041 and
2060 by the Taiwan EEZ polygon. The following maps show the degree of
climate change (or climate change hazards) from 2041 to 2060 in the unit
of historical variability from 1950 to 2014. We can see the variations
within the EEZ better this way.

``` r
plotmap(r=cmip6_2041_2060_exsd %>% subset(1:4) %>% mask(eez),
         titles = c("Delta~POC~flux~(sigma)", "Delta~DO~(sigma)", "Delta~pH~(sigma)", "Delta~Temperature~(sigma)"))
```

![](tute2_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

We can also show climate change hazards between 2041 and 2060 in
submarine canyons

``` r
plotmap(r=cmip6_2041_2060_exsd %>% subset(1:4) %>% mask(canyon),
         titles = c("Delta~POC~flux~(sigma)", "Delta~DO~(sigma)", "Delta~pH~(sigma)", "Delta~Temperature~(sigma)"))
```

![](tute2_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

The climate change hazards between 2041 and 2060 on seamounts, cold
water corals, and vents are plotted together.

``` r
# Mask raster layers by seamount and CWC and then merge them together 
out <- merge(cmip6_2041_2060_exsd %>% subset(1:4) %>% mask(seamount), cmip6_2041_2060_exsd %>% subset(1:4) %>% mask(coral), cmip6_2041_2060_exsd %>% subset(1:4) %>% mask(vent))
names(out) <- names(cmip6_2041_2060_exsd)[1:4]
plotmap(r=out, titles = c("Delta~POC~flux~(sigma)", "Delta~DO~(sigma)", "Delta~pH~(sigma)", "Delta~Temperature~(sigma)"))
```

![](tute2_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

The climate change hazards between 2041 and 2060 in Dongsha Atoll
National Park, Taijiang National Park, White Dolphin habitat, and
offshore wind farms are plotted together.

``` r
# Mask raster layers by seamount and CWC and then merge them together 
out <- merge(cmip6_2041_2060_exsd %>% subset(1:4) %>% mask(dongshaatoll), cmip6_2041_2060_exsd %>% subset(1:4) %>% mask(taijiang), cmip6_2041_2060_exsd %>% subset(1:4) %>% mask(whitedolphin), cmip6_2041_2060_exsd %>% subset(1:4) %>% mask(offshorewindplan))
names(out) <- names(cmip6_2041_2060_exsd)[1:4]
plotmap(r=out, titles = c("Delta~POC~flux~(sigma)", "Delta~DO~(sigma)", "Delta~pH~(sigma)", "Delta~Temperature~(sigma)"))
```

![](tute2_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

Here, we mask the raster layers of climate change hazards by spatial
objects (i.e., polygons, polylines, or spatial points) and use violin
plots to show the climate change hazards from 2041 to 2060 within Taiwan
EEZ separated by 200-m and 4000-m depth contours (i.e., continental
shelf, slope, and abyssal plain). We can also show the projections of
submarine canyons, seamounts, coldwater coral, hydrothermal vents,
national parks, white dolphin habitat, and offshore wind farms within
the EEZ together.

``` r
# Custom function to mask habitats
mask_habitat <- function(x){
  pred <- addLayer(etopo2022, x)
  # Mask continental margin
  ma <- pred %>% mask(eez) %>% as.data.frame(xy = TRUE, na.rm = TRUE)
  ma$Habitat <- cut(-ma$layer, c(0, 200, 4000, 7000), labels=c("Shelf", "Slope", "Abyss"))
  # Mask submarine canyons
  sc <- pred %>% mask(canyon) %>% mask(eez) %>% as.data.frame(xy = TRUE, na.rm = TRUE)
  sc$Habitat <- "Canyon"
  # Mask seamounts
  sm <- pred %>% mask(seamount) %>% mask(eez) %>% as.data.frame(xy = TRUE, na.rm = TRUE)
  sm$Habitat <- "Seamount"
  # Mask cold water corals
  cwc <- pred %>% mask(coral) %>% mask(eez) %>% as.data.frame(xy = TRUE, na.rm = TRUE)
  cwc$Habitat <- "CWC"
  # Mask vent
  ve <- pred %>% mask(vent) %>% mask(eez) %>% as.data.frame(xy = TRUE, na.rm = TRUE)
  ve$Habitat <- "Vent"
  # Mask Dongsha Atoll National Park
  do <- pred %>% mask(dongshaatoll) %>% as.data.frame(xy = TRUE, na.rm = TRUE)
  do$Habitat <- "Dongsha"
  # Mask Taijiang National Park
  ta <- pred %>% mask(taijiang) %>% as.data.frame(xy = TRUE, na.rm = TRUE)
  ta$Habitat <- "Taijiang"
  # Mask White Dolphin Habitat
  wh <- pred %>% mask(whitedolphin) %>% as.data.frame(xy = TRUE, na.rm = TRUE)
  wh$Habitat <- "Dolphin"
  # Mask offshore wind farms
  of <- pred %>% mask(offshorewindplan) %>% as.data.frame(xy = TRUE, na.rm = TRUE)
  of$Habitat <- "Windfarm"
  # Combine and stack data frame
  rbind(ma, sc, sm, cwc, ve, do, ta, wh, of) %>% gather(-x, -y, -layer, -Habitat, key = "var", value = "value", factor_key=TRUE)
}
```

``` r
out <- cmip6_2041_2060_exsd %>% subset(1:4) %>% mask_habitat
out$var <- factor(out$var, labels=c("Delta~POC~flux~(sigma)", "Delta~DO~(sigma)", "Delta~pH~(sigma)", "Delta~Temperature~(sigma)"))

# Habitat with > 5 data points for violin plot
vio <- with(out, Habitat=="Shelf"|Habitat=="Slope"|Habitat=="Abyss"|Habitat=="Canyon"|Habitat=="Seamount")

ggplot()+
  geom_violin(data=subset(out, vio), aes(x=Habitat, y=value), scale = "width")+
  geom_point(data=subset(out, !vio), aes(x=Habitat, y=value))+
  facet_wrap(~var, scales="free", nrow=2, labeller=label_parsed)+
  labs(y="Climate Change Hazards")+
  theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust=1))
```

![](tute2_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

# Time of emergence of climate changes

The following maps and violin plots illustrate when climate changes
exceed two times the historical standard deviation (or the year when the
value of climate change hazards \> 2). We use two times of the standard
deviation because in a roughly normal data set, values within one
standard deviation of the mean account for about 68% of the set, while
values within two standard deviations account for about 95%.

``` r
plotmap(cmip6_extoe_constant %>% subset(1:4) %>% mask(eez), colours = brewer.pal(10, 'RdYlBu'), 
         titles=c("When~Delta~POC~flux>2*sigma", "When~Delta~DO>2*sigma", "When~Delta~pH>2*sigma", "When~Delta~Temperature>2*sigma"))
```

![](tute2_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

``` r
out <- cmip6_extoe_constant %>% subset(1:4) %>% mask_habitat
out$var <- factor(out$var, labels=c("When~Delta~POC~flux>2*sigma", "When~Delta~DO>2*sigma", "When~Delta~pH>2*sigma", "When~Delta~Temperature>2*sigma"))

# Habitat with > 5 data points for violin plot
vio <- with(out, Habitat=="Shelf"|Habitat=="Slope"|Habitat=="Abyss"|Habitat=="Canyon"|Habitat=="Seamount")

ggplot()+
  geom_violin(data=subset(out, vio), aes(x=Habitat, y=value), scale = "width")+
  geom_point(data=subset(out, !vio), aes(x=Habitat, y=value))+
  facet_wrap(~var, scales="free", labeller=label_parsed)+
  labs(y="Time of Emergence of Climate Change")+
  theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust=1))
```

![](tute2_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

Next, we show the years when climate changes for export POC flux,
dissolved oxygen, pH, and temperature simultaneously exceed twice the
historical variability.

``` r
all <- overlay(subset(cmip6_extoe_constant, 1:4), fun=max) %>% mask(eez)
names(all) <- "cmip6_extoe_constant"

p1 <- basemap(r=all, title="When~climate~change>2*sigma", colours=brewer.pal(10, 'RdYlBu'))

out <- mask_habitat(all)

# Habitat with > 5 data points for violin plot
vio <- with(out, Habitat=="Shelf"|Habitat=="Slope"|Habitat=="Abyss"|Habitat=="Canyon"|Habitat=="Seamount")

# Violin plots
p2 <- ggplot()+
  geom_violin(data=subset(out, vio), aes(x=Habitat, y=value), scale = "width")+
  geom_point(data=subset(out, !vio), aes(x=Habitat, y=value))+
  labs(y="Time of Emergence of Climate Change")+
  theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust=1))
```

``` r
p2+p1
```

![](tute2_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

# Cumulative impact of climate change hazards

Another application involves calculating the cumulative impacts of
climate change hazards. The negative hazards are caused by declining
export POC flux, deoxygenation, ocean acidification, and ocean warming.
The positive impacts are increasing export POC flux, oxygenation, ocean
basification, and ocean cooling. Here, we use the same function to
calculate cumulative negative and positive impacts caused by climate
change hazards.

``` r
cum_imp <- function(r){
  # Negative cumulative impact (exposure to climate change hazards for epc<0, o2<0, ph<0, and thetao>0)
  neg <- addLayer(calc(subset(r, 1:3), fun=function(x){x[x>0]<-NA; return(-x)}),
                    calc(subset(r, 4), fun=function(x){x[x<0]<-NA; return(x)})
                    ) %>% overlay(fun=function(x)sum(x, na.rm=T))

  # Positive cumulative impact (exposure to climate change hazards for epc>0, o2>0, ph>0, and thetao<0)
  pos <- addLayer(calc(subset(r, 1:3), fun=function(x){x[x<0]<-NA; return(x)}),
                    calc(subset(r, 4), fun=function(x){x[x>0]<-NA; return(-x)})
                    ) %>% overlay(fun=function(x)sum(x, na.rm=T))
  
  out <- addLayer(neg, pos)
  names(out) <- c("Negative", "Positive")
  out <- mask(out, etopo2022)
  return(out)
}
```

``` r
plotmap(r=cum_imp(cmip6_2041_2060_exsd) %>% mask(eez),
         titles=c("Cumulative~negative~impact~(sigma)", "Cumulative~positivce~impact~(sigma)"))
```

![](tute2_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

``` r
out <- cum_imp(cmip6_2041_2060_exsd) %>% mask_habitat
out$var <- factor(out$var, labels=c("Cumulative~negative~impact~(sigma)", "Cumulative~positivce~impact~(sigma)"))

# Habitat with > 5 data points for violin plot
vio <- with(out, Habitat=="Shelf"|Habitat=="Slope"|Habitat=="Abyss"|Habitat=="Canyon"|Habitat=="Seamount")

ggplot()+
  geom_violin(data=subset(out, vio), aes(x=Habitat, y=value), scale = "width")+
  geom_point(data=subset(out, !vio), aes(x=Habitat, y=value))+
  facet_wrap(~var, scales="free", labeller=label_parsed)+
  labs(y="Cumulative Climate Change Impact")+
  theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust=1))
```

![](tute2_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

# Climate velocity

An important factor for species’ survival is how quickly they need to
move to adjust to current environmental conditions and keep up with
climate changes. Local climate velocity can be calculated by measuring
the rate of change of a specific variable (like temperature) over time
and dividing it by the corresponding spatial gradient of that variable
within a 3x3 area. Areas with low local climate velocities may be good
candidates for protection, as they could act as climatic refuges and are
often associated with high levels of endemic species. It’s important to
note that in deep seafloor environments, like the abyssal plain, the
spatial gradient may be small, resulting in high climate velocities. Our
example shows the average seafloor gradient-based climate velocity
magnitudes from 2041 to 2060 within Taiwan EEZ.

``` r
plotmap(r=cmip6_2041_2060_voccMeg %>% subset(1:4) %>% mask(eez),
         titles = c("POC~flux~(km~yr^-1)", "DO~(km~yr^-1)", "pH~(km~yr^-1)", "Temperature~(km~yr^-1)"),
         ranges=c(0.01, 0.99)
         )
```

![](tute2_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

``` r
out <- cmip6_2041_2060_voccMeg %>% subset(1:4) %>% mask_habitat
out$var <- factor(out$var, labels=c("POC~flux~(km~yr^-1)", "DO~(km~yr^-1)", "pH~(km~yr^-1)", "Temperature~(km~yr^-1)"))

# Habitat with > 5 data points for violin plot
vio <- with(out, Habitat=="Shelf"|Habitat=="Slope"|Habitat=="Abyss"|Habitat=="Canyon"|Habitat=="Seamount")

ggplot()+
  geom_violin(data=subset(out, vio), aes(x=Habitat, y=value), scale = "width")+
  geom_point(data=subset(out, !vio), aes(x=Habitat, y=value))+
  facet_wrap(~var, scales="free", labeller=label_parsed)+
  labs(y="Climate Velocity Magnitudes")+
  theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust=1))
```

![](tute2_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

# Cumulative impact based on climate velocity

We can calculate the overall negative impact of climate velocity by
considering the impacts of decreasing food supply, deoxygenation,
acidification, and warming, as well as the positive impacts of
increasing food supply, oxygen levels, ocean basification, and cooling.
Conversely, the increase in export POC flux, oxygen levels, ocean
basification, and ocean cooling can be considered cumulative positive
impacts.

``` r
plotmap(r=cum_imp(cmip6_2041_2060_voccMeg) %>% mask(eez), 
         titles=c("Cumul.~negative~impact~(km~yr^-1)", "Cumul.~positivce~impact~(km~yr^-1)"))
```

![](tute2_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

``` r
out <- cmip6_2041_2060_voccMeg %>% cum_imp %>% mask_habitat
out$var <- factor(out$var, labels=c("Cumulative~negative~impact~(km~yr^-1)", "Cumulative~positivce~impact~(km~yr^-1)"))

# Habitat with > 5 data points for violin plot
vio <- with(out, Habitat=="Shelf"|Habitat=="Slope"|Habitat=="Abyss"|Habitat=="Canyon"|Habitat=="Seamount")

ggplot()+
  geom_violin(data=subset(out, vio), aes(x=Habitat, y=value), scale = "width")+
  geom_point(data=subset(out, !vio), aes(x=Habitat, y=value))+
  facet_wrap(~var, scales="free", labeller=label_parsed)+
  labs(y="Cumulative Climate Change Impact")+
  theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust=1))
```

![](tute2_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

# Excercises

- Display climate change hazards from 2081 to 2100 for Taiwan EEZ,
  submarine canyons, seamounts, cold water corals, hydrothermal vents,
  national parks, white dolphin habitat, or offshore windfarms.

- Display cumulative impacts based on climate change hazards from 2081
  to 2100 for Taiwan EEZ, submarine canyons, seamounts, cold water
  corals, hydrothermal vents, national parks, white dolphin habitat, or
  offshore windfarms.

- Display cumulative impacts based on climate velocity magnitudes from
  2081 to 2100 for Taiwan EEZ, submarine canyons, seamounts, cold water
  corals, hydrothermal vents, national parks, white dolphin habitat, or
  offshore windfarms.
