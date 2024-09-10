#' Global Distribution of Hydrothermal Vents
#'
#' Global Distribution of Hydrothermal Vent Fields (2020)- InterRidge Global Database of Active Submarine Hydrothermal Vent Fields 3.4
#'
#' @details
#' This dataset has compiled 721  separate hythrothermal vent fields in the world ocean.
#' @docType data
#' @keywords datasets
#' @format A SpatialPointsDataFrame
#' @source \url{https://doi.pangaea.de/10.1594/PANGAEA.917894}
#' @references Beaulieu, Stace E; Szafrański, Kamil M (2020): InterRidge Global Database of Active Submarine Hydrothermal Vent Fields Version 3.4 [dataset]. PANGAE.
#' @name vent
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' library(sf)
#'
#' bathy <- etopo2022 %>% as.data.frame(xy = TRUE) %>% na.omit
#' ggplot(bathy) +
#'   geom_raster(aes(x=x, y=y, fill=-layer))+
#'   geom_polygon(data=land, aes(x=X, y=Y, group=PID), fill="bisque2", colour="transparent")+
#'   geom_sf(data=as(eez, "sf"), fill="transparent", colour="red")+
#'   geom_contour(data=bathy, aes(x=x, y=y, z=layer), breaks=-200, linetype=2, colour="gray50")+
#'   geom_contour(data=bathy, aes(x=x, y=y, z=layer), breaks=-4000, linetype=1, colour="gray50")+
#'   geom_sf(data=as(vent, "sf"), size=0.8)+
#'   scale_fill_gradientn(colours=terrain.colors(7))+
#'   scale_x_continuous(expand = expansion(mult = 0))+
#'   scale_y_continuous(expand = expansion(mult = 0))+
#'   labs(x=NULL, y=NULL, fill="Depth\n(m)")+
#'   theme_bw() %+replace% theme(legend.position = "right", legend.key.width =  unit(0.5, 'cm'))
NULL
