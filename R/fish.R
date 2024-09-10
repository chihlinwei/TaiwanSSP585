#' The Fish Database of Taiwan
#'
#' The Fish Database of Taiwan
#'
#' @details
#' This dataset has compiled 24955 fish occurrence data in Taiwan.
#' @docType data
#' @keywords datasets
#' @format A SpatialPointsDataFrame
#' @source \url{https://www.gbif.org/dataset/b7dd8170-98a0-11de-b4d9-b8a03c50a862}
#' @references GBIF.org (10 September 2024) GBIF Occurrence Download \url{https://doi.org/10.15468/dl.e57g23}
#' @name fish
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
#'   geom_sf(data=as(fish, "sf"), size=0.8)+
#'   scale_fill_gradientn(colours=terrain.colors(7))+
#'   scale_x_continuous(expand = expansion(mult = 0))+
#'   scale_y_continuous(expand = expansion(mult = 0))+
#'   labs(x=NULL, y=NULL, fill="Depth\n(m)")+
#'   theme_bw() %+replace% theme(legend.position = "right", legend.key.width =  unit(0.5, 'cm'))
NULL
