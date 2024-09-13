Download IPCC6 CMIP6 data
================
Chih-Lin Wei
2024-09-13

# GFDL-ESM4

The example potential temperature data from 2015 to 2100 were downloaded
from [Earth System Grid Federation
(ESGF)](https://aims2.llnl.gov/search/?project=CMIP6&resultType=originals+only&activeFacets=%7B%22variable_id%22%3A%22thetao%22%2C%22cf_standard_name%22%3A%22sea_water_potential_temperature%22%2C%22realm%22%3A%22ocean%22%2C%22frequency%22%3A%22mon%22%2C%22table_id%22%3A%22Omon%22%2C%22institution_id%22%3A%22NOAA-GFDL%22%2C%22source_id%22%3A%22GFDL-ESM4%22%2C%22experiment_id%22%3A%22ssp585%22%2C%22variant_label%22%3A%22r1i1p1f1%22%2C%22grid_label%22%3A%22gr%22%2C%22sub_experiment_id%22%3A%22none%22%2C%22nominal_resolution%22%3A%221x1+degree%22%7D)

``` r

# Source file urls
var <- "http://esgdata.gfdl.noaa.gov/thredds/fileServer/gfdl_dataroot4/ScenarioMIP/NOAA-GFDL/GFDL-ESM4/ssp585/r1i1p1f1/Omon/thetao/gr/v20180701/thetao_Omon_GFDL-ESM4_ssp585_r1i1p1f1_gr_"
sta <- paste(seq(2015, 2095, by=20), "01", sep="")
end <- paste(c(seq(2034, 2094, by=20), 2100), "12", sep="")
time <- paste(sta, end, sep="-")
urls <- paste(var, time, ".nc", sep="")

# Path to save the files
destfiles <- paste("C:/Users/user/Downloads/", basename(urls), sep="")
```
