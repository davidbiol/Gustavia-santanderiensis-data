# Gustavia-santanderiensis-data
Supplementary data for the manuscript titled: "Morphological redescription and ecological niche model of <i>Gustavia santanderiensis</i> R. Knuth (Lecythidaceae), with a key for the genus in the Magdalena Valley, Colombia"

## Ecological Niche Modeling (ENM)
The ENM was done in the software [R](https://www.r-project.org/) 

### Climatic data
Climatic data from each occurrence record is found in [ClimaticData/gustaviasantanderiensis_CD.csv](ClimaticData/gustaviasantanderiensis_CD.csv)

### Correlation plot
![Correlation variables](Figures/Correlation_variables.png)

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
Fick, S.E. & R.J. Hijmans, 2017. WorldClim 2: new 1km spatial resolution climate surfaces for global land areas. International Journal of Climatology 37 (12): 4302-4315.
R Core Team (2024). R: A Language and Environment for Statistical Computing. R Foundation for Statistical Computing, Vienna, Austria. https://www.R-project.org/


