#' Model-average Earliest Time of Emergence based on variability
#'
#' Earliest time of emergence was estimated as the first year when future variability exceeds
#' historical variability.
#'
#' @details
#' Earliest time of emergence was calculated as the first year when the yearly cumulative future standard deviation
#' exceed the historical yearly standard deviation \code{\link{cmip6_1951_2000_sd}}.
#' @docType data
#' @keywords datasets
#' @format A RasterBrick object of 11 raster layers:
#' \describe{
#'   \item{epc_sdtoe_early}{Export POC flux to seafloor}
#'   \item{o2_sdtoe_early}{Dissolved oxygen concentration at seafloor}
#'   \item{ph_sdtoe_early}{pH at seafloor}
#'   \item{thetao_sdtoe_early}{Potential temperature at seafllor}
#'   \item{arag_sdtoe_early}{Aragonite Concentration}
#'   \item{calc_sdtoe_early}{Calcite Concentration}
#'   \item{co3_sdtoe_early}{Mole Concentration of Carbonate expressed as Carbon in Sea Water}
#'   \item{co3satarag_sdtoe_early}{Carbonate ion concentration for seawater in equilibrium with pure aragonite}
#'   \item{co3satcalc_sdtoe_early}{Carbonate ion concentration for seawater in equilibrium with pure calcite}
#'   \item{aragsat_sdtoe_early}{Aragonite Saturation State}
#'   \item{calcsat_sdtoe_early}{Calcite Saturation State}
#' }
#' @source \url{https://esgf-node.llnl.gov/search/esgf-llnl/}
#' @name cmip6_sdtoe_early
#' @examples
#' plotmap(subset(cmip6_sdtoe_early, 1:4))
#'
#' # Overall time of emergence of climate change hazards for export POC flux, dissolved oxygen, pH, and temperature
#' plotmap(overlay(subset(cmip6_sdtoe_early, 1:4), fun=max), titles="Year")
NULL
