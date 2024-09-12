#' Model-Averaging of Gradient-based climate velocity magnitude during 2041 to 2060
#'
#' Ensemble average of the seafloor gradient-based climate velocity magnitudes during 2041 to 2060.
#'
#' @details
#' Gradient-based climate velocity magnitude from 2041 to 2060 were calculated from each models and then averaged across all models.
#' Climate velocity was calculated using package gVoCC \url{https://rdrr.io/github/JorGarMol/VoCC/man/gVoCC.html}.
#' @docType data
#' @keywords datasets
#' @format A RasterBrick object of 11 raster layers:
#' \describe{
#'   \item{epc_voccAng_2041_to_2060}{Export POC flux to seafloor (km/yr)}
#'   \item{o2_voccAng_2041_to_2060}{Dissolved oxygen concentration at seafloor (km/yr)}
#'   \item{ph_voccAng_2041_to_2060}{pH at seafloor (km/yr)}
#'   \item{thetao_voccAng_2041_to_2060}{Potential temperature at seafllor (km/yr)}
#'   \item{arag_voccAng_2041_to_2060}{Aragonite Concentration (km/yr)}
#'   \item{calc_voccAng_2041_to_2060}{Calcite Concentration (km/yr)}
#'   \item{co3_voccAng_2041_to_2060}{Mole Concentration of Carbonate expressed as Carbon in Sea Water (km/yr)}
#'   \item{co3satarag_voccAng_2041_to_2060}{Carbonate ion concentration for seawater in equilibrium with pure aragonite (km/yr)}
#'   \item{co3satcalc_voccAng_2041_to_2060}{Carbonate ion concentration for seawater in equilibrium with pure calcite (km/yr)}
#'   \item{aragsat_voccAng_2041_to_2060}{Aragonite saturation State (km/yr)}
#'   \item{calcsat_voccAng_2041_to_2060}{Calcite saturation State (km/yr)}
#' }
#' @source \url{https://esgf-node.llnl.gov/search/esgf-llnl/}
#' @name cmip6_2041_2060_voccMeg
#' @examples
#' plotmap(subset(cmip6_2041_2060_voccMeg, 1:4))
NULL
