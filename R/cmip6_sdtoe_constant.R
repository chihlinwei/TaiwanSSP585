#' Model-average Constant Time of Emergence based on variability
#'
#' Constant time of emergence was estimated as the first year when future variability constantly
#' (at least 90 percent of the remaining time) exceeding historical variability.
#'
#' @details
#' Constant time of emergence was calculated as the first year when the yearly cumulative future standard deviation
#' constantly (at least 90 percent of the remaining time) exceed the historical yearly standard deviation.
#' @docType data
#' @keywords datasets
#' @format A RasterBrick object of 11 raster layers:
#' \describe{
#'   \item{epc_sdtoe_constant}{Export POC flux to seafloor}
#'   \item{o2_sdtoe_constant}{Dissolved oxygen concentration at seafloor}
#'   \item{ph_sdtoe_constant}{pH at seafloor}
#'   \item{thetao_sdtoe_constant}{Potential temperature at seafllor}
#'   \item{arag_sdtoe_constant}{Aragonite Concentration}
#'   \item{calc_sdtoe_constant}{Calcite Concentration}
#'   \item{co3_sdtoe_constant}{Mole Concentration of Carbonate expressed as Carbon in Sea Water}
#'   \item{co3satarag_sdtoe_constant}{Carbonate ion concentration for seawater in equilibrium with pure aragonite}
#'   \item{co3satcalc_sdtoe_constant}{Carbonate ion concentration for seawater in equilibrium with pure calcite}
#'   \item{aragsat_sdtoe_constant}{Aragonite Saturation State}
#'   \item{calcsat_sdtoe_constant}{Calcite Saturation State}
#' }
#' @source \url{https://esgf-node.llnl.gov/search/esgf-llnl/}
#' @name cmip6_sdtoe_constant
#' @examples
#' plotmap(subset(cmip6_sdtoe_constant, 1:4))
#'
#' # Overall time of emergence of climate change hazards for export POC flux, dissolved oxygen, pH, and temperature
#' plotmap(overlay(subset(cmip6_sdtoe_constant, 1:4), fun=max), titles="Year")
NULL
