#' A simple plotting function for seafloor climate projections
#'
#' This function is a wrapper of  \code{\link{ggplot2}}
#'
#' @details This is a simple map function to visualize the ensemble average of seafloor climate projections.
#' The Taiwan EEZ boundary is downloaded from \url{https://marineregions.org/gazetteer.php?p=details&id=8321}.
#' The 200-m (dashed line) and 4000-m depth (solid line) contours were drawn using bathymetric data from the
#' \code{\link{etopo2022}}.
#'
#' @returns This function returns a base ggplot object, so other ggplot components can be added.
#'
#' @param r A Raster or RasterBrick object
#' @param titles A character vector string of the map titles
#' @param colours A vector of colors to use for the color key
#' @param ranges A numeric vector of length two providing quantile limits for the color key scale
#' @author Chih-Lin Wei <chihlinwei@@gmail.com>
#' @export
#' @examples
#' basemap(-etopo2022, title="Depth (m)", colours = terrain.colors(7))
#'
basemap <- function(r, title=names(r), colours=NULL, ranges=c(0, 1)){

  # Depth
  bathy <- etopo2022 %>% raster::as.data.frame(xy = TRUE, na.rm = TRUE)
  dat <- r %>% raster::as.data.frame(xy=TRUE, na.rm=TRUE)
  names(dat)[3] <- "layer"

    # Color key limits and colours
    lim1 <- quantile(r, ranges, na.rm=TRUE)
    lim2 <- max(abs(quantile(r, ranges, na.rm=TRUE)))
    # If the raster only have positive values, use sequential color palettes
    if(min(lim1) >= 0) {
      lims <- lim1; cols <- jet.colors2(7)
      # If the raster contains negative values, use diverging color palettes
    } else {
      lims <- c(-lim2, lim2); cols <- jet.colors3(7)}
    # If color pallette is specified, use the specified color palette
    if(is.null(colours)) cols <- cols else cols <- colours

    # Plot raster layer
    ggplot(dat) +
      geom_raster(aes(x=x, y=y, fill=layer))+
      geom_polygon(data=land, aes(x=X, y=Y, group=PID), fill="bisque2", colour="transparent")+
      geom_contour(data=bathy, aes(x=x, y=y, z=layer), breaks=-200, linetype=2, colour="gray50")+
      geom_contour(data=bathy, aes(x=x, y=y, z=layer), breaks=-4000, linetype=1, colour="gray50")+
      geom_sf(data=as(eez, "sf"), fill="transparent", colour="yellow2")+
      scale_fill_gradientn(colours=cols, limits=lims, na.value="white")+
      scale_x_continuous(expand = expansion(mult = 0))+
      scale_y_continuous(expand = expansion(mult = 0))+
      labs(x=NULL, y=NULL, fill=NULL, title=parse(text=title %>% as.character))+
      theme_bw() %+replace% theme(legend.position = "top", legend.key.width =  unit(1, 'cm'), plot.title = element_text(hjust=0.5))
}
