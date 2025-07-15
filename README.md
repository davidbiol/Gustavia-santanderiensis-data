# Gustavia-santanderiensis-data
Supplementary data for the manuscript titled: "Morphological redescription and ecological niche model of <i>Gustavia santanderiensis</i> R. Knuth (Lecythidaceae), with a key for the genus in the Magdalena Valley, Colombia"

## Ecological Niche Modeling (ENM)
To construct the Ecological Niche Model (ENM), occurrence records for the species and 19 bioclimatic variables available from the [Worldclim](https://www.worldclim.org/data/worldclim21.html) database were used. Occurrence records were filtered to retain only one record per square kilometer and then partitioned into [joint](ENM/gustavia_joint.csv), [train](ENM/gustavia_train.csv), and [test](ENM/gustavia_test.csv) dataset. The bioclimatic variables were refined through a [correlation analysis](Figures/Correlation_variables.png). The accessible area (M) was delineated by intersecting species occurrence records with the ecoregions covering the Magdalena Valley [M_variables](ENM/M_variables/Set_1). The projection area (M) was constructed using the Northwest Andean montane forests and Chocó-Darién moist forests ecoregions [G_variables](ENM/G_variables/Set_1).

The ENM was built using the maximum entropy algorithm via the KUENM package (Cobos et al. 2019). The model was generated using a unique [set of bioclimatic variables](ENM/M_variables/Set_1) and the partitioned ocurrences records, and was calibrated with 15 regularization multipliers (0.1–1 at intervals of 0.1, and 2–5 at intervals of 1) and seven combinations of feature classes (l = linear, q = quadratic, and p = product features).

All analysis was done in the software [R](https://www.r-project.org/) 

### Climatic data
Climatic data from each occurrence record is found in [ClimaticData/gustaviasantanderiensis_CD.csv](ClimaticData/gustaviasantanderiensis_CD.csv)

### Phenology
The phenological data were obtained from all fertile examined specimens and categorized as flowering, fruiting, or both, and graphed in the statistical software R (R Core Team, 2024). 

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

---
## References

Cobos, M. E., Peterson, A. T., Barve, N., & Osorio-Olvera, L. (2019). kuenm: an R package for detailed development of ecological niche models using Maxent. PeerJ, 7, e6281. https://doi.org/10.7717/peerj.6281

Dinerstein, Eric; Olson, David; Joshi, Anup; Vynne, Carly; and Burgess, Neil D., "An Ecoregion-Based Approach To Protecting Half The Terrestrial Realm". (2017). Scopus Export 2015-2019. 7271. https://stars.library.ucf.edu/scopus2015/7271

Fick, S.E. & R.J. Hijmans, 2017. WorldClim 2: new 1km spatial resolution climate surfaces for global land areas. International Journal of Climatology 37 (12): 4302-4315.

R Core Team (2024). R: A Language and Environment for Statistical Computing. R Foundation for Statistical Computing, Vienna, Austria. https://www.R-project.org/


