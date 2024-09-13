#' ETOPO2022 Global Relief Model
#'
#' A RasterBrick of the Global Relief Model. A multi-layer raster object compiled from the Cell/pixel-registered ETOPO1 bedrock global relief model.
#' The grid resolution is reduced from 1 minutes to 0.25 degree by averaging.
#'
#' @docType data
#' @keywords datasets
#' @format A RasterLayer object of water depth
#' @source \url{https://www.ncei.noaa.gov/products/etopo-global-relief-model}
#' @name etopo2022
#' @examples
#' plotmap(-etopo2022, colours=terrain.colors(7), title="Depth (m)")
NULL
