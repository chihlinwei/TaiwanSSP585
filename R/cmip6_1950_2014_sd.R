#' Model-Averaging Decadal Standard deviation of Seafloor Climatic Data during 1950 to 2014
#'
#' Emsemble average of the decadal Standard deviation of seafloor (bottom-most) projections from 1950 to 2014.
#' @details
#' Yearly mean projections from 1950 to 2014 were calculated from each models.
#' Decadal standard deviation was calculated from the yearly mean and then averaged across all models.
#' @docType data
#' @keywords datasets
#' @format A RasterBrick object of 11 raster layers:
#' \describe{
#'   \item{epc_sd_1950_to_2014}{Export POC flux to seafloor (mg C m^-2 d^-1)}
#'   \item{o2_sd_1950_to_2014}{Dissolved oxygen concentration at seafloor (mol m^-3)}
#'   \item{ph_sd_1950_to_2014}{pH at seafloor}
#'   \item{thetao_sd_1950_to_2014}{Potential temperature at seafllor (C)}
#'   \item{arag_sd_1950_to_2014}{Aragonite Concentration (mol m-3)}
#'   \item{calc_sd_1950_to_2014}{Calcite Concentration (mol m-3)}
#'   \item{co3_sd_1950_to_2014}{Mole Concentration of Carbonate expressed as Carbon in Sea Water (mol m-3)}
#'   \item{co3satarag_sd_1950_to_2014}{Carbonate ion concentration for seawater in equilibrium with pure aragonite (mol m-3)}
#'   \item{co3satcalc_sd_1950_to_2014}{Carbonate ion concentration for seawater in equilibrium with pure calcite (mol m-3)}
#'   \item{aragsat_sd_1950_to_2014}{Aragonite Saturation State (omega)}
#'   \item{calcsat_sd_1950_to_2014}{Calcite Saturation State (omega)}
#' }
#' @source \url{https://esgf-node.llnl.gov/search/esgf-llnl/}
#' @name cmip6_1950_2014_sd
#' @examples
#' plotmap(subset(cmip6_1950_2014_sd, 1:4))
NULL
