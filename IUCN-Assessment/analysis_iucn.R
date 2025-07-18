#install.packages("devtools")
devtools::install_github("gdauby/ConR")
library(ConR)
library(readxl)
library(rnaturalearth)
datos <- read.csv("records_Gustavia_santanderiensis.csv")
datos$SPECIES <- c(rep("Gustavia santanderiensis", nrow(datos)))

EOO.datos <- EOO.computing(XY = datos, method.range = "convex.hull", export_shp = TRUE, show_progress = FALSE)
country_map <- ne_countries(scale = 50)
plot(st_geometry(country_map), extent = EOO.datos$spatial)
plot(EOO.datos$spatial, lwd = 2, col = "red",  add= TRUE)
print(EOO.datos)
#EOO 8731 km2

AOO.datos <- AOO.computing(XY = datos, cell_size_AOO = 2, nbe.rep.rast.AOO = 100, show_progress = FALSE)
print(AOO.datos)
#AOO 80 km2

radius <- subpop.radius(XY = datos, quant.max = 0.9)
radius
sub <- subpop.comp(XY = datos,
                   resol_sub_pop = radius$radius,
                   show_progress = FALSE)
print(sub)
#4 subpopulations

locs <- locations.comp(datos,
                       method = "fixed_grid",
                       nbe_rep = 100,
                       cell_size_locations = 10,
                       rel_cell_size = 0.05,
                       #threat_list = strict.ucs.spdf,
                       #id_shape = "NAME",
                       method_polygons = "no_more_than_one",
                       show_progress = FALSE)
print(locs)
#13 locations

sever.frag <- severe_frag(XY = datos,
                          resol_sub_pop = radius$radius,
                          dist_isolated = radius$radius,
                          show_progress = FALSE,
                          nbe_rep = 100)
print(sever.frag)
#55 frac, severe_frag TRUE

critB <- criterion_B(x = datos,
                     AOO = AOO.datos,
                     EOO = EOO.datos$results,
                     locations = locs$locations,
                     severe.frag = sever.frag,
                     subpops = sub,
                     decline = "Decreasing")
print(critB)