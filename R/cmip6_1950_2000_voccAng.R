#' Model-Averaging of Gradient-based climate velocity angle during 1950 to 2000
#'
#' Ensemble average of the seafloor gradient-based climate velocity angle during 1950 to 2000.
#'
#' @details
#' Gradient-based climate velocity angle from 1950 to 2000 were calculated from each models and then averaged across all models.
#' Climate velocity was calculated using package gVoCC \url{https://rdrr.io/github/JorGarMol/VoCC/man/gVoCC.html}.
#' @docType data
#' @keywords datasets
#' @format A RasterBrick object of 11 raster layers:
#' \describe{
#'   \item{epc_voccAng_1950_to_2000}{Export POC flux to seafloor (degree)}
#'   \item{o2_voccAng_1950_to_2000}{Dissolved oxygen concentration at seafloor (degree)}
#'   \item{ph_voccAng_1950_to_2000}{pH at seafloor (degree)}
#'   \item{thetao_voccAng_1950_to_2000}{Potential temperature at seafllor (degree)}
#'   \item{arag_voccAng_1950_to_2000}{Aragonite Concentration (degree)}
#'   \item{calc_voccAng_1950_to_2000}{Calcite Concentration (degree)}
#'   \item{co3_voccAng_1950_to_2000}{Mole Concentration of Carbonate expressed as Carbon in Sea Water (degree)}
#'   \item{co3satarag_voccAng_1950_to_2000}{Carbonate ion concentration for seawater in equilibrium with pure aragonite (degree)}
#'   \item{co3satcalc_voccAng_1950_to_2000}{Carbonate ion concentration for seawater in equilibrium with pure calcite (degree)}
#'   \item{aragsat_voccAng_1950_to_2000}{Aragonite saturation State (degree)}
#'   \item{calcsat_voccAng_1950_to_2000}{Calcite saturation State (degree)}
#' }
#' @source \url{https://esgf-node.llnl.gov/search/esgf-llnl/}
#' @name cmip6_1950_2000_voccAng
#' @examples
#' plotmap(subset(cmip6_1950_2000_voccAng, 1:4))
NULL
