% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/seamount.R
\docType{data}
\name{seamount}
\alias{seamount}
\title{Global distribution of large seamounts}
\format{
A SpatialPointsDataFrame
}
\source{
\url{https://doi.org/10.1111/j.1365-246X.2011.05076.x}
}
\description{
Global distribution of large seamounts from Kim and Wessel (2011)
}
\details{
This dataset has compiled 24643  separate large seamounts in the world ocean.
}
\examples{
basemap(-etopo2022, title="Depth (m)", colours = terrain.colors(7))+
geom_sf(data=as(seamount, "sf"), size=0.8)
}
\references{
Kim, S.-S., Wessel, P., 2011. New global seamount census from altimetry-derived gravity data.
Geophysical Journal International 186, 615–631.
}
\keyword{datasets}
