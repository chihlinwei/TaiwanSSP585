#' Taiwan maritime boundaries
#'
#' Maritime boundaries surrounding Taiwan
#'
#' @details
#' This dataset include maritime boundaries surrounding Taiwan, such as economic exclusive zone (EEZ),
#' national parks (Dongsha Atoll National Park, Kenting National Park, South Penghu Marine National Park,
#' Taijiang National Park), important wildlife habitat (White Dolphin Habitat), and offshore windfarm areas.
#' @docType data
#' @keywords datasets
#' @format A SpatialPolygonsDataFrame
#' @source
#' \itemize{
#' \item{\url{https://marineregions.org/gazetteer.php?p=details&id=8321}}
#' \item{\url{https://iocean.oca.gov.tw/iOceanMap/map.aspx}}
#' }
#' @references
#' \itemize{
#' \item{Flanders Marine Institute (2023). Maritime Boundaries Geodatabase: Maritime Boundaries and Exclusive Economic Zones (200NM), version 12. Available online at \url{http://www.marineregions.org/}. \url{https://doi.org/10.14284/632}}
#' \iten{Ocean Conservation Administration (2024) IOcean: Marine Conservation Network. Available online at \url{https://iocean.oca.gov.tw/OCA_OceanConservation/Default.aspx}.}
#' }
#' @name eez
#' @aliases dongshaatoll
#' @aliases taijiang
#' @aliases whitedolphin
#' @aliases offshorewindplan
#' @examples
#' basemap(-etopo2022, title="Depth (m)", colours = terrain.colors(7))+
#' geom_sf(data=as(dongshaatoll, "sf"), fill = "transparent")+
#' geom_sf(data=as(taijiang, "sf"), fill = "transparent")+
#' geom_sf(data=as(whitedolphin, "sf"), fill = "transparent")+
#' geom_sf(data=as(offshorewindplan, "sf"), fill = "transparent")
NULL
