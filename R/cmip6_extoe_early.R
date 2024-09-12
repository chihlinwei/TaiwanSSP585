#' Model-average Earliest Time of Emergence based on exposure to climate change hazard
#'
#' Earliest time of emergence was estimated as the first year when climate change exceeds 2 times of
#' historical variability.
#'
#' @details
#' Earliest time of emergence was calculated as the first year when climate change (future - historical)
#' exceed the historical yearly standard deviation \code{\link{cmip6_1951_2000_sd}}.
#' @docType data
#' @keywords datasets
#' @format A RasterBrick object of 11 raster layers:
#' \describe{
#'   \item{epc_extoe_early}{Export POC flux to seafloor}
#'   \item{o2_extoe_early}{Dissolved oxygen concentration at seafloor}
#'   \item{ph_extoe_early}{pH at seafloor}
#'   \item{thetao_extoe_early}{Potential temperature at seafllor}
#'   \item{arag_extoe_early}{Aragonite Concentration}
#'   \item{calc_extoe_early}{Calcite Concentration}
#'   \item{co3_extoe_early}{Mole Concentration of Carbonate expressed as Carbon in Sea Water}
#'   \item{co3satarag_extoe_early}{Carbonate ion concentration for seawater in equilibrium with pure aragonite}
#'   \item{co3satcalc_extoe_early}{Carbonate ion concentration for seawater in equilibrium with pure calcite}
#'   \item{aragsat_extoe_early}{Aragonite Saturation State}
#'   \item{calcsat_extoe_early}{Calcite Saturation State}
#' }
#' @source \url{https://esgf-node.llnl.gov/search/esgf-llnl/}
#' @name cmip6_extoe_early
#' @examples
#' plotmap(subset(cmip6_extoe_early, 1:4))
#'
#' # Overall time of emergence of climate change hazards for export POC flux, dissolved oxygen, pH, and temperature
#' plotmap(overlay(subset(cmip6_extoe_early, 1:4), fun=max), titles="Year")
NULL
