# Gustavia-santanderiensis-data
Supplementary data from the manuscript "Morphological redescription and ecological niche model of <i>Gustavia santanderiensis</i> R. Knuth (Lecythidaceae), with a key for the genus in the Magdalena Valley, Colombia"

## Ecological Niche Modeling (ENM)
The ENM was done in the software [R](https://www.r-project.org/)

### Climatic data
Climatic data from each occurrence record is found in [ClimaticData/gustaviasantanderiensis_CD.csv](ClimaticData/gustaviasantanderiensis_CD.csv)

### Correlation plot
![Correlation variables](Figures/Correlation_variables.png)

### Phenology
The phenological data were obtained from all fertile examined specimens and categorized as flowering, fruiting, or both, and graphed in the package MonographaR v.1.3.1 (Reginato, 2016) in the statistical software R (R Core Team, 2024). 

```
install.packages("monographaR", dependencies=T)
library(monographaR)
library(readxl)
datos_pheno <- read_excel("phenology_data.xlsx")
phenoHist(as.data.frame(datos_pheno), shrink=0.5, axis.cex=1.2, title.cex=0, 
          pdf=F, height=15, width=15, flower.col = NULL, flower.border = "magenta", 
          fruit.col = "green4", fruit.border = "green3")
```

---
## References


R Core Team (2024). R: A Language and Environment for Statistical Computing. R Foundation for Statistical Computing, Vienna, Austria. https://www.R-project.org/
Reginato, M. (2016). monographaR: an R package to facilitate the production of plant taxonomic monographs. Brittonia 68(2): 212-216


