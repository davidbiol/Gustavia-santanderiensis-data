# Gustavia-santanderiensis-data
Supplementary data for the manuscript titled: "Morphological redescription and ecological niche modeling of Gustavia santanderiensis R. Knuth (Lecythidaceae), with the first key for the genus in the Magdalena Valley, Colombia"

## Ecological Niche Modeling (ENM)
To construct the Ecological Niche Model (ENM), occurrence records for the species and 19 bioclimatic variables available from the [Worldclim](https://www.worldclim.org/data/worldclim21.html) database were used. Occurrence records were filtered to retain only one record per square kilometer and then partitioned into [joint](ENM/gustavia_joint.csv), [train](ENM/gustavia_train.csv), and [test](ENM/gustavia_test.csv) dataset. The bioclimatic variables were refined through a [correlation analysis](Figures/Correlation_variables.png). The accessible area (M) was delineated by intersecting species occurrence records with the ecoregions (Dinerstein et al. 2017) covering the Magdalena Valley [(M_variables)](ENM/M_variables/Set_1). The projection area (M) ##Sería M O G?## was constructed using the Northwest Andean montane forests and Chocó-Darién moist forests ecoregions [(G_variables)](ENM/G_variables/Set_1).

The ENM was built using the maximum entropy algorithm via the KUENM package (Cobos et al. 2019). The model was generated using a unique [set](ENM/M_variables/Set_1) of bioclimatic variables and the partitioned ocurrences records, and was calibrated with 15 regularization multipliers (0.1–1 at intervals of 0.1, and 2–5 at intervals of 1) and seven combinations of feature classes (l = linear, q = quadratic, and p = product features). Details of the MOP analysis can be found in  [MOP_results](ENM/MOP_results).

All analyses were conducted using the software [R](https://www.r-project.org/) (R Core Team, 2024). 

### Climatic data for species occurrences
Climatic data from each occurrence record is found in [ClimaticData/gustaviasantanderiensis_CD.csv](ClimaticData/gustaviasantanderiensis_CD.csv)

## Phenology
The phenological data were obtained from all fertile examined specimens and categorized as flowering, fruiting, or both, and graphed in the statistical software [R](https://www.r-project.org/) (R Core Team, 2024). 

```
library(ggplot2)
library(tidyr)
library(dplyr)

windowsFonts(Times=windowsFont("Times New Roman"))

data <- read_excel("data_phe.xlsx")
str(data)
data$Month = factor(data$Month, levels= c("Jan", "Feb", "Mar", "Apr", "May",
                                          "Jun", "Jul", "Aug", "Sep", "Nov", "Dec"))
data$Phenology = factor(data$Phenology, levels= c("Flower","Fruit"))

ggplot(data, aes(x = Month, y = Records, fill = Phenology)) +
  geom_bar(stat = "identity", position = "stack") +
  coord_polar(start = 0) +
  scale_fill_manual(values = c("orchid2", "#8B7355")) +
  theme_minimal()+ theme(text=element_text(family="Times",size=14))
```

## Preliminary IUCN Red List assessment
The preliminary IUCN Red List assessment of the Extent of occurrence (EOO) and area of occupancy (AOO) was estimated based on the geographical data from the specimens, using the ConR v.2.1 R package ([Dauby and de Lima 2024](https://github.com/gdauby/ConR)). We used the Convex Hull method to compute EOO, setting 2 × 2 km grid cells. This grid was randomly overlaid 100 times to calculate AOO. The IUCN Red List category for the species was assessed following the guidelines of the International Union for Conservation of Nature v.16 (IUCN 2024). 
The code for this analysis can be found in [IUCN-Assessment/analysis_iucn.R](IUCN-Assessment/analysis_iucn.R)

### Extent of Occurrence (EOO)
```
EOO.datos <- EOO.computing(XY = datos, method.range = "convex.hull", export_shp = TRUE, show_progress = FALSE)
country_map <- ne_countries(scale = 50)
plot(st_geometry(country_map), extent = EOO.datos$spatial)
plot(EOO.datos$spatial, lwd = 2, col = "red",  add= TRUE)
print(EOO.datos)
#EOO 8731 km2
```
The EEO estimated for the species was **8731 km2** .

### Area of Occupancy (AOO)
```
AOO.datos <- AOO.computing(XY = datos, cell_size_AOO = 2, nbe.rep.rast.AOO = 100, show_progress = FALSE)
print(AOO.datos)
#AOO 80 km2
```
The AOO estimated for the species was **80 km2** .

### Number of subpopulations
```
radius <- subpop.radius(XY = datos, quant.max = 0.9)
radius
sub <- subpop.comp(XY = datos,
                   resol_sub_pop = radius$radius,
                   show_progress = FALSE)
print(sub)
#4 subpopulations
```
First, the radius is calculated in order to estabilsh the distance between subpopulations. After that, the number of subpopulations are estimated, giving **four subpopulations**.

### Fragmentation
```
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
```
The number of localities is estimated. With the previous data of radius between subpopulations and the number of localities, the degree of fragmentation is estimated. The result was **severely fragmented**.

### IUCN Criteria assessment
```
critB <- criterion_B(x = datos,
                     AOO = AOO.datos,
                     EOO = EOO.datos$results,
                     locations = locs$locations,
                     severe.frag = sever.frag,
                     subpops = sub,
                     decline = "Decreasing")
print(critB)
#                       tax  EOO AOO locations nbe_unique_occs category_B category_B_code subpop severe_frag issue_aoo issue_eoo issue_locations main_threat
# Gustavia santanderiensis 8731  80        13              24         EN            B2ab      4        TRUE        NA        NA              NA        <NA>
```
Finally, the data obtained from EOO, AOO, number of subpopulations, number of localities, degree of fragmentation and threats is used to estimate the preliminary IUCN Red list assessment for *Gustavia santanderiensis* as **Endangered (EN)**.

---
## References

Cobos, M. E., Peterson, A. T., Barve, N., & Osorio-Olvera, L. (2019). kuenm: an R package for detailed development of ecological niche models using Maxent. PeerJ, 7, e6281. https://doi.org/10.7717/peerj.6281

Dinerstein, E., Olson, D., Joshi, A., Vynne, C., & Burgess, N. D. (2017). An Ecoregion-Based Approach To Protecting Half The Terrestrial Realm. Scopus Export 2015-2019. 7271. https://stars.library.ucf.edu/scopus2015/7271

Fick, S.E. & R.J. Hijmans, 2017. WorldClim 2: new 1km spatial resolution climate surfaces for global land areas. International Journal of Climatology 37 (12): 4302-4315.

R Core Team (2024). R: A Language and Environment for Statistical Computing. R Foundation for Statistical Computing, Vienna, Austria. https://www.R-project.org/


