#' Model-average Constant Time of Emergence based on exposure to climate change hazard
#'
#' Constant time of emergence was estimated as the first year when climate change constantly
#' (at least 90 percent of the remaining time) exceeds 2 times of historical variability.
#'
#' @details
#' Constant time of emergence was calculated as the first year when the climate change (future - historical)
#' constantly (at least 90 percent of the remaining time) exceed 2 times of the historical yearly standard deviation.
#' @docType data
#' @keywords datasets
#' @format A RasterBrick object of 11 raster layers:
#' \describe{
#'   \item{epc_extoe_constant}{Export POC flux to seafloor}
#'   \item{o2_extoe_constant}{Dissolved oxygen concentration at seafloor}
#'   \item{ph_extoe_constant}{pH at seafloor}
#'   \item{thetao_extoe_constant}{Potential temperature at seafllor}
#'   \item{arag_extoe_constant}{Aragonite Concentration}
#'   \item{calc_extoe_constant}{Calcite Concentration}
#'   \item{co3_extoe_constant}{Mole Concentration of Carbonate expressed as Carbon in Sea Water}
#'   \item{co3satarag_extoe_constant}{Carbonate ion concentration for seawater in equilibrium with pure aragonite}
#'   \item{co3satcalc_extoe_constant}{Carbonate ion concentration for seawater in equilibrium with pure calcite}
#'   \item{aragsat_extoe_constant}{Aragonite Saturation State}
#'   \item{calcsat_extoe_constant}{Calcite Saturation State}
#' }
#' @source \url{https://esgf-node.llnl.gov/search/esgf-llnl/}
#' @name cmip6_extoe_constant
#' @examples
#' plotmap(subset(cmip6_extoe_constant, 1:4))
#'
#' # Overall time of emergence of climate change hazards for export POC flux, dissolved oxygen, pH, and temperature
#' plotmap(overlay(subset(cmip6_extoe_constant, 1:4), fun=max), titles="Year")
NULL
