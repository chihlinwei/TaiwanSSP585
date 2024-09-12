#' Coefficient Variation of the Mean Seafloor Climatic Data during 1950 to 2000 among models
#'
#' Coefficient variation of the decadal mean seafloor (bottom-most) projections among models.
#'
#' @details
#' Yearly mean from 1950 to 2000 were calculated from each models and then the decadal mean was calculated from the yearly mean.
#' Coefficient variation was calculated from the decadal mean across all models.
#' \url{https://esgf-node.llnl.gov/search/esgf-llnl/}.
#' @docType data
#' @keywords datasets
#' @format A RasterBrick object of 11 raster layers:
#' \describe{
#'   \item{epc_cv_1950_to_2000}{Export POC flux to seafloor (\%)}
#'   \item{o2_cv_1950_to_2000}{Dissolved oxygen concentration at seafloor (\%)}
#'   \item{ph_cv_1950_to_2000}{pH at seafloor (\%)}
#'   \item{thetao_cv_1950_to_2000}{Potential temperature at seafllor (\%)}
#'   \item{arag_cv_1950_to_2000}{Aragonite Concentration (\%)}
#'   \item{calc_cv_1950_to_2000}{Calcite Concentration (\%)}
#'   \item{co3_cv_1950_to_2000}{Mole Concentration of Carbonate expressed as Carbon in Sea Water (\%)}
#'   \item{co3satarag_cv_1950_to_2000}{Carbonate ion concentration for seawater in equilibrium with pure aragonite (\%)}
#'   \item{co3satcalc_cv_1950_to_2000}{Carbonate ion concentration for seawater in equilibrium with pure calcite (\%)}
#'   \item{aragsat_cv_1950_to_2000}{Aragonite Saturation State (\%)}
#'   \item{calcsat_cv_1950_to_2000}{Calcite Saturation State (\%)}
#' }
#' @source \url{https://esgf-node.llnl.gov/search/esgf-llnl/}
#' @name cmip6_1950_2000_cv
#' @examples
#' plotmap(subset(cmip6_1950_2000_cv, 1:4))
NULL
