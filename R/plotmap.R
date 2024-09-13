#' A simple plotting function for multi-panel maps with independent color keys
#'
#' This function is a wrapper of  \code{\link{ggplot2}} and \code{\link[patchwork]{wrap_plots}}
#'
#' @details This is a simple map function to visualize multiple ensemble average of seafloor climate projections.
#' First, the RasterBrick containing climate projections is subseted and converted into a data frame. Next, we
#' stack the data frame using the \code{\link[tidyr]{gather}} and \code{\link[tidyr]{group_split}} into a list.
#' The Taiwan EEZ boundary is downloaded from \url{https://marineregions.org/gazetteer.php?p=details&id=8321}.
#' The 200-m (dashed line) and 4000-m depth (solid line) contours were drawn using bathymetric data from the
#' \code{\link{etopo2022}}. We create multipanel maps using \code{\link{ggplot2}} with each panel corresponding
#' to a variable to ensure independent color keys. Finally, we wrap the ggplot list using \code{\link[patchwork]{wrap_plots}}.
#'
#' @param r A Raster or RasterBrick object
#' @param titles A character vector string of the map titles
#' @param colours A vector of colors to use for the color key
#' @param ranges A numeric vector of length two providing quantile limits for the color key scale
#' @author Chih-Lin Wei <chihlinwei@@gmail.com>
#' @export
#' @examples
#' plotmap(cmip6_1950_2000_av %>% subset(1:4))
#'
plotmap <- function(r, titles=names(r), colours=NULL, ranges=c(0, 1)){

  # Convert raster to data frame and then to list
  cmip6 <- raster::as.data.frame(r, xy = TRUE, na.rm = TRUE) %>%
    gather(-x, -y, key = "var", value = "value", factor_key = TRUE)
  cmip6$var <- factor(cmip6$var, labels = titles)
  cmip6_list <- cmip6 %>% group_split(var)

  # Depth
  bathy <- etopo2022%>% raster::as.data.frame(xy = TRUE, na.rm = TRUE)

  # ggolot list
  gg_list = lapply(cmip6_list, function(dat) {

    # Color key limits and colours
    lim1 <- quantile(dat$value, ranges, na.rm=TRUE)
    lim2 <- max(abs(quantile(dat$value, ranges, na.rm=TRUE)))
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
      geom_raster(aes(x=x, y=y, fill=value))+
      geom_polygon(data=land, aes(x=X, y=Y, group=PID), fill="bisque2", colour="transparent")+
      geom_sf(data=as(eez, "sf"), fill="transparent", colour="yellow2")+
      geom_contour(data=bathy, aes(x=x, y=y, z=layer), breaks=-200, linetype=2, colour="gray50")+
      geom_contour(data=bathy, aes(x=x, y=y, z=layer), breaks=-4000, linetype=1, colour="gray50")+
      scale_fill_gradientn(colours=cols, limits=lims, na.value="white")+
      scale_x_continuous(expand = expansion(mult = 0))+
      scale_y_continuous(expand = expansion(mult = 0))+
      labs(x=NULL, y=NULL, fill=NULL, title=parse(text=dat$var[1] %>% as.character))+
      facet_wrap(~ var) +
      theme_bw() %+replace% theme(legend.position = "top", legend.key.width =  unit(1, 'cm'), plot.title = element_text(hjust=0.5), strip.background = element_blank(), strip.text = element_blank())
  })

  # Wrap ggplot list
  wrap_plots(gg_list)
}
